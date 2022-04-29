public protocol TerminalView {
  func hideCursor()
//  func put(character: Character, at position: Position)
  func move(to position: Position)
  func write(_ string: String)
  var windowSize: WindowSize? { get }
  func escapeWith(code: String) 
}

extension TerminalView {
  func put(character: Character, at position: Position) {
    self.move(to: position)
    self.write(.init(character))
  }
}
