public struct TextBox: TerminalContent {
  public func write<Stream>(to stream: inout Stream, within size: WindowSize) where Stream: TextOutputStream {
    let border: String = String([Character].init(repeating: Character("-"), count: size.columns))
    let sides = "-" + String([Character].init(repeating: Character("0"), count: size.columns - 2)) + "-"
    let body = [String](repeating: sides, count: size.rows - 2).joined(separator: "")
    print(border, terminator: "", to: &stream)
    print(body, terminator: "", to: &stream)
    print(border, terminator: "", to: &stream)
  }

  public init() {}
}
