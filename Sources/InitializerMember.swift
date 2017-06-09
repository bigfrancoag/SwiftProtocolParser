public struct InitializerMember {
   public let attributes: [Attribute]
   public let modifiers: [DeclarationModifier]
   public let genericsClause: String?
   public let whereClause: String?
   public let parameters: [MethodParameter]
   public let throwsType: ThrowsType?
   public let isOptional: Bool
   public let isIUO: Bool
}
