#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Foundation

public protocol TerminalView {
  func hideCursor()
  func put(character: Character, at position: Position)
  var windowSize: WindowSize { get }
}

public protocol TerminalWindow: TerminalView {
  func clear()
  func flush()
  func initialize()
}

public class TerminalController<Window: TerminalWindow, Content: TerminalContent> {
  private var shouldKeepRunning = true
  private var window: Window
  private let content: Content
  private let runLoop = RunLoop.current

  private var timer: Timer!
  public init(window: Window, content: Content) {
    // fdopen(FileHandle.standardInput.fileDescriptor, <#T##UnsafePointer<Int8>!#>)

    self.window = window
    self.content = content
    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
      self.draw()

    })

    self.timer = timer
    runLoop.add(timer, forMode: .common)
  }

  public func run() {
    window.initialize()
    while shouldKeepRunning == true,
      runLoop.run(mode: .default, before: .distantFuture) {}
    timer.invalidate()
  }

  public func draw() {
    // stream.escapeWith(code: "[r")
    window.clear()
    // stream.escapeWith(code: "[2J")

    content.render(to: &window)
    // content.write(to: &stream, within: WindowSize(winsize: windowSize))
    // stream.escapeWith(code: "[f")
    window.hideCursor()
    // stream.escapeWith(code: "[?25l")

    window.flush()
  }
}

public class StandardOutputWindow: TerminalWindow {
  var stream = StandardOutputStream()
  let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)

  public init() {
    var winsizeObj = winsize()
    _ = ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj)
    windowSize = WindowSize(winsize: winsizeObj)

    sigwinchSrc.setEventHandler {
      var winsizeObj = winsize()
      if ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj) == 0 {
        self.windowSize = WindowSize(winsize: winsizeObj)
      }
    }
  }

  public func clear() {
    stream.escapeWith(code: "[2J")
  }

  public func flush() {
    fflush(stdout)
  }

  public func hideCursor() {
    stream.escapeWith(code: "[?25l")
  }

  public func put(character: Character, at position: Position) {
    stream.escapeWith(code: "[\(position.y);\(position.x)H")
    stream.write(String(character))
  }

  public var windowSize: WindowSize

  public func initialize() {
    sigwinchSrc.resume()
  }
}

extension TerminalController where Window == StandardOutputWindow {
  public convenience init(content: Content) {
    self.init(window: StandardOutputWindow(), content: content)
  }
}
