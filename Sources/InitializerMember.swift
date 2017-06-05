public struct InitializerMember {
   let attributes: [Attribute]
   let modifiers: [DeclarationModifier]
   let genericsClause: String?
   let parameters: [MethodParameter]
   let throwsType: ThrowsType?
   let isOptional: Bool
   let isIUO: Bool
}
