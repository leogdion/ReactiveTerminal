
struct PaddingWindow<View: TerminalView>: TerminalView {
  func move(to position: Position) {
    guard let transformedPosition = self.transformPosition(position) else {
      return
    }
    self.parent.move(to: transformedPosition)
  }
  
  fileprivate func transformPosition(_ position: Position) -> Position? {
    guard let windowSize = self.windowSize else {
      return nil
    }

    guard position.x < windowSize.columns, position.y < windowSize.rows else {
      return nil
    }

    let xOffset = edges.contains(.leading) ? (length + 1) : 0
    let yOffset = edges.contains(.top) ? (length + 1) : 0
    let transformedPosition = Position(x: position.x + xOffset, y: position.y + yOffset)
    return transformedPosition
  }
  func write(_ string: String) {
    parent.write(string)
  }
  
  func escapeWith(code: String) {
    parent.escapeWith(code: code)
  }
  
  let edges: TerminalEdge.Set
  let length: Int
  let parent: View

  func hideCursor() {
    parent.hideCursor()
  }

  func put(character: Character, at position: Position) {
    guard let transformedPosition = self.transformPosition(position) else {
      return
    }
    parent.put(character: character, at: transformedPosition)
  }

  public var windowSize: WindowSize? {
    return parent.windowSize?.padding(edges, length)
  }
}

public extension View {
  func padding(_ edges: TerminalEdge.Set = .all, _ length: Int) -> some View {
    PaddingView(edges: edges, length: length, body: {self})
  }
}
