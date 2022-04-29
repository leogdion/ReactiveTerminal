//public protocol EnvironmentKey {
//
//    /// The associated type representing the type of the environment key's
//    /// value.
//    associatedtype Value
//
//    /// The default value for the environment key.
//    static var defaultValue: Self.Value { get }
//}
//
//public protocol DynamicProperty {
//
//    /// Updates the underlying value of the stored value.
//    ///
//    /// SwiftUI calls this function before rendering a view's
//    /// ``View/body-swift.property`` to ensure the view has the most recent
//    /// value.
//    mutating func update()
//}
//
//protocol AnyValue {
//
//}
//public struct EnvironmentValues  {
//  struct Value<T>: AnyValue {
//      var value: T
//
//  }
//
//  static func get<ViewType: Any> (_ type: ViewType.Type) -> EnvironmentValues {
//    let id = ObjectIdentifier(type)
//    let values : EnvironmentValues
//    if let _values = self.values[id] {
//      values =  _values
//    } else {
//      values = .init()
//      self.values[id] = values
//    }
//    return values
//  }
//  static var values = [ObjectIdentifier : EnvironmentValues]()
//  var storage: [ObjectIdentifier: AnyValue]
//    /// Creates an environment values instance.
//    ///
//    /// You don't typically create an instance of ``EnvironmentValues``
//    /// directly. Doing so would provide access only to default values that
//    /// don't update based on system settings or device characteristics.
//    /// Instead, you rely on an environment values' instance
//    /// that SwiftUI manages for you when you use the ``Environment``
//    /// property wrapper and the ``View/environment(_:_:)`` view modifier.
//  public init() {
//    self.storage = [:]
//  }
//
//    /// Accesses the environment value associated with a custom key.
//    ///
//    /// Create custom environment values by defining a key
//    /// that conforms to the ``EnvironmentKey`` protocol, and then using that
//    /// key with the subscript operator of the ``EnvironmentValues`` structure
//    /// to get and set a value for that key:
//    ///
//    ///     private struct MyEnvironmentKey: EnvironmentKey {
//    ///         static let defaultValue: String = "Default value"
//    ///     }
//    ///
//    ///     extension EnvironmentValues {
//    ///         var myCustomValue: String {
//    ///             get { self[MyEnvironmentKey.self] }
//    ///             set { self[MyEnvironmentKey.self] = newValue }
//    ///         }
//    ///     }
//    ///
//    /// You use custom environment values the same way you use system-provided
//    /// values, setting a value with the ``View/environment(_:_:)`` view
//    /// modifier, and reading values with the ``Environment`` property wrapper.
//    /// You can also provide a dedicated view modifier as a convenience for
//    /// setting the value:
//    ///
//    ///     extension View {
//    ///         func myCustomValue(_ myCustomValue: String) -> some View {
//    ///             environment(\.myCustomValue, myCustomValue)
//    ///         }
//    ///     }
//    ///
//  public subscript<Key>(key: Key.Type) -> Key.Value where Key : EnvironmentKey {
//    get {
//      guard let value = self.storage[ObjectIdentifier(Key.self)] as? Value<Key.Value> else {
//        return Key.defaultValue
//             }
//             return value.value
//    }
//
//    set {
//      let key = ObjectIdentifier(Key.self)
//              //if let value = newValue {
//                  self.storage[key] = Value(value: newValue)
////              } else if let existing = self.storage[key] {
////                  self.storage[key] = nil
////                  existing.shutdown(logger: self.logger)
////              }
//    }
//  }
//
//    /// A string that represents the contents of the environment values
//    /// instance.
////    public var description: String {
////      return ""
////    }
//}
//
//@propertyWrapper public struct Environment<Value> : DynamicProperty {
//  public mutating func update() {
//
//  }
//
//
//    /// Creates an environment property to read the specified key path.
//    ///
//    /// Don’t call this initializer directly. Instead, declare a property
//    /// with the ``Environment`` property wrapper, and provide the key path of
//    /// the environment value that the property should reflect:
//    ///
//    ///     struct MyView: View {
//    ///         @Environment(\.colorScheme) var colorScheme: ColorScheme
//    ///
//    ///         // ...
//    ///     }
//    ///
//    /// SwiftUI automatically updates any parts of `MyView` that depend on
//    /// the property when the associated environment value changes.
//    /// You can't modify the environment value using a property like this.
//    /// Instead, use the ``View/environment(_:_:)`` view modifier on a view to
//    /// set a value for a view hierarchy.
//    ///
//    /// - Parameter keyPath: A key path to a specific resulting value.
//  @inlinable public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
//
//  }
//
//    /// The current value of the environment property.
//    ///
//    /// The wrapped value property provides primary access to the value's data.
//    /// However, you don't access `wrappedValue` directly. Instead, you read the
//    /// property variable created with the ``Environment`` property wrapper:
//    ///
//    ///     @Environment(\.colorScheme) var colorScheme: ColorScheme
//    ///
//    ///     var body: some View {
//    ///         if colorScheme == .dark {
//    ///             DarkContent()
//    ///         } else {
//    ///             LightContent()
//    ///         }
//    ///     }
//    ///
//    @inlinable public var wrappedValue: Value {
//      fatalError()
//    }
//}
//
//struct RefreshRateSeconds : EnvironmentKey {
//  static var defaultValue: TimeInterval = 0.1
//
//  typealias Value = TimeInterval
//
//
//}
//
//extension EnvironmentValues {
//  var refreshRateSeconds:TimeInterval {
//      get { self[RefreshRateSeconds.self] }
//      set { self[RefreshRateSeconds.self] = newValue }
//  }
//}

