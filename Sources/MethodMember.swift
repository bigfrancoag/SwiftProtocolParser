public struct MethodMember {
   let attributes: [Attribute]
   let modifiers: [DeclarationModifier]
   let name: String
   let genericsClause: String?
   let parameters: [MethodParameter]
   let isThrows: Bool
   let isRethrows: Bool
   let returnType: String?
   let whereClause: String?
}
