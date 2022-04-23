


struct EmptyView : View {
  func doPrint<View>(to view: inout View) where View : TerminalView {
    
  }
}
