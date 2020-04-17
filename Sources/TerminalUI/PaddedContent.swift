public struct PaddedContent<Content: TerminalContent>: TerminalContent {
  let edges: TerminalEdge.Set
  let length: Int
  public let body: Content

  public func render<View>(to view: inout View) where View: TerminalView {
    var view = view.padding(edges, length)
    body.render(to: &view)
  }

  public init(edges: TerminalEdge.Set, length: Int, _ body: Content) {
    self.edges = edges
    self.length = length
    self.body = body
  }
}
