@available(macOS 10.12, *)
public protocol TaskDelegate: AnyObject {
  func taskUpdated(_ task: Task)
}
