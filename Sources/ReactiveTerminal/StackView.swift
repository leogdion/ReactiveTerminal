

struct StackView<Content : View> : View {
  func doPrint<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
    
      if let content = self.content as? ViewCollectionable{
        content.doPrintEach(to: &view){view in
          view.write("\n")
        }
      } else {
        print("Eeek")
      }
  }
  
  internal init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }
  
  let content : Content
  
}
