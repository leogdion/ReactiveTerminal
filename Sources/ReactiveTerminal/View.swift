
public protocol ContainerView : View {
  var child : View { get }
}

public protocol View {
  var idealSize : Size? { get }
  func render<TerminalViewType: TerminalView>(to view: inout TerminalViewType)
}


struct List<Content : View> : View {
  func render<View>(to view: inout View) where View : TerminalView {
    
  }
  
  init (@ViewBuilder content: () -> Content) {
    
  }
  
  var idealSize: Size? {
    return nil
  }
}
