**CLASS**

# `TerminalController`

```swift
public class TerminalController<Stream: TextOutputStream, Content: TerminalContent>
```

## Properties
### `windowSize`

```swift
public private(set) var windowSize = winsize()
```

## Methods
### `init(stream:content:)`

```swift
public init(stream: Stream, content: Content)
```

### `run()`

```swift
public func run()
```

### `draw()`

```swift
public func draw()
```
