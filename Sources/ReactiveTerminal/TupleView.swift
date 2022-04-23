

struct TupleView<Content> : View, ViewCollectionable {
  func doPrintEach<TerminalViewType>(to view: inout TerminalViewType, _ closure: @escaping (inout TerminalViewType) -> Void) where TerminalViewType : TerminalView {
    
            if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
              content.C0.doPrint(to: &view)
              closure(&view)
             content.C1.doPrint(to: &view)
              closure(&view)
              content.C2.doPrint(to: &view)
            } else {
              print("Eeek")
            }
  }
  
  func doPrint<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
        if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
          content.C0.doPrint(to: &view)
         content.C1.doPrint(to: &view)
          content.C2.doPrint(to: &view)
        } else {
          print("Eeek")
        }
  }
  
//  func doPrintEach(_ closure: @escaping (inout TerminalView) -> Void) {
//        if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
//         content.C0.doPrint()
//          closure(
//         content.C1.doPrint()
//          closure()
//          content.C2.doPrint()
//        } else {
//          print("Eeek")
//        }
//  }
  
  internal init(_ content: Content) {
    self.content = content
  }
  
  let content : Content
  

//
//  func doPrintEach (_ closure: @escaping (TerminalView) -> Void) {
//    if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
//     content.C0.doPrint()
//      closure(
//     content.C1.doPrint()
//      closure()
//      content.C2.doPrint()
//    } else {
//      print("Eeek")
//    }
//
//  }
//  func doPrint<View>(to view: inout View) where View : TerminalView {
//
//  }
//
//  func doPrint() {
//    if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
//     content.C0.doPrint()
//     content.C1.doPrint()
//      content.C2.doPrint()
//    } else {
//      print("Eeek")
//    }
//  }
  
  
}
