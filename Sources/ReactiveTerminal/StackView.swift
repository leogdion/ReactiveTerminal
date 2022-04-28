

struct StackView<Content : View> : View,Modifiable, ContainerView {
  let modifiers: [AnyCodedModifier]
  
  init(_ original: StackView<Content>, newModifiers: [AnyCodedModifier]) {
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
