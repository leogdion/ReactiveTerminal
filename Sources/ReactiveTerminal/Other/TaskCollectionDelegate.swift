@available(macOS 10.12, *)
public protocol TaskCollectionDelegate: AnyObject {
  func tasks(_ collection: TaskCollection, updatedFromSource source: Any?)
}
