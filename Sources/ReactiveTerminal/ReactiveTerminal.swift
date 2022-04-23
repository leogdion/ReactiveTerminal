import Foundation

enum Color : UInt8 {
  struct ComponentValue : ExpressibleByIntegerLiteral, RawRepresentable {
    init(rawValue: UInt8) {
      let index = Int(rawValue)
      precondition((0..<Self.values.count).contains(index))
      self.rawValue = rawValue
      self.value = Self.values[index]
    }
    
    init(integerLiteral value: IntegerLiteralType) {
      self = .init(rawValue: UInt8(value))
    }
    
    let rawValue: UInt8
    let value : UInt8
    
    typealias RawValue = UInt8
    
    static let values : [UInt8] = [0,95
    ,128
    ,135
    ,175
    ,192
    ,215
    ,255]
  }
  
  struct GreyscaleValue  : ExpressibleByIntegerLiteral, RawRepresentable  {
    init(rawValue: UInt8) {
      let index = Int(rawValue)
      precondition((0..<Self.values.count).contains(index))
      self.rawValue = rawValue
      self.value = Self.values[index]
    }
    
    init(integerLiteral value: IntegerLiteralType) {
      self = .init(rawValue: UInt8(value))
    }
    
    let rawValue: UInt8
    let value : UInt8
    
    typealias RawValue = UInt8
    
