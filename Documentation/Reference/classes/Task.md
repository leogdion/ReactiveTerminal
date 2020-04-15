**CLASS**

# `Task`

```swift
public class Task
```

## Properties
### `id`

```swift
public let id: UUID
```

### `name`

```swift
public let name: String
```

### `speed`

```swift
public let speed: TimeInterval
```

### `progress`

```swift
public var progress: Double = 0.0
```

### `timer`

```swift
public private(set) var timer: Timer?
```

### `delegate`

```swift
public weak var delegate: TaskDelegate?
```

## Methods
### `init(id:name:speed:)`

```swift
public init(id: UUID? = nil, name: String? = nil, speed: TimeInterval? = nil)
```

### `start()`

```swift
public func start()
```
