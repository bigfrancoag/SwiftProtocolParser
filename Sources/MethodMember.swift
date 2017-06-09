public struct MethodMember {
   public let attributes: [Attribute]
   public let modifiers: [DeclarationModifier]
   public let name: String
   public let genericsClause: String?
   public let parameters: [MethodParameter]
   public let throwsType: ThrowsType?
   public let returnType: String?
   public let whereClause: String?
}
