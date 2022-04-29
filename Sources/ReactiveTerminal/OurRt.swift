

@available(macOS 10.15, *)
@main
public struct OurRT : App {
  public init () {}
  
  //@Environment(\.refreshRateSeconds) var refreshRate

  @State var name : String = ""
  public var body: some View {
//    VStackView{
//      HStackView{
//        Text("Name")
//        TextField(cols: 20, text: self.$name)
//      }
//    }
//
    VStackView(spacing: 2){
      Text("Hello World A").foregroundColor(.chartreuse1)
      Text(Int.random(in: 0...1).isMultiple(of: 2) ? "YeS" : "No").color(background: Bool.random() ? Color.chartreuse3A : Color.gold1, foreground: Bool.random() ? Color.darkBlue : Color.sandyBrown)
      HStackView{
              Text("Name")
              TextField(cols: 20, text: self.$name)
            }
    }.backgroundColor(.cadetBlueB).padding(.all, 4)

  }
}
