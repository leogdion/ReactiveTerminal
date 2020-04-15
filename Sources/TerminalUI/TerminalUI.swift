import Foundation

#if os(Linux)
  import Glibc
  // swiftlint:disable:next identifier_name
  let WindowSize = UInt(TIOCGWINSZ)
#else
  // swiftlint:disable:next identifier_name
  let WindowSize = TIOCGWINSZ
  import Darwin
#endif

public protocol TaskDelegate: AnyObject {
  func taskUpdated(_ task: Task)
}

public protocol TaskCollectionDelegate: AnyObject {
  func tasks(_ collection: TaskCollection, updatedFromSource source: Any?)
}

public class Task {
  public init(id: UUID? = nil, name: String? = nil, speed: TimeInterval? = nil) {
    self.id = id ?? UUID()
    self.name = name ?? TaskName.shared.generate()
    self.speed = speed ?? Double.random(in: 0.5 ... 5.0)
  }

  public let id: UUID
  public let name: String
  public let speed: TimeInterval
  public var progress: Double = 0.0 {
    didSet {
      self.delegate?.taskUpdated(self)
    }
  }

  public private(set) var timer: Timer?
  public weak var delegate: TaskDelegate?

  public func start() {
    let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
      self.progress = min(100.0, self.progress + 0.1)
      if self.progress >= 100.0 {
        self.timer?.invalidate()
        self.timer = nil
      }
    }
    self.timer = timer
  }
}

public class TaskCollection: TaskDelegate {
  public weak var delegate: TaskCollectionDelegate?
  public func taskUpdated(_ task: Task) {
    delegate?.tasks(self, updatedFromSource: task)
  }

  public init(tasks: [Task]) {
    self.tasks = tasks
    for task in tasks {
      task.delegate = self
    }
  }

  public convenience init(count: Int) {
    let tasks = (0 ..< count).map { _ in
      Task()
    }

    self.init(tasks: tasks)
  }

  public let tasks: [Task]
}

extension TaskCollection {
  public func start() {
    delegate?.tasks(self, updatedFromSource: nil)
    for task in tasks {
      task.start()
    }
  }

  public var progress: Double {
    return tasks.map { $0.progress }.reduce(0, +) / Double(tasks.count)
  }
}

public class TerminalUI: TaskCollectionDelegate {
  var windowSize = winsize()
  fileprivate func printData(_ collection: TaskCollection) {
    escapeWith(code: "[2J")
    escapeWith(code: "[0;0H")
    print()
    print("  Welcome to this Demo of TerminalUI!")
    print()
    print("  Here is a sample progress bar:")
    print([String](repeating: "-", count: Int(windowSize.ws_col)).joined(separator: ""))
    let length = (collection.tasks.map { $0.name }.map { $0.count }.max() ?? 0) + 1
    for task in collection.tasks {
      let paddedName = task.name.padding(toLength: length, withPad: " ", startingAt: 0)

      let paddedProgress = String(
        String(
          "\(round(task.progress * 10.0) / 10.0)%".reversed()
        ).padding(toLength: 8, withPad: " ", startingAt: 0).reversed())
      print("\t", paddedName, paddedProgress)
    }
    print([String](repeating: "=", count: Int(windowSize.ws_col)).joined(separator: ""))
    let paddedName = "Total".padding(toLength: length, withPad: " ", startingAt: 0)
    let paddedProgress = String(
      String(
        "\(round(collection.progress * 10.0) / 10.0)%".reversed()
      ).padding(toLength: 8, withPad: " ", startingAt: 0).reversed())
    print("\t", paddedName, paddedProgress)
    print([String](repeating: "-", count: Int(windowSize.ws_col)).joined(separator: ""))
    if collection.progress >= 100.0 {
      shouldKeepRunning = false
    }
  }

  public func tasks(_ collection: TaskCollection, updatedFromSource _: Any?) {
    printData(collection)
  }

  func refresh() {
    if ioctl(STDOUT_FILENO, WindowSize, &windowSize) == 0 {
      printData(collection)
    }
  }

  var shouldKeepRunning = true
  var semaphore = DispatchSemaphore(value: 0)
  var text = "Hello, World!"
  let runLoop = RunLoop.current
  let collection = TaskCollection(count: 10)
  public init() {
    _ = ioctl(STDOUT_FILENO, WindowSize, &windowSize)
    let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)
    sigwinchSrc.setEventHandler {
      self.refresh()
    }
    sigwinchSrc.resume()
  }

  func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }

  public func execute() {
    collection.delegate = self
    collection.start()
    while shouldKeepRunning == true,
      runLoop.run(mode: .default, before: .distantFuture) {}
//    var progress = 0.0
//    while progress <= 100 {
//      print("Progress: \(progress)")
//      escapeWith(code: "[1A")
//      escapeWith(code: "[2K")
//      sleep(1)
//      progress += 1
//    }
  }
}
