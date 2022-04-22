import Foundation
import Combine

@available(macOS 10.15, *)
@main
public struct OurRT : ReactiveTerminal {
  public init () {}
  

  public var body: some View {

      Text("Hello World A")
      Text(Int.random(in: 0...1).isMultiple(of: 2) ? "YeS" : "No")
      Text("Hello World C")

  }
}

public protocol View {
  func doPrint ()
}

struct List<Content : View> : View {
  func doPrint() {
    
  }
  
  init (@ViewBuilder content: () -> Content) {
    
  }
  
}

struct Text : View {
  internal init(_ text: String) {
    self.text = text
  }
  
  let text : String
  func doPrint() {
    Swift.print(text)
  }
  
  
}

struct StackView<Content : View> : View {
  let content : Content
  
  func doPrint() {
    
  }
  func doPrint<V0, V1>() where Content == TupleView<(V0, V1)> {

  }
}

struct TupleView<Content> : View {
  internal init(_ content: Content) {
    self.content = content
  }
  
  let content : Content
  
  func doPrint() {
    if let content = self.content as? (C0 : View, C1 : View) {
      Self.doPrint(content)
    }
  }
  
  static func doPrint(_ content: (C0, C1))   {
    content.0.doPrint()
    content.1.doPrint()
  }
  static func doPrint<C0: View, C1: View>(_ content: (C0, C1))   {
    content.0.doPrint()
    content.1.doPrint()
  }
}

struct EmptyView : View {
  func doPrint() {
    
  }
}
@resultBuilder struct ViewBuilder {
  @_alwaysEmitIntoClient
  public static func buildBlock() -> EmptyView {
      .init()
  }

  @_alwaysEmitIntoClient
  public static func buildBlock<Content>(_ content: Content) -> Content where Content: View {
      content
  }
  
  public static func buildBlock<C0, C1>(
          _ c0: C0,
          _ c1: C1) -> TupleView<(C0, C1)>
          where C0: View, C1: View
      {
          .init((c0, c1))
      }
  
  public static func buildBlock<C0, C1, C2>(
          _ c0: C0,
          _ c1: C1,
          _ c2: C2) -> TupleView<(C0, C1, C2)>
          where C0: View, C1: View, C2: View
      {
          .init((c0, c1, c2))
      }
  
}
@available(macOS 10.15, *)
public protocol ReactiveTerminal {
  associatedtype Body : View
  init ()
  @ViewBuilder var body: Self.Body { get }
}
 
@available(macOS 10.15, *)
public extension ReactiveTerminal {
  static func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }
  static func main () {
    let app = Self.init()
    let subscription = Timer.publish(every: 1.0, on: .main, in: .default)
      .autoconnect()
      .sink { _ in
        escapeWith(code: "[2J")
        escapeWith(code: "[0;0H")
        app.body.doPrint()
      }

    withExtendedLifetime(subscription) {
      RunLoop.current.run()
    }
  }
}


