



struct Text : View {
  var idealSize: Size? {
    let lines = content.components(separatedBy: .newlines)
    
    let rows = lines.count
    if let cols = lines.map({$0.count}).max() {
      return Size(cols: cols, rows: rows)
    } else {
      return nil
    }
  }
  
  internal init(_ text: String, modifiers: [AnyCodedModifier] = .init()) {
    self.content = text
    self.modifiers = modifiers
  }
  
  let modifiers : [AnyCodedModifier]
  let content : String
  
  func render<View>(to view: inout View) where View : TerminalView {
    
    for modifier in modifiers {
      for code in modifier.modifier.prefixCode {
        view.escapeWith(code: code)
        
      }
    }
    view.write(self.content)
    
      for modifier in modifiers {
        if modifier.modifier.prefixCode.isEmpty {
          continue
        }
        
          for code in modifier.modifier.suffixCode {
            view.escapeWith(code: code)
          }
      }
  }
  func doPrint() {
    
  }
  
  func foregroundColor(_ color: Color) -> Self {
    var modifiers = self.modifiers
    modifiers.append(.init(modifier: SGRModifier(backgroundColor: nil, foregroundColor: color)))
    return .init(self.content, modifiers: modifiers)
  }
  
  
  func backgroundColor(_ color: Color) -> Self {
    var modifiers = self.modifiers
    modifiers.append(.init(modifier: SGRModifier(backgroundColor: color, foregroundColor: nil)))
    return .init(self.content, modifiers: modifiers)
  }
  
  func color(background: Color?, foreground: Color?) -> Self {
    var modifiers = self.modifiers
    modifiers.append(.init(modifier: SGRModifier(backgroundColor: background, foregroundColor: foreground)))
    return .init(self.content, modifiers: modifiers)
    
  }
}
