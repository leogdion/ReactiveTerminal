


protocol ViewCollectionable {
  func doPrintEach<TerminalViewType: TerminalView>(to view: inout TerminalViewType, _ closure : @escaping (inout TerminalViewType) -> Void)
  
}
