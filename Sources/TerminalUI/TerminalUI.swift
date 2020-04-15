import Foundation

public struct TerminalUI {
  var text = "Hello, World!"

  public init () {
    
  }

  func escapeWith(code: String) {
    print("\u{1B}\(code)", terminator: "")
  }
  
  public func execute() {

    var progress = 0.0
    while (progress <= 100) {
      print("Progress: \(progress)")
      escapeWith(code: "[1A")
      escapeWith(code: "[2K")
      sleep(1)
      progress += 1
    }
  }
}
