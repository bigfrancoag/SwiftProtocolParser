public struct Attribute {
   let name: String
   let argumentsClause: String?
}

extension Attribute : Equatable {
   public static func == (lhs: Attribute, rhs: Attribute) -> Bool {
      guard lhs.name == rhs.name else {
         return false
      }

      switch (lhs.argumentsClause, rhs.argumentsClause) {
      case (nil, nil):
         return true

      case (_?, nil):
         return false

      case (nil, _?):
         return false

      case (let l?, let r?):
         return l == r
      }
   }
}
