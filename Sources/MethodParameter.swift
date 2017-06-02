public struct MethodParameter {
   public let localName: String
   public let type: String
   public let externalName: String?
   public let defaultClause: String?
   public let isParams: Bool

   public init(localName: String, type: String, externalName: String? = nil, defaultClause: String? = nil, isParams: Bool = false) {
      self.localName = localName
      self.type = type
      self.externalName = externalName
      self.defaultClause = defaultClause
      self.isParams = isParams
   }
}
