


public protocol View {
  
  func doPrint<TerminalViewType: TerminalView>(to view: inout TerminalViewType)
}


struct List<Content : View> : View {
  func doPrint<View>(to view: inout View) where View : TerminalView {
    
  }
  
  init (@ViewBuilder content: () -> Content) {
    
  }
  
}
