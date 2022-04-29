import Foundation

#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

public struct StandardInputStream {
  let term : termios
  let fileHandle : FileHandle
  
  
  
  init () {
    fileHandle = FileHandle.standardInput
    term = Self.enableRawMode(fileHandle: fileHandle)   
  }
  func beginRead () -> UInt8? {
    var char: UInt8 = 0
    
    read(fileHandle.fileDescriptor, &char, 1)
    
    return char == 0 ? nil : char
  }
  
  func restore () {
    Self.restoreRawMode(fileHandle: fileHandle, originalTerm: term)
  }
  
  static func initStruct<S>() -> S {
      let struct_pointer = UnsafeMutablePointer<S>.allocate(capacity: 1)
      let struct_memory = struct_pointer.pointee
      struct_pointer.deallocate()
      return struct_memory
  }
  
  static func enableRawMode(fileHandle: FileHandle) -> termios {
      var raw: termios = initStruct()
      tcgetattr(fileHandle.fileDescriptor, &raw)

      let original = raw

      raw.c_lflag &= ~(UInt(ECHO | ICANON))
      tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &raw);

      return original
  }
  
  static func restoreRawMode(fileHandle: FileHandle, originalTerm: termios) {
      var term = originalTerm
      tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &term);
  }
}

struct AnyInput : Hashable {
  static func == (lhs: AnyInput, rhs: AnyInput) -> Bool {
    lhs.wrapped.id == rhs.wrapped.id
  }
  
  func hash(into hasher: inout Hasher) {
    self.wrapped.id.hash(into: &hasher)
  }
  
  var hashValue: Int {
    self.wrapped.id.hashValue
  }
  
  let wrapped : Input
}

extension View {
  func getInputs () -> [Input] {
    
    var newInputs = [Input]()
    if let input = self as? Input {
      newInputs.append(input)
    } else if let collection = self as? CollectionView {
      newInputs.append(contentsOf:
      collection.views.flatMap { child in
        child.getInputs()
      }
                       )
    } else if let container = self as? ContainerView {
      newInputs.append(contentsOf: container.child.getInputs())
    }
    return newInputs
  }
}
public class StandardOutputWindow: TerminalWindow {
  var output = StandardOutputStream()
  let input = StandardInputStream()
  let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)

  var focusedInputIndex : Int?
  var inputs : [AnyInput] = []
  
  var focusedInput : Input? {
    guard let index = focusedInputIndex else {
      return nil
    }
    guard self.inputs.indices.contains(index) else {
      return nil
    }
    return self.inputs[index].wrapped
  }
  public init() {
    var winsizeObj = winsize()
    if ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj) == 0 {
      windowSize = WindowSize(winsize: winsizeObj)
    }

    sigwinchSrc.setEventHandler {
      var winsizeObj = winsize()
      if ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj) == 0 {
        self.windowSize = WindowSize(winsize: winsizeObj)
      }
    }
  }
  
  public func read() {
    if let value = input.beginRead() {
      if value == 9 && self.inputs.count > 0 {
        if let lastIndex = self.focusedInputIndex {
          self.focusedInputIndex = (lastIndex + 1).remainderReportingOverflow(dividingBy: self.inputs.count).partialValue
        } else {
          self.focusedInputIndex = 0
        }
      } else if let focusedInput = focusedInput {
        focusedInput.put(value)
      }
    }
  }
  
  public func loadInputs(_ view: View) {
    let newInputs = view.getInputs()
    let anyInputs = newInputs.map(AnyInput.init(wrapped:))
    
    self.inputs = [AnyInput](Set(self.inputs + anyInputs))
    
   
    if !self.inputs.isEmpty, focusedInputIndex == nil {
      focusedInputIndex = 0
    }
  }

  public func clear() {
    output.escapeWith(code: "[2J")
  }

  public func flush() {
    output.flush()
  }

  public func hideCursor() {
    output.escapeWith(code: "[?25l")
  }
  
  public func escapeWith(code: String) {
    output.escapeWith(code: code)
  }

  public func write(_ string: String) {
    output.write(string)
  }
  public func move(to position: Position) {
    output.escapeWith(code: "[\(position.y);\(position.x)H")
  }
  
  public func put(character: Character, at position: Position) {
    output.escapeWith(code: "[\(position.y);\(position.x)H")
    output.write(String(character))
  }

  public var windowSize: WindowSize?

  public func initialize() {
    sigwinchSrc.resume()
  }
  
  deinit{
    self.input.restore()
  }
}
