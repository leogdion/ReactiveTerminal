

struct StackView<Content : View> : View,Modifiable {
  let modifiers: [AnyCodedModifier]
  
  init(_ original: StackView<Content>, newModifiers: [AnyCodedModifier]) {
    self.content = original.content
    self.spacing = original.spacing
    self.modifiers = newModifiers
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
        
        if let totalHeight = view.windowSize?.rows {
          let topOffset = (totalHeight - fullHeight)/2
          view.escapeWith(code: "[\(topOffset)B")
          
        }
        
        for child in content.views {
          let leftMargin : Int
          let endMargin : Int
          if let contentWidth = child.idealSize?.cols, let maxWidth = maxWidth {
            leftMargin = (maxWidth - contentWidth - 1) / 2
            endMargin = maxWidth - leftMargin
          } else {
            leftMargin = 0
            endMargin = 0
          }
          view.escapeWith(code: "[2K")
          view.escapeWith(code: "[\(leftMargin)C")
          child.render(to: &view)
          for _ in 0..<(self.spacing + 1) {
            view.escapeWith(code: "[B")
            view.escapeWith(code: "[K")
            
          }
          view.escapeWith(code: "[\(endMargin)D")
        }
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
