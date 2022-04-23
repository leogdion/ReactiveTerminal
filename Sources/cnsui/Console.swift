//
//  File.swift
//  
//
//  Created by Leo Dion on 1/31/22.
//

import Foundation

struct Size {
  let cols : Int
  let rows : Int
}

protocol View {
  func drawIn(stream: inout StandardOutputStream, size: WindowSize)
  var miniumumSize : Size { get }
  var maximumSize : Size { get }
}

struct HStack : View {
  internal init(_ content: () -> View) {
    self.content = .castOrConvert(fromView: content())
  }
  
  let content : TupleView
  
  func drawIn(stream: inout StandardOutputStream, size: WindowSize) {
    for view in content.children {
      view.drawIn(stream: &<#T##StandardOutputStream#>, size: <#T##WindowSize#>)
    }
  }
}

struct TupleView : View {
  let children : [View]
  func drawIn(stream: inout StandardOutputStream, size: WindowSize) {
    
  }
  
  static func castOrConvert(fromView view: View) -> TupleView {
    if let tupleView = view as? TupleView {
      return tupleView
    } else {
      return .init(children: [view])
    }
  }
}
@resultBuilder
struct ViewBuilder {
  static func buildBlock(_ components: View...) -> View {
    return TupleView(children: components)
  }
}

struct ForEach<Data : RandomAccessCollection> : View where Data.Element : Identifiable {
  var data : Data
  var content : (Data.Element) -> View
  
  func drawIn(stream: inout StandardOutputStream, size: WindowSize) {
    let linesPerItem = max(size.rows / (data.count+1), 1)
    let heightPerItem = (size.height  * linesPerItem) / size.rows
    for element in data {
      content(element).drawIn(stream: &stream, size: WindowSize(columns: size.columns, rows: linesPerItem, width: size.width, height: heightPerItem))
      stream.escapeWith(code: "[E")
      stream.escapeWith(code: "[A")
      if linesPerItem > 1 {
        stream.escapeWith(code: "[\(linesPerItem-1)B")
      }
    }
  }
  
}
struct Text<S : StringProtocol> : View {
  public init(_ content: S) {
    self.content = String(content)
  }
  
  let content : String
  
  
  public func drawIn(stream: inout StandardOutputStream, size: WindowSize) {
    
    let line = (size.rows - 1) / 2
    let col = (size.columns - 1) / 2
    stream.escapeWith(code: "[\(line)B")
    stream.escapeWith(code: "[\(col - content.count/2)C")
    stream.write(content)
  }
}

struct Object : Identifiable {
  let id : Int
}
@main
class Console {
  let items = (0...10).map(Object.init)
  var windowSize: WindowSize? {
    didSet {
      guard let windowSize = windowSize else {
        return
      }
guard  oldValue != nil else {
        return
      }
      stream.escapeWith(code: "[2J")
      stream.escapeWith(code: "[H")
      HStack{
        Text("test")
      }.drawIn(stream: &stream, size: windowSize)
    }
  }
  var stream = StandardOutputStream()
  let sigwinchSrc = DispatchSource.makeSignalSource(signal: SIGWINCH, queue: .main)
  func main () {
    var winsizeObj = winsize()
    
    
    if ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj) == 0 {
      windowSize = WindowSize(winsize: winsizeObj)
    }

    sigwinchSrc.setEventHandler {
      var winsizeObj = winsize()
      if ioctl(STDOUT_FILENO, WindowSizeAttribute, &winsizeObj) == 0 {
        self.windowSize = WindowSize(winsize: winsizeObj)
      }
    }
    
    stream.escapeWith(code: "[2J")
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      
      self.stream.flush()
    }
    stream.escapeWith(code: "[H")
    HStack{
      Text("test")
    }.drawIn(stream: &stream, size: .init(winsize: winsizeObj))
    //Text("Hello World!").drawIn(stream: &stream, size: .init(winsize: winsizeObj))
    sigwinchSrc.resume()
    RunLoop.main.add(timer, forMode: .default)
    RunLoop.main.run()
  }
  static func main () {
    let console = Console()
    console.main()
  }
}