    static let values : [UInt8] = [
      0,
      8,
      18,
      28,
      38,
      48,
      58,
      68,
      78,
      88,
      98,
      108,
      118,
      128,
      138,
      148,
      158,
      168,
      178,
      188,
      198,
      208,
      218,
      228,
      238,
      255
    ]
  }
  case systemBlack = 0
  case systemMaroon = 1
  case systemGreen = 2
  case systemOlive = 3
  case systemNavy = 4
  case systemPurple = 5
  case systemTeal = 6
  case systemSilver = 7
  case systemGrey = 8
  case systemRed = 9
  case systemLime = 10
  case systemYellow = 11
  case systemBlue = 12
  case systemFuchsia = 13
  case systemAqua = 14
  case systemWhite = 15
  case grey0 = 16
  case navyBlue = 17
  case darkBlue = 18
  case blue3A = 19
  case blue3B = 20
  case blue1 = 21
  case darkGreen = 22
  case deepSkyBlue4A = 23
  case deepSkyBlue4B = 24
  case deepSkyBlue4C = 25
  case dodgerBlue3 = 26
  case dodgerBlue2 = 27
  case green4 = 28
  case springGreen4 = 29
  case turquoise4 = 30
  case deepSkyBlue3A = 31
  case deepSkyBlue3B = 32
  case dodgerBlue1 = 33
  case green3A = 34
  case springGreen3A = 35
  case darkCyan = 36
  case lightSeaGreen = 37
  case deepSkyBlue2 = 38
  case deepSkyBlue1 = 39
  case green3B = 40
  case springGreen3B = 41
  case springGreen2A = 42
  case cyan3 = 43
  case darkTurquoise = 44
  case turquoise2 = 45
  case green1 = 46
  case springGreen2B = 47
  case springGreen1 = 48
  case mediumSpringGreen = 49
  case cyan2 = 50
  case cyan1 = 51
  case darkRedA = 52
  case deepPink4A = 53
  case purple4A = 54
  case purple4B = 55
  case purple3 = 56
  case blueViolet = 57
  case orange4A = 58
  case grey37 = 59
  case mediumPurple4 = 60
  case slateBlue3A = 61
  case slateBlue3B = 62
  case royalBlue1 = 63
  case chartreuse4 = 64
  case darkSeaGreen4A = 65
  case paleTurquoise4 = 66
  case steelBlue = 67
  case steelBlue3 = 68
  case cornflowerBlue = 69
  case chartreuse3A = 70
  case darkSeaGreen4B = 71
  case cadetBlueA = 72
  case cadetBlueB = 73
  case skyBlue3 = 74
  case steelBlue1A = 75
  case chartreuse3B = 76
  case paleGreen3A = 77
  case seaGreen3 = 78
  case aquamarine3 = 79
  case mediumTurquoise = 80
  case steelBlue1B = 81
  case chartreuse2A = 82
  case seaGreen2 = 83
  case seaGreen1A = 84
  case seaGreen1B = 85
  case aquamarine1A = 86
  case darkSlateGray2 = 87
  case darkRedB = 88
  case deepPink4B = 89
  case darkMagentaA = 90
  case darkMagentaB = 91
  case darkVioletA = 92
  case purpleA = 93
  case orange4B = 94
  case lightPink4 = 95
  case plum4 = 96
  case mediumPurple3A = 97
  case mediumPurple3B = 98
  case slateBlue1 = 99
  case yellow4A = 100
  case wheat4 = 101
  case grey53 = 102
  case lightSlateGrey = 103
  case mediumPurple = 104
  case lightSlateBlue = 105
  case yellow4B = 106
  case darkOliveGreen3A = 107
  case darkSeaGreen = 108
  case lightSkyBlue3A = 109
  case lightSkyBlue3B = 110
  case skyBlue2 = 111
  case chartreuse2B = 112
  case darkOliveGreen3B = 113
  case paleGreen3B = 114
  case darkSeaGreen3A = 115
  case darkSlateGray3 = 116
  case skyBlue1 = 117
  case chartreuse1 = 118
  case lightGreenA = 119
  case lightGreenB = 120
  case paleGreen1A = 121
  case aquamarine1B = 122
  case darkSlateGray1 = 123
  case red3A = 124
  case deepPink4C = 125
  case mediumVioletRed = 126
  case magenta3A = 127
  case darkVioletB = 128
  case purpleB = 129
  case darkOrange3A = 130
  case indianRedA = 131
  case hotPink3A = 132
  case mediumOrchid3 = 133
  case mediumOrchid = 134
  case mediumPurple2A = 135
  case darkGoldenrod = 136
  case lightSalmon3A = 137
  case rosyBrown = 138
  case grey63 = 139
  case mediumPurple2B = 140
  case mediumPurple1 = 141
  case gold3A = 142
  case darkKhaki = 143
  case navajoWhite3 = 144
  case grey69 = 145
  case lightSteelBlue3 = 146
  case lightSteelBlue = 147
  case yellow3A = 148
  case darkOliveGreen3C = 149
  case darkSeaGreen3B = 150
  case darkSeaGreen2A = 151
  case lightCyan3 = 152
  case lightSkyBlue1 = 153
  case greenYellow = 154
  case darkOliveGreen2 = 155
  case paleGreen1B = 156
  case darkSeaGreen2B = 157
  case darkSeaGreen1A = 158
  case paleTurquoise1 = 159
  case red3B = 160
  case deepPink3A = 161
  case deepPink3B = 162
  case magenta3B = 163
  case magenta3C = 164
  case magenta2A = 165
  case darkOrange3B = 166
  case indianRedB = 167
  case hotPink3B = 168
  case hotPink2 = 169
  case orchid = 170
  case mediumOrchid1A = 171
  case orange3 = 172
  case lightSalmon3B = 173
  case lightPink3 = 174
  case pink3 = 175
  case plum3 = 176
  case violet = 177
  case gold3B = 178
  case lightGoldenrod3 = 179
  case tan = 180
  case mistyRose3 = 181
  case thistle3 = 182
  case plum2 = 183
  case yellow3B = 184
  case khaki3 = 185
  case lightGoldenrod2A = 186
  case lightYellow3 = 187
  case grey84 = 188
  case lightSteelBlue1 = 189
  case yellow2 = 190
  case darkOliveGreen1A = 191
  case darkOliveGreen1B = 192
  case darkSeaGreen1B = 193
  case honeydew2 = 194
  case lightCyan1 = 195
  case red1 = 196
  case deepPink2 = 197
  case deepPink1A = 198
  case deepPink1B = 199
  case magenta2B = 200
  case magenta1 = 201
  case orangeRed1 = 202
  case indianRed1A = 203
  case indianRed1B = 204
  case hotPinkA = 205
  case hotPinkB = 206
  case mediumOrchid1B = 207
  case darkOrange = 208
  case salmon1 = 209
  case lightCoral = 210
  case paleVioletRed1 = 211
  case orchid2 = 212
  case orchid1 = 213
  case orange1 = 214
  case sandyBrown = 215
  case lightSalmon1 = 216
  case lightPink1 = 217
  case pink1 = 218
  case plum1 = 219
  case gold1 = 220
  case lightGoldenrod2B = 221
  case lightGoldenrod2C = 222
  case navajoWhite1 = 223
  case mistyRose1 = 224
  case thistle1 = 225
  case yellow1 = 226
  case lightGoldenrod1 = 227
  case khaki1 = 228
  case wheat1 = 229
  case cornsilk1 = 230
  case grey100 = 231
  case grey3 = 232
  case grey7 = 233
  case grey11 = 234
  case grey15 = 235
  case grey19 = 236
  case grey23 = 237
  case grey27 = 238
  case grey30 = 239
  case grey35 = 240
  case grey39 = 241
  case grey42 = 242
  case grey46 = 243
  case grey50 = 244
  case grey54 = 245
  case grey58 = 246
  case grey62 = 247
  case grey66 = 248
  case grey70 = 249
  case grey74 = 250
  case grey78 = 251
  case grey82 = 252
  case grey85 = 253
  case grey89 = 254
  case grey93 = 255
  
