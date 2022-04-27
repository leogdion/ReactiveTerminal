//
//  File.swift
//  
//
//  Created by Leo Dion on 4/27/22.
//

import Foundation

struct Binding<Value> {
  
}

struct TextField : View {
  let text : Binding<String>
  
  var idealSize: Size? {
    return nil
  }
  
  func render<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
    
  }
  
  
}
