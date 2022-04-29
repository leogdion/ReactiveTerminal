
struct HStackView<Content : View>: View, Modifiable, ContainerView {
  internal init(spacing: Int = 1, @ViewBuilder content: @escaping () -> Content) {
    self.spacing = spacing
    self.modifiers = []
    self.content = content()
  }
  internal init(child: Content, spacing: Int, modifiers: [AnyCodedModifier]) {
    self.modifiers = modifiers
    self.content = child
    self.spacing = spacing
  }
  
  var idealSize: Size? {
    if let collection = child as? CollectionView {
      let sizes = collection.views.compactMap{
        $0.idealSize }
      let cols = sizes.map{$0.cols}.reduce(0, +) + (collection.views.count - 1) * spacing
    let rows = sizes.map{$0.rows}.max() ?? 1
      
      return .init(cols: cols, rows: rows)
    } else {
      return self.child.idealSize
    }
  }
  
  let modifiers: [AnyCodedModifier]
  
  func renderUnmodified<View>(to view: inout View) where View : TerminalView {
    if let content = self.child as? CollectionView{
      let sizes = content.views.compactMap{
        $0.idealSize
      }
      
      let maxHeight = sizes.map{
        $0.rows
      }.max()
      
      let contentWidth = sizes.map {
        $0.cols
      }.reduce(0, +) + (content.views.count - 1)*self.spacing
      
      let leftOffset : Int?
      let totalWidth = view.windowSize?.columns
      if let totalWidth = totalWidth {
        leftOffset = (totalWidth - contentWidth)/2
//          view.escapeWith(code: "[\(topOffset)B")
        
      } else {
        leftOffset = nil
      }
      
      let topOffset : Int?
      if let maxHeight = maxHeight, let fullHeight = view.windowSize?.rows {
        topOffset = (fullHeight - maxHeight) / 2
      } else {
        topOffset = nil
      }
      
      if let topOffset = topOffset {
        for _ in (0..<topOffset) {
          if let totalWidth = totalWidth {
          for _ in (0..<totalWidth) {
            view.write(" ")
          }
            view.escapeWith(code: "[\(totalWidth)D")
          }
          view.escapeWith(code: "[B")
        }
      }
      if let leftOffset = leftOffset {
        view.write(String(repeating: " ", count: leftOffset))
      }
      
      //view.escapeWith(code: "[1J")
      
      for (index, child) in content.views.enumerated() {
//
//        let leftMargin : Int
//        let endMargin : Int
//        if let contentWidth = child.idealSize?.cols, let maxWidth = maxWidth {
//          leftMargin = (maxWidth - contentWidth) / 2
//          endMargin = maxWidth - leftMargin - contentWidth
//        } else {
//          leftMargin = 0
//          endMargin = 0
//        }
//        //view.escapeWith(code: "[2K")
//        view.write(String(repeating: " ", count: leftMargin))
        child.render(to: &view)
        self.applyModifiersTo(view)
        //view.write(String(repeating: " ", count: endMargin))
        //print("1", terminator: "")
//        if let maxWidth = maxWidth {
//          view.escapeWith(code: "[\(maxWidth)D")
//        }
        //print("2", terminator: "")
        
        if index < content.views.endIndex - 1 {
          for _ in 0..<(self.spacing) {
            view.write(" ")
            //view.escapeWith(code: "[B")
//            if let maxWidth = maxWidth {
//              view.write(String(repeating: " ", count: maxWidth))
//              view.escapeWith(code: "[\(maxWidth)D")
//            }
          }
        }
        
      }
      
      if let leftOffset = leftOffset, let totalWidth = totalWidth {
        let endMargin = totalWidth - leftOffset - contentWidth
        view.write(String(repeating: " ", count: endMargin))
      }
      if let topOffset = topOffset {
        for _ in (0..<topOffset) {
          view.escapeWith(code: "[B")
          if let totalWidth = totalWidth {
          for _ in (0..<totalWidth) {
            view.write(" ")
          }
            view.escapeWith(code: "[\(totalWidth)D")
          }
        }
      }
//      if let topOffset = topOffset {
//        for _ in (0..<topOffset) {
//          if let totalWidth = totalWidth {
//          for _ in (0..<totalWidth) {
//            view.write(" ")
//          }
//            view.escapeWith(code: "[\(totalWidth)D")
//          }
//          view.escapeWith(code: "[B")
//        }
//      }
//        if let topOffset = topOffset {
//          for _ in (0..<topOffset) {
//            view.escapeWith(code: "[2K")
//            view.escapeWith(code: "[B")
//          }
//        }
    } else {
      print("Eeek")
    }
  }
  
