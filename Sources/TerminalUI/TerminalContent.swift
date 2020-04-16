import Foundation

public protocol TerminalContent {
  func write<Stream: TextOutputStream>(to stream: inout Stream, within size: WindowSize)
}
