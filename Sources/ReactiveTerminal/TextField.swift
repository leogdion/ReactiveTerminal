//
//  File.swift
//  
//
//  Created by Leo Dion on 4/27/22.
//

import Foundation

struct AnyBox {
  let box : Any
  static var boxes = [UUID : AnyBox]()
}
final class Box<Value> {
  
  var value: Value
  
  

  required init(_ value: Value) {
    
      self.value = value
    }
  
  static func fetch(_ id: UUID, wrappedValue: Value) -> Self {
    if let box = AnyBox.boxes[id]?.box as? Self {
      return box
    }
    
    let box = Self.init(wrappedValue)
    AnyBox.boxes[id] = .init(box: box)
    return box
  }
}
@propertyWrapper struct Binding<Value> {
  
  let box: Box<Value>
 
  var wrappedValue : Value {
    get {
         box.value
       }
       nonmutating set {
         box.value = newValue
       }
     }
  
  
  init(id: UUID, wrappedValue: Value) {
    self.box = Box<Value>.fetch(id, wrappedValue: wrappedValue)
  }
}

protocol Input {
  var id : UUID { get }
  func put(_ value: UInt8)
}

struct TextField : View, Input {
  func put(_ value: UInt8) {
    self.text.append(Character(UnicodeScalar(value)))
    
  }
  
  internal init(cols : Int = 8) {
    self.cols = cols
    self._text = .init(id: self.id, wrappedValue: "")
  }
  
  let id: UUID = UUID()
  
  let cols : Int
  
  @Binding var text : String
  
  var idealSize: Size? {
    return .init(cols: self.cols, rows: 1)
  }
  
  func render<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
    let text = String((self.text + .init(repeating: "_", count: self.cols)).prefix(self.cols))
    view.write(text)
  }
}
