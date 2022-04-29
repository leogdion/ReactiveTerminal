#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

public struct StandardOutputStream: TextOutputStream {
  let fileHandle = stdout
  public mutating func write(_ string: String) { fputs(string, fileHandle) }

  public func flush () {
    fflush(fileHandle)
  }
}
