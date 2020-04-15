import Foundation

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
      self.progress = min(100.0, self.progress + 1.0)
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
    for task in tasks {
      task.start()
    }
  }

  public var progress: Double {
    return tasks.map { $0.progress }.reduce(0, +) / Double(tasks.count)
  }
}

public class TerminalUI: TaskCollectionDelegate {
  public func tasks(_ collection: TaskCollection, updatedFromSource source: Any?) {
    print(collection.progress, (source as? Task)?.name ?? "")
    if collection.progress >= 100.0 {
      RunLoop.current.cancelPerformSelectors(withTarget: self)
    }
  }

  var semaphore = DispatchSemaphore(value: 0)
  var text = "Hello, World!"

  public init() {}

  func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }

  public func execute() {
    let collection = TaskCollection(count: 10)
    collection.delegate = self
    collection.start()
    RunLoop.main.run()
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
