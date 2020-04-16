#if os(Linux)
  import Glibc
  // swiftlint:disable:next identifier_name
  public let WindowSize = UInt(TIOCGWINSZ)
#else
  // swiftlint:disable:next identifier_name
  public let WindowSize = TIOCGWINSZ
  import Darwin
#endif