  init(_ rawValue: UInt8) {
    self.init(rawValue: rawValue)!
  }
  
  static let hexValues = [0x000000,
  0x800000,
  0x008000,
  0x808000,
  0x000080,
  0x800080,
  0x008080,
  0xc0c0c0,
  0x808080,
  0xff0000,
  0x00ff00,
  0xffff00,
  0x0000ff,
  0xff00ff,
  0x00ffff,
  0xffffff,
  0x000000,
  0x00005f,
  0x000087,
  0x0000af,
  0x0000d7,
  0x0000ff,
  0x005f00,
  0x005f5f,
  0x005f87,
  0x005faf,
  0x005fd7,
  0x005fff,
  0x008700,
  0x00875f,
  0x008787,
  0x0087af,
  0x0087d7,
  0x0087ff,
  0x00af00,
  0x00af5f,
  0x00af87,
  0x00afaf,
  0x00afd7,
  0x00afff,
  0x00d700,
  0x00d75f,
  0x00d787,
  0x00d7af,
  0x00d7d7,
  0x00d7ff,
  0x00ff00,
  0x00ff5f,
  0x00ff87,
  0x00ffaf,
  0x00ffd7,
  0x00ffff,
  0x5f0000,
  0x5f005f,
  0x5f0087,
  0x5f00af,
  0x5f00d7,
  0x5f00ff,
  0x5f5f00,
  0x5f5f5f,
  0x5f5f87,
  0x5f5faf,
  0x5f5fd7,
  0x5f5fff,
  0x5f8700,
  0x5f875f,
  0x5f8787,
  0x5f87af,
  0x5f87d7,
  0x5f87ff,
  0x5faf00,
  0x5faf5f,
  0x5faf87,
  0x5fafaf,
  0x5fafd7,
  0x5fafff,
  0x5fd700,
  0x5fd75f,
  0x5fd787,
  0x5fd7af,
  0x5fd7d7,
  0x5fd7ff,
  0x5fff00,
  0x5fff5f,
  0x5fff87,
  0x5fffaf,
  0x5fffd7,
  0x5fffff,
  0x870000,
  0x87005f,
  0x870087,
  0x8700af,
  0x8700d7,
  0x8700ff,
  0x875f00,
  0x875f5f,
  0x875f87,
  0x875faf,
  0x875fd7,
  0x875fff,
  0x878700,
  0x87875f,
  0x878787,
  0x8787af,
  0x8787d7,
  0x8787ff,
  0x87af00,
  0x87af5f,
  0x87af87,
  0x87afaf,
  0x87afd7,
  0x87afff,
  0x87d700,
  0x87d75f,
  0x87d787,
  0x87d7af,
  0x87d7d7,
  0x87d7ff,
  0x87ff00,
  0x87ff5f,
  0x87ff87,
  0x87ffaf,
  0x87ffd7,
  0x87ffff,
  0xaf0000,
  0xaf005f,
  0xaf0087,
  0xaf00af,
  0xaf00d7,
  0xaf00ff,
  0xaf5f00,
  0xaf5f5f,
  0xaf5f87,
  0xaf5faf,
  0xaf5fd7,
  0xaf5fff,
  0xaf8700,
  0xaf875f,
  0xaf8787,
  0xaf87af,
  0xaf87d7,
  0xaf87ff,
  0xafaf00,
  0xafaf5f,
  0xafaf87,
  0xafafaf,
  0xafafd7,
  0xafafff,
  0xafd700,
  0xafd75f,
  0xafd787,
  0xafd7af,
  0xafd7d7,
  0xafd7ff,
  0xafff00,
  0xafff5f,
  0xafff87,
  0xafffaf,
  0xafffd7,
  0xafffff,
  0xd70000,
  0xd7005f,
  0xd70087,
  0xd700af,
  0xd700d7,
  0xd700ff,
  0xd75f00,
  0xd75f5f,
  0xd75f87,
  0xd75faf,
  0xd75fd7,
  0xd75fff,
  0xd78700,
  0xd7875f,
  0xd78787,
  0xd787af,
  0xd787d7,
  0xd787ff,
  0xd7af00,
  0xd7af5f,
  0xd7af87,
  0xd7afaf,
  0xd7afd7,
  0xd7afff,
  0xd7d700,
  0xd7d75f,
  0xd7d787,
  0xd7d7af,
  0xd7d7d7,
  0xd7d7ff,
  0xd7ff00,
  0xd7ff5f,
  0xd7ff87,
  0xd7ffaf,
  0xd7ffd7,
  0xd7ffff,
  0xff0000,
  0xff005f,
  0xff0087,
  0xff00af,
  0xff00d7,
  0xff00ff,
  0xff5f00,
  0xff5f5f,
  0xff5f87,
  0xff5faf,
  0xff5fd7,
  0xff5fff,
  0xff8700,
  0xff875f,
  0xff8787,
  0xff87af,
  0xff87d7,
  0xff87ff,
  0xffaf00,
  0xffaf5f,
  0xffaf87,
  0xffafaf,
  0xffafd7,
  0xffafff,
  0xffd700,
  0xffd75f,
  0xffd787,
  0xffd7af,
  0xffd7d7,
  0xffd7ff,
  0xffff00,
  0xffff5f,
  0xffff87,
  0xffffaf,
  0xffffd7,
  0xffffff,
  0x080808,
  0x121212,
  0x1c1c1c,
  0x262626,
  0x303030,
  0x3a3a3a,
  0x444444,
  0x4e4e4e,
  0x585858,
  0x626262,
  0x6c6c6c,
  0x767676,
  0x808080,
  0x8a8a8a,
  0x949494,
  0x9e9e9e,
  0xa8a8a8,
  0xb2b2b2,
  0xbcbcbc,
  0xc6c6c6,
  0xd0d0d0,
  0xdadada,
  0xe4e4e4,
  0xeeeeee]
}

