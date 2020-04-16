#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

public struct WindowSize {
  public let columns: Int
  public let rows: Int
  public let width: Int
  public let height: Int

  public init(winsize: winsize = winsize()) {
    columns = Int(winsize.ws_col)
    rows = Int(winsize.ws_row)
    width = Int(winsize.ws_xpixel)
    height = Int(winsize.ws_ypixel)
  }
}
