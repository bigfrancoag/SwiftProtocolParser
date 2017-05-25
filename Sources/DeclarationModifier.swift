public enum DeclarationModifier {
   case access(AccessModifier)
   case setterAccess(AccessModifier)
   case isOptional
   case isMutation
   case isNonmutation
   case isStatic
}

extension DeclarationModifier {
   static func == (lhs: DeclarationModifier, rhs: DeclarationModifier) -> Bool {
      switch (lhs, rhs) {
         case (.isOptional, .isOptional): fallthrough
         case (.isMutation, .isMutation): fallthrough
         case (.isNonmutation, .isNonmutation): fallthrough
         case (.isStatic, .isStatic):
            return true 

         case let (.access(l), .access(r)) where l.rawValue == r.rawValue:
            return true
   
         case let (.setterAccess(l), .setterAccess(r)) where l.rawValue == r.rawValue:
            return true

         default:
            return false
      }
   }
}
