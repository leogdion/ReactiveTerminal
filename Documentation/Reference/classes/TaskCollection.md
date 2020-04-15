**CLASS**

# `TaskCollection`

```swift
public class TaskCollection: TaskDelegate
```

## Properties
### `delegate`

```swift
public weak var delegate: TaskCollectionDelegate?
```

### `tasks`

```swift
public let tasks: [Task]
```

## Methods
### `taskUpdated(_:)`

```swift
public func taskUpdated(_ task: Task)
```

### `init(tasks:)`

```swift
public init(tasks: [Task])
```

### `init(count:)`

```swift
public convenience init(count: Int)
```
