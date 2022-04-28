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
  
//  static func fetch(_ id: UUID, wrappedValue: Value) -> Self {
//    if let box = AnyBox.boxes[id]?.box as? Self {
//      return box
//    }
//    
//    let box = Self.init(wrappedValue)
//    AnyBox.boxes[id] = .init(box: box)
//    return box
//  }
}
@propertyWrapper struct State<Value> {
  
  let box: Box<Value>
 
  var wrappedValue : Value {
    get {
         box.value
       }
       nonmutating set {
         box.value = newValue
       }
     }
  
  
  init(wrappedValue: Value) {
    self.box = Box<Value>(wrappedValue)
  }
  
  var projectedValue : Binding<Value> {
    return .init(box: self.box)
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
}


protocol Input {
  var id : UUID { get }
  func put(_ value: UInt8)
}

struct TextField : View, Input {
  func put(_ value: UInt8) {
    if value == 127 {
      self.text.popLast()
    } else if value >= 32  {
      self.text.append(Character(UnicodeScalar(value)))
    }
    
  }
  
  internal init(cols : Int = 8, text: Binding<String>) {
    self.cols = cols
    self._text = text
  }
  
  let id: UUID = UUID()
  
  let cols : Int
  
  @Binding var text : String
  
  var idealSize: Size? {
    return .init(cols: self.cols, rows: 1)
  }
  
  func render<TerminalViewType>(to view: inout TerminalViewType) where TerminalViewType : TerminalView {
    view.escapeWith(code: "[4m")
    
     view.escapeWith(code: "[7m")
    let text = String((self.text + .init(repeating: "_", count: self.cols)).prefix(self.cols))
    view.write(text)
    
    view.escapeWith(code: "[0m")
  }
}