  init(_ original: HStackView, newModifiers: [AnyCodedModifier]) {
    self.init(child: original.content, spacing: original.spacing, modifiers: newModifiers)
  }
  
  let content : Content
  var child: View {
    return content
  }
  let spacing : Int
  
  
}

struct VStackView<Content : View> : View,Modifiable, ContainerView {
  let modifiers: [AnyCodedModifier]
  
  init(_ original: VStackView<Content>, newModifiers: [AnyCodedModifier]) {
    self.content = original.content
    self.spacing = original.spacing
    self.modifiers = newModifiers
  }
  
  var child: View {
    self.content
  }
  
  func renderUnmodified<View>(to view: inout View) where View : TerminalView {
    
  
    
    
      if let content = self.content as? CollectionView{
        let sizes = content.views.compactMap{
          $0.idealSize
        }
        
        let maxWidth = view.windowSize?.columns ?? sizes.map{
          $0.cols
        }.max()
        
        let fullHeight = sizes.map {
          $0.rows
        }.reduce(0, +) + (content.views.count - 1)*self.spacing
        
        let topOffset : Int?
        if let totalHeight = view.windowSize?.rows {
          topOffset = (totalHeight - fullHeight)/2
//          view.escapeWith(code: "[\(topOffset)B")
          
        } else {
          topOffset = nil
        }
        
        if let topOffset = topOffset {
          for _ in (0..<topOffset) {
            if let maxWidth = maxWidth {
            for _ in (0..<maxWidth) {
              view.write(" ")
            }
              view.escapeWith(code: "[\(maxWidth)D")
            }
            view.escapeWith(code: "[B")
          }
        }
        //view.escapeWith(code: "[1J")
        for (index, child) in content.views.enumerated() {
          
          let leftMargin : Int
          let endMargin : Int
          if let contentWidth = child.idealSize?.cols, let maxWidth = maxWidth {
            leftMargin = (maxWidth - contentWidth) / 2
            endMargin = maxWidth - leftMargin - contentWidth
          } else {
            leftMargin = 0
            endMargin = 0
          }
          //view.escapeWith(code: "[2K")
          view.write(String(repeating: " ", count: leftMargin))
          child.render(to: &view)
          self.applyModifiersTo(view)
          view.write(String(repeating: " ", count: endMargin))
          //print("1", terminator: "")
          if let maxWidth = maxWidth {
            view.escapeWith(code: "[\(maxWidth)D")
          }
          //print("2", terminator: "")
          
          if index < content.views.endIndex - 1 {
            for _ in 0..<(self.spacing + 1) {
              view.escapeWith(code: "[B")
              if let maxWidth = maxWidth {
                view.write(String(repeating: " ", count: maxWidth))
                view.escapeWith(code: "[\(maxWidth)D")
              }
            }
          }
          
        }
        if let topOffset = topOffset {
          for _ in (0..<topOffset) {
            view.escapeWith(code: "[B")
            if let maxWidth = maxWidth {
            for _ in (0..<maxWidth) {
              view.write(" ")
            }
              view.escapeWith(code: "[\(maxWidth)D")
            }
          }
        }
//        if let topOffset = topOffset {
//          for _ in (0..<topOffset) {
//            view.escapeWith(code: "[2K")
//            view.escapeWith(code: "[B")
//          }
//        }
      } else {
        print("Eeek")
      }
  }
  
  internal init(spacing: Int = 0, @ViewBuilder content: @escaping () -> Content) {
    self.spacing = spacing
    self.modifiers = []
    self.content = content()
  }
  
  var idealSize: Size? {
    return self.content.idealSize
  }
  
  let content : Content
  let spacing : Int
                     
}