extension Color {
  init(approximateValueBasedOnRed red: UInt8, green: UInt8, blue: UInt8) {
   fatalError()
  }
  
  init(approximateValueBasedOnWhite white: UInt8) {
    fatalError()
  }
  
  init(approximateValueBasedOnRed red: Double, green: Double, blue: Double) {
   fatalError()
  }
  
  init(approximateValueBasedOnWhite white: Double) {
    fatalError()
  }
  
  init(approximateValueBasedOnHexValue hexValue: Int) {
    var currentIndex : Int = -1
    var currentValue : Int?
    for (index, value) in Self.hexValues.enumerated() {
      if value == hexValue {
        self.init(UInt8(index))
      } else if let oldValue = currentValue {
        if (abs(oldValue - hexValue) > abs(value - hexValue)) {
        currentIndex = index
        currentValue = value
        }
      } else {
        currentIndex = index
        currentValue = value
      }
    }
    self.init(.init(currentIndex))
  }
  
  init(red: ComponentValue, green: ComponentValue, blue: ComponentValue) {
   fatalError()
  }
  
  init(white: GreyscaleValue) {
    fatalError()
  }
  
  
}
@available(macOS 10.15, *)
@main
public struct OurRT : ReactiveTerminal {
  public init () {}
  

  public var body: some View {

      Text("Hello World A")
      Text(Int.random(in: 0...1).isMultiple(of: 2) ? "YeS" : "No")
      Text2("Hello World C")

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

struct Text2 : View {
  internal init(_ text: String) {
    self.text = text
  }
  
  let text : String
  func doPrint() {
    Swift.print(text)
  }
  
  
}

protocol Modifiable {
  func foregroundColor(_ color: Color?) -> Self
}
struct Text : View {
  internal init(_ text: String) {
    self.content = text
  }
  
  let content : String
  func doPrint() {
    Swift.print(content)
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
    if let content = self.content as? (C0 : View, C1 : View, C2 : View) {
     content.C0.doPrint()
     content.C1.doPrint()
      content.C2.doPrint()
    } else {
      print("Eeek")
    }
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
    
//    for i in 0..<16 {
//      for j in 0..<16 {
//
//            let code = "\(i * 16 + j)"
//        Self.escapeWith(code: "[38;5;\(code)m")
//        print(code, terminator: " ")
//
//        escapeWith(code: "[0m")
//      }
//    }
//    for i in range(0, 16):
//        for j in range(0, 16):
//            code = str(i * 16 + j)
//            sys.stdout.write(u"\u001b[38;5;" + code + "m " + code.ljust(4))
//        print u"\u001b[0m"
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


