struct PaddingView<Content: View> : View , ContainerView, Modifiable {
  internal init(edges: TerminalEdge.Set, length: Int, @ViewBuilder body: @escaping () -> Content) {
    self.modifiers = []
    self.body = body()
    self.edges = edges
    self.length = length
  }
  
  var child: View {
    return self.body
  }
  
  let modifiers: [AnyCodedModifier]
  
  func renderUnmodified<View>(to view: inout View) where View : TerminalView {
    if edges.contains(.top) {
      for _ in (0..<length) {
        view.escapeWith(code: "[2K")
        view.escapeWith(code: "[B")
      }
    }
    
    if edges.contains(.leading) {
      for _ in (0..<length) {
        view.write(" ")
      }
    }
    
    var paddingView = PaddingWindow(edges: self.edges, length: self.length, parent: view)
    paddingView.move(to: .init(x: 0, y: 0))
    self.body.render(to: &paddingView)
  }
  
  init(_ original: PaddingView<Content>, newModifiers: [AnyCodedModifier]) {
    self.modifiers = newModifiers
    self.body = original.body
    self.edges = original.edges
    self.length = original.length
  }
  
  
  let body : Content
    let edges: TerminalEdge.Set
    let length: Int
  var idealSize: Size? {
    guard let bodySize = body.idealSize else {
      return nil
    }
        var rowFactor = 0
        if edges.contains(.top) {
          rowFactor += 1
        }
        if edges.contains(.bottom) {
          rowFactor += 1
        }
    
        var columnFactor = 0
        if edges.contains(.leading) {
          columnFactor += 1
        }
        if edges.contains(.trailing) {
          columnFactor += 1
        }
    
    
    return Size(cols: bodySize.cols + columnFactor * (length + 1), rows: bodySize.rows + rowFactor * (length + 1))
  }
}
