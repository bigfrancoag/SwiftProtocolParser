public enum AccessModifier : String {
   case publicAccess = "public"
   case privateAccess = "private"
   case fileprivateAccess = "fileprivate"
   case internalAccess = "internal"
   case openAccess = "open"
}

extension AccessModifier : Equatable {
   public static func == (lhs: AccessModifier, rhs: AccessModifier) -> Bool {
      return lhs.rawValue == rhs.rawValue
   }
}
