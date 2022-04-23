
#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Foundation

struct Text2 : View {
  internal init(_ text: String) {
    self.text = text
  }
  
  let text : String
  func doPrint() {
    Swift.print(text)
  }
  
  
}

@available(macOS 10.15, *)
public protocol ReactiveTerminal {
  associatedtype Body : View
  init ()
  @ViewBuilder var body: Self.Body { get }
}
 
enum Helpers {
  static func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }
}
@available(macOS 10.15, *)
public extension ReactiveTerminal {
  
  static func main () {
    
//    for i in 0..<16 {
//      for j in 0..<16 {
//
//            let code = "\(i * 16 + j)"
//        Self.escapeWith(code: "[38;5;\(code)m")
//        print(code, terminator: " ")
//
//        escapeWith(code: "[0m")
//      }
//    }
//    for i in range(0, 16):
//        for j in range(0, 16):
//            code = str(i * 16 + j)
//            sys.stdout.write(u"\u001b[38;5;" + code + "m " + code.ljust(4))
//        print u"\u001b[0m"
    let app = Self.init()
    let subscription = Timer.publish(every: 1.0, on: .main, in: .default)
      .autoconnect()
      .sink { _ in
        Helpers.escapeWith(code: "[2J")
        Helpers.escapeWith(code: "[0;0H")
        app.body.doPrint()
      }

    withExtendedLifetime(subscription) {
      RunLoop.current.run()
    }
  }
}



@available(macOS 10.12, *)
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

@available(macOS 10.12, *)
extension TerminalController where Window == StandardOutputWindow {
  public convenience init(content: Content) {
    self.init(window: StandardOutputWindow(), content: content)
  }
}
