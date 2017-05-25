public enum Inheritance {
   case classRequirement
   case protocolRequirement(String)
}

extension Inheritance : Equatable {
   public static func == (lhs: Inheritance, rhs: Inheritance) -> Bool {
      switch (lhs, rhs) {
      case (.classRequirement, .classRequirement):
         return true

      case (.classRequirement, _):
         return false

      case (_, .classRequirement):
         return false

      case let (.protocolRequirement(l), .protocolRequirement(r)):
         return l == r

      default:
         return false
      }
   }
}
