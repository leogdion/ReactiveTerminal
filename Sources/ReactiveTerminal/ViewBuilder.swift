

@resultBuilder struct ViewBuilder {
  @_alwaysEmitIntoClient
  public static func buildBlock() -> EmptyView {
      .init()
  }

  @_alwaysEmitIntoClient
  public static func buildBlock<Content>(_ content: Content) -> Content where Content: View {
      content
  }
  
  static func buildBlock(_ components: View...) -> CollectionView {
    CollectionView(views: components)
  }
  
//  public static func buildBlock<C0, C1>(
//          _ c0: C0,
//          _ c1: C1) -> CollectionView
//          where C0: View, C1: View
//      {
//        CollectionView
//      }
//
//  public static func buildBlock<C0, C1, C2>(
//          _ c0: C0,
//          _ c1: C1,
//          _ c2: C2) -> TupleView<(C0, C1, C2)>
//          where C0: View, C1: View, C2: View
//      {
//          .init((c0, c1, c2))
//      }
  
}
