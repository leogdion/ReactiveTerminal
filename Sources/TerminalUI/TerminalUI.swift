import Foundation

public protocol TaskDelegate: AnyObject {
  func taskUpdated(_ task: Task)
}

public protocol TaskCollectionDelegate: AnyObject {
  func tasks(_ collection: TaskCollection, updatedFromSource source: Any?)
}

public class Task {
  public init(id: UUID, name: String, speed: TimeInterval = 1.0) {
    self.id = id
    self.name = name
    self.speed = speed
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
      self.progress += 1.0
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

  public let tasks: [Task]
}

public struct TerminalUI {
  var text = "Hello, World!"

  public init() {}

  func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }

  public func execute() {
    var progress = 0.0
    while progress <= 100 {
      print("Progress: \(progress)")
      escapeWith(code: "[1A")
      escapeWith(code: "[2K")
      sleep(1)
      progress += 1
    }
  }
}
