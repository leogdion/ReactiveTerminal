
@inlinable public func max<T>(_ values: T?...) -> T? where T : Comparable {
  
  return values.compactMap{ $0 }.max()
}

@inlinable public func sum<T>(_ values: T?...) -> T? where T : Numeric {
  values.compactMap{$0}.reduce(nil) { partialResult, value in
    if let partialResult = partialResult {
      return partialResult + value
    } else {
      return value
    }
  }
}

struct CollectionView : View {
  var idealSize: Size? {
    return nil
  }
  
  func render<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
    if views.count == 1 {
      views.first?.render(to: &view)
    }
  }
  
  let views : [View]
  
  
}

struct TupleView<Content> : View, ViewCollectionable {
  var idealSize: Size? {
    if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
      
      let cols = max(content.C0.idealSize?.cols, content.C1.idealSize?.cols, content.C2.idealSize?.cols)
      let rows = sum(content.C0.idealSize?.rows, content.C1.idealSize?.rows, content.C2.idealSize?.rows)
      
      if let cols = cols, let rows = rows {
        return Size(cols: cols, rows: rows)
      } else {
        return nil
      }
    } else if let content = self.content as? (C0 : View, C1 : View) {
      
      let cols = max(content.C0.idealSize?.cols, content.C1.idealSize?.cols)
      let rows = sum(content.C0.idealSize?.rows, content.C1.idealSize?.rows)
      
      if let cols = cols, let rows = rows {
        return Size(cols: cols, rows: rows)
      } else {
        return nil
      }
    } else {
      print("Eeek")
    }
    return nil
  }
  
  func doPrintEach<TerminalViewType>(to view: inout TerminalViewType, _ closure: @escaping (inout TerminalViewType) -> Void) where TerminalViewType : TerminalView {
    
            if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
              content.C0.render(to: &view)
              closure(&view)
             content.C1.render(to: &view)
              closure(&view)
              content.C2.render(to: &view)
            } else if let content = self.content as? (C0 : View, C1 : View) {
              content.C0.render(to: &view)
              closure(&view)
             content.C1.render(to: &view)
            } else {
              print("Eeek")
            }
  }
  
  func render<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
        if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
          content.C0.render(to: &view)
         content.C1.render(to: &view)
          content.C2.render(to: &view)
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
