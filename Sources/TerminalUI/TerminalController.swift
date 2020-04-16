#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Foundation

public class TerminalController<Stream: TextOutputStream> {
  public private(set) var windowSize = winsize()
  private var shouldKeepRunning = true
  private var stream: Stream
  private var timer: Timer!
  private let runLoop = RunLoop.current
  let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)

  public init(stream: Stream) {
    // fdopen(FileHandle.standardInput.fileDescriptor, <#T##UnsafePointer<Int8>!#>)
    _ = ioctl(STDOUT_FILENO, WindowSize, &windowSize)
    self.stream = stream
    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
      self.draw()

    })
    sigwinchSrc.setEventHandler {
      if ioctl(STDOUT_FILENO, WindowSize, &self.windowSize) == 0 {
        self.draw()
      }
    }
    self.timer = timer
    runLoop.add(timer, forMode: .common)
  }

  public func run() {
    sigwinchSrc.resume()
    while shouldKeepRunning == true,
      runLoop.run(mode: .default, before: .distantFuture) {}
    timer.invalidate()
  }

  public func draw() {
    stream.escapeWith(code: "[r")
    stream.escapeWith(code: "[2J")

    let border: String = String([Character].init(repeating: Character("-"), count: Int(windowSize.ws_col)))
    let sides = "-" + String([Character].init(repeating: Character("0"), count: Int(windowSize.ws_col - 2))) + "-"
    let body = [String](repeating: sides, count: Int(windowSize.ws_row - 2)).joined(separator: "")
    print(border, terminator: "", to: &stream)
    print(body, terminator: "", to: &stream)
    print(border, terminator: "", to: &stream)
    stream.escapeWith(code: "[f")
    stream.escapeWith(code: "[?25l")
    fflush(stdout)
  }
}

extension TerminalController where Stream == StandardOutputStream {
  public convenience init() {
    self.init(stream: StandardOutputStream())
  }
}
