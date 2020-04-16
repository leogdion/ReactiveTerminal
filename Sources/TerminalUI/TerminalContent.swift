import Foundation

public protocol TerminalContent {
  func write<Stream: TextOutputStream>(to stream: inout Stream, within size: WindowSize)
}

public struct PaddedContent<Content: TerminalContent>: TerminalContent {
  public func write<Stream>(to _: inout Stream, within _: WindowSize) where Stream: TextOutputStream {}

  public let body: Content

  public init(_ body: Content) {
    self.body = body
  }
}

public enum TerminalEdge: Int8 {
  case top = 1
  case leading = 2
  case bottom = 4
  case trailing = 8

  public struct Set: OptionSet {
    // swiftlint:disable
    public typealias Element = TerminalEdge.Set
    public typealias ArrayLiteralElement = TerminalEdge.Set.Element

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }

    public let rawValue: TerminalEdge.RawValue

    public static let top = Element(.top)
    public static let leading = Element(.leading)
    public static let bottom = Element(.bottom)
    public static let trailing = Element(.trailing)
    public static let horizontal = Element(rawValue: leading.rawValue + trailing.rawValue)
    public static let vertical = Element(rawValue: top.rawValue + bottom.rawValue)
    public static let all = Element(rawValue: top.rawValue + bottom.rawValue + leading.rawValue + trailing.rawValue)

    public init(_ edge: TerminalEdge) {
      rawValue = edge.rawValue
    }
  }
}

@available(OSX 10.15.0, *)
public extension TerminalContent {
  func padding(_: TerminalEdge.Set = .all, _: Int? = nil) -> some TerminalContent {
    PaddedContent(self)
  }
}
