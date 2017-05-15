import ParseKit

public enum SwiftProtocolParser {
   static let digit = Parsers.regex(pattern: "0-9")
   static let character = Parsers.regex(pattern: "A-Za-z")
   static let underscore = Parsers.token("_")
   static let colon = Parsers.token(":")
   static let comma = Parsers.token(",")

   static let openBlock = Parsers.token("{").token()
   static let closeBlock = Parsers.token("}").token()

   static let protocolKeyword = Parsers.token("protocol").token()
   static let classKeyword = Parsers.token("class").token()
   static let publicKeyword = Parsers.token("public").token()
   static let privateKeyword = Parsers.token("private").token()
   static let fileprivateKeyword = Parsers.token("fileprivate").token()
   static let internalKeyword = Parsers.token("internal").token()
   static let openKeyword = Parsers.token("open").token()

   static let identifierChar = digit <|> character
   static let identifierHead = identifierChar <|> underscore
   static let identifier = ({ s in { s + $0.joined(separator: "") } } <^> identifierHead <*> identifierChar.*).token()

   static let attribute = { name in { args in Attribute(name: name, argumentsClause: args) } } <^> identifier <*> Parsers.regex(pattern: "\\(.*\\)").token()

   static let accessModifier = ((publicKeyword <|> privateKeyword <|> fileprivateKeyword <|> internalKeyword <|> openKeyword).token().?).map { s in s.flatMap { AccessModifier(rawValue: $0) } }

   static let typeIdentifier = identifier

   static let protocolList = typeIdentifier.separatedBy(some: comma).map { xs in xs.map { Inheritance.protocolRequirement($0) } }

   static let classInheritance = colon *> classKeyword.map { _ in [Inheritance.classRequirement] }
   static let protocolListInheritance = colon *> protocolList
   static let inheritanceList = classInheritance <|> protocolListInheritance <|> { xs in { xs + $0 } } <^> classInheritance <*> (comma *> protocolList)

   static let protocolDeclaration = { attrs in { optModifier in { _ in { xs in { members in ProtocolDeclaration(attributes: attrs, accessModifier: optModifier, inheritance: xs, members: members) } } } }  }
      <^> attribute.many()
      <*> accessModifier
      <*> protocolKeyword
      <*> inheritanceList
      <*> (openBlock *> Parser(pure: []) <* closeBlock)

   
}
