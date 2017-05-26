public enum DeclarationModifier {
   case access(AccessModifier)
   case setterAccess(AccessModifier)
   case isOptional
   case isMutating
   case isNonmutating
   case isStatic
}

extension DeclarationModifier {
   public static func == (lhs: DeclarationModifier, rhs: DeclarationModifier) -> Bool {
      switch (lhs, rhs) {
         case (.isOptional, .isOptional): fallthrough
         case (.isMutating, .isMutating): fallthrough
         case (.isNonmutating, .isNonmutating): fallthrough
         case (.isStatic, .isStatic):
            return true 

         case let (.access(l), .access(r)) where l == r:
            return true
   
         case let (.setterAccess(l), .setterAccess(r)) where l == r:
            return true

         default:
            return false
      }
   }
}
