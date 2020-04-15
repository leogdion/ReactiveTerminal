struct TerminalUI {
    var text = "Hello, World!"
  
  func execute() {
    func escapeWith (code : String) {
      print("\u{1B}\(code)", terminator: "")
    }

    print("Hello World")
    escapeWith(code: "[1A")
    print("Bye", terminator: "")

  }
}
