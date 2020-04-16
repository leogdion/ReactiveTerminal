**STRUCT**

# `PaddedContent`

```swift
public struct PaddedContent<Content: TerminalContent>: TerminalContent
```

## Properties
### `body`

```swift
public let body: Content
```

## Methods
### `write(to:within:)`

```swift
public func write<Stream>(to _: inout Stream, within _: WindowSize) where Stream: TextOutputStream
```

### `init(_:)`

```swift
public init(_ body: Content)
```
