#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Foundation

public class TerminalController<Stream: TextOutputStream, Content: TerminalContent> {
  public private(set) var windowSize = winsize()
  private var shouldKeepRunning = true
  private var stream: Stream
  private let content: Content
  private var timer: Timer!
  private let runLoop = RunLoop.current
  let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)

  public init(stream: Stream, content: Content) {
    // fdopen(FileHandle.standardInput.fileDescriptor, <#T##UnsafePointer<Int8>!#>)
    _ = ioctl(STDOUT_FILENO, WindowSizeAttribute, &windowSize)
    self.stream = stream
    self.content = content
    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
      self.draw()

    })
    sigwinchSrc.setEventHandler {
      if ioctl(STDOUT_FILENO, WindowSizeAttribute, &self.windowSize) == 0 {
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

    content.write(to: &stream, within: WindowSize(winsize: windowSize))
    stream.escapeWith(code: "[f")
    stream.escapeWith(code: "[?25l")

    fflush(stdout)
  }
}

extension TerminalController where Stream == StandardOutputStream {
  public convenience init(content: Content) {
    self.init(stream: StandardOutputStream(), content: content)
  }
}