#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Foundation

//struct Text2 : View {
//  internal init(_ text: String) {
//    self.text = text
//  }
//  
//  let text : String
//  
//  func render<View>(to view: inout View) where View : TerminalView {
//    view.write(text)
//  }
//  
//  
//}

@available(macOS 10.12, *)
public protocol App {
  associatedtype Body : View
  init ()
  var body: Self.Body { get }
  
}
 

@available(macOS 10.12, *)
public extension App {
//  var environment : EnvironmentValues {
//    EnvironmentValues.get(Self.self)
//  }
  static func main () {
    var shouldKeepRunning = true
    let app = Self.init()
    var window = StandardOutputWindow()
    
    
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
      //window.hideCursor()
              window.escapeWith(code: "[2J")
              window.move(to: .init(x: 0, y: 0))
              window.loadInputs(app.body)
              app.body.render(to: &window)
              window.hideCursor()
              window.flush()
    })
    let runLoop = RunLoop.current
    runLoop.add(timer, forMode: .common)
    let input = Timer(timeInterval: 0.1, repeats: true) { _ in
      window.read()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      runLoop.add(input, forMode: .default)
      input.fire()
    }
    
    window.initialize()
    while shouldKeepRunning == true,
      runLoop.run(mode: .default, before: .distantFuture) {}
    timer.invalidate()
    input.invalidate()
  }
}



@available(macOS 10.12, *)
public class TerminalController<Window: TerminalWindow, Content: View> {
  private var shouldKeepRunning = true
  private var window: Window
  private let content: View
  private let runLoop = RunLoop.current

  private var timer: Timer!
  public init(window: Window, content: Content) {
    // fdopen(FileHandle.standardInput.fileDescriptor, <#T##UnsafePointer<Int8>!#>)

    self.window = window
    self.content = content

    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
      self.draw()

    })

    self.timer = timer
    runLoop.add(timer, forMode: .common)
  }

  public func run() {
    window.initialize()
    while shouldKeepRunning == true,
      runLoop.run(mode: .default, before: .distantFuture) {}
    timer.invalidate()
  }

  public func draw() {
    // stream.escapeWith(code: "[r")
    window.clear()
    // stream.escapeWith(code: "[2J")
    window.move(to: .init(x: 0, y: 0))
    content.render(to: &window)
    // content.write(to: &stream, within: WindowSize(winsize: windowSize))
    // stream.escapeWith(code: "[f")
    
    window.hideCursor()
    // stream.escapeWith(code: "[?25l")

    window.flush()
  }
}

@available(macOS 10.12, *)
extension TerminalController where Window == StandardOutputWindow {
  public convenience init(content: Content) {
    self.init(window: StandardOutputWindow(), content: content)
  }
}
