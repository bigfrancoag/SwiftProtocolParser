public struct MethodMember {
   let attributes: [Attribute]
   let modifiers: [DeclarationModifier]
   let name: String
   let genericsClause: String?
   let parameters: [MethodParameter]
   let throwsType: ThrowsType?
   let returnType: String?
   let whereClause: String?
}
