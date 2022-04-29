


struct EmptyView : View {
  func render<View>(to view: inout View) where View : TerminalView {
    
  }
  
  var idealSize: Size? {
    return .init(cols: 0, rows: 0)
  }
}
