import ParseKit

public enum SwiftProtocolParser {
   static func padRight(_ parser: Parser<String?>) -> Parser<String> {
      return orEmpty(parser.map { $0.map { s in "\(s) " } })
   }

   static func orEmpty(_ parser: Parser<String?>) -> Parser<String> {
      return parser.map { $0 ?? "" }
   }

   static let digit = Parsers.regex(pattern: "0-9")
   static let character = Parsers.regex(pattern: "A-Za-z")
   static let underscore = Parsers.token("_")
   static let colon = Parsers.token(":").token()
   static let comma = Parsers.token(",").token()
   static let period = Parsers.token(".").token()
   static let questionMark = Parsers.token("?").token()
   static let bang = Parsers.token("!").token()
   static let ellipsis = Parsers.token("...").token()
   static let ampersand = Parsers.token("&").token()

   static let openAngle = Parsers.token("<").token()
   static let closeAngle = Parsers.token(">").token()

   static let openBlock = Parsers.token("{").token()
   static let closeBlock = Parsers.token("}").token()

   static let openParens = Parsers.token("(").token()
   static let closeParens = Parsers.token(")").token()

   static let openSquare = Parsers.token("[").token()
   static let closeSquare = Parsers.token("]").token()

   static let protocolKeyword = Parsers.token("protocol").token()
   static let optionalKeyword = Parsers.token("optional").token()
   static let classKeyword = Parsers.token("class").token()
   static let publicKeyword = Parsers.token("public").token()
   static let privateKeyword = Parsers.token("private").token()
   static let fileprivateKeyword = Parsers.token("fileprivate").token()
   static let internalKeyword = Parsers.token("internal").token()
   static let mutationKeyword = Parsers.token("mutation").token()
   static let nonmutationKeyword = Parsers.token("nonmutation").token()
   static let getKeyword = Parsers.token("get").token()
   static let setKeyword = Parsers.token("set").token()
   static let varKeyword = Parsers.token("var").token()
   static let arrowOperator = Parsers.token("->").token()
   static let openKeyword = Parsers.token("open").token()
   static let inoutKeyword = Parsers.token("inout").token()
   static let throwsKeyword = Parsers.token("throws").token()
   static let rethrowsKeyword = Parsers.token("rethrows").token()
   static let funcKeyword = Parsers.token("func").token()
   static let anyKeyword = Parsers.token("Any").token()
   static let selfKeyword = Parsers.token("Self").token()
   static let optionalInout = padRight(inoutKeyword.?)
   static let optionalEllipsis = orEmpty(ellipsis.?)
   static let semicolon = Parsers.token(";").token()
   static let newLine = (Parsers.token("\n") <|> Parsers.token("\r") <|> Parsers.token("\r\n")).token()
   static let statementSeparator = semicolon <|> newLine

   static let identifierChar = digit <|> character
   static let identifierHead = identifierChar <|> underscore
   static let identifier = (curry { s, xs in s + xs.joined(separator: "") } <^> identifierHead <*> identifierChar.*).token()

   static let rawAttribute = curry { name, args in (name: name, args: args) } <^> identifier <*> Parsers.regex(pattern: "\\(.*\\)").token()
   static let attributeString = rawAttribute.map { "\($0.name)\($0.args)" } 
   static let optionalAttributesString = rawAttribute.many().map { xs in xs.map {"\($0.name)\($0.args)" }.joined(separator: " ") }.map { $0.isEmpty ? "" : $0 + " " }
   static let attribute = rawAttribute.map { Attribute(name: $0.name, argumentsClause: $0.args) } 

   static let accessModifierList = publicKeyword <|> privateKeyword <|> fileprivateKeyword <|> internalKeyword <|> openKeyword 
   static let accessModifier = ((accessModifierList <|> Parser(pure: "internal")).token()).map { AccessModifier(rawValue: $0) }

   static let typeAnnotation = curry { attrs, inOut, t in "\(attrs)\(inOut)\(t)" }
      <^> optionalAttributesString
      <*> optionalInout
      <*> embeddedType()

   static let typeAnnotationClause = curry { _, t in ": \(t)" } <^> colon <*> typeAnnotation

   static let typeName = identifier
   static let anyType = anyKeyword
   static let selfType = selfKeyword
   static let singleTupleType = openParens *> embeddedType() <* closeParens
   static let arrayType = curry { _, t, _ in "[\(t)]" } <^> openSquare <*> embeddedType() <*> closeSquare
   static let dictType = curry { _, k, _, v, _ in "[\(k):\(v)]" }
      <^> openSquare
      <*> embeddedType()
      <*> colon
      <*> embeddedType()
      <*> closeSquare

   static let optType = curry { t, _ in "\(t)?" } <^> embeddedType() <*> questionMark
   static let iuoType = curry { t, _ in "\(t)!" } <^> embeddedType() <*> bang

   static let funcArgsNoParams = openParens *> Parser(pure: "()") <* closeParens
   static let labeledArg = curry { name, t in "\(name)\(t)" } <^> identifier <*> typeAnnotationClause
   static let funcArg = typeAnnotation <|> labeledArg
   static let funcArgsList = funcArg.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let funcArgParams = curry { args, ellipsis in "\(args)\(ellipsis)" } <^> funcArgsList <*> optionalEllipsis
   static let funcArgsWithParams = openParens *> funcArgParams <* closeParens
   static let funcArguments = funcArgsNoParams <|> funcArgsWithParams
   static let optionalThrows = padRight((throwsKeyword <|> rethrowsKeyword).?)
   static let functionType = curry { attrs, args, thrws, _, t in "\(attrs)\(args)\(thrws) -> \(t)" }
      <^> optionalAttributesString
      <*> funcArguments
      <*> optionalThrows
      <*> arrowOperator
      <*> embeddedType()

   static let tupleElementName = identifier
   static let tupleElement = (curry { name, t in "\(name)\(t)" } <^> tupleElementName <*> typeAnnotationClause) <|> embeddedType()
   static let tupleElements = tupleElement.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let nonEmptyTuple = openParens *> tupleElements <* closeParens
   static let emptyTuple = openParens *> Parser(pure: "()") <* closeParens
   static let tupleType = emptyTuple <|> nonEmptyTuple

   static let protocolIdentifier = typeIdentifier()
   static let protocolCompositionType = protocolIdentifier.separatedBy(some: ampersand).map { xs in xs.joined(separator: " & ") }

   static let type = (
      anyType
      <|> selfType
      <|> singleTupleType
      <|> arrayType
      <|> dictType
      <|> optType
      <|> iuoType
      <|> functionType
      <|> tupleType
      <|> protocolCompositionType
   ).token()

   static func embeddedType() -> Parser<String> {
      return type
   }

   static let genericArg = type
   static let genericArgumentsList = genericArg.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let genericArgumentsClause = openAngle *> genericArgumentsList <* closeAngle
   static let typeIdentifierPart = curry { name, genArgs in "\(name)\(genArgs)" } <^>  typeName <*> genericArgumentsClause

   static func typeIdentifier() -> Parser<String> {
      return typeIdentifierPart.separatedBy(some: period).map { $0.joined(separator: ".") }
   }

   static let protocolList = typeIdentifier().separatedBy(some: comma).map { xs in xs.map { Inheritance.protocolRequirement($0) } }

   static let classInheritance = colon *> classKeyword.map { _ in [Inheritance.classRequirement] }
   static let protocolListInheritance = colon *> protocolList
   static let inheritanceList = classInheritance 
      <|> protocolListInheritance 
      <|> { xs in { xs + $0 } } <^> classInheritance <*> (comma *> protocolList)

   static let optionalModifier = optionalKeyword.map { _ in DeclarationModifier.isOptional }
   static let mutationModifier = mutationKeyword.map { _ in DeclarationModifier.isMutation }
   static let nonmutationModifier = nonmutationKeyword.map { _ in DeclarationModifier.isNonmutation }
   static let accessModifierListMapped: Parser<AccessModifier> = accessModifierList.map { AccessModifier(rawValue: $0)! } 
   static let memberAccessModifier = curry { (access: AccessModifier, setter: String?) in setter.map { _ in DeclarationModifier.setterAccess(access) } ?? .access(access) }
      <^> accessModifierListMapped
      <*> (openParens *> setKeyword <* closeParens).?

   static let propertyDeclarationModifiers = (optionalModifier <|> mutationModifier <|> nonmutationModifier <|> memberAccessModifier).many()
   static let variableDeclarationHead: Parser<(attributes: [Attribute], modifiers: [DeclarationModifier])> = curry { attrs, mods in (attributes: attrs, modifiers: mods) }
      <^> attribute.many() 
      <*> (propertyDeclarationModifiers <* varKeyword)

   static let variableName = identifier
   static let getterClause = curry { attrs, muts, getter in "\(attrs)\(muts)\(getter)" } <^> optionalAttributesString <*> orEmpty((mutationKeyword <|> nonmutationKeyword).?) <*> getKeyword
   static let setterClause = curry { attrs, muts, setter in "\(attrs)\(muts)\(setter)" } <^> optionalAttributesString <*> orEmpty((mutationKeyword <|> nonmutationKeyword).?) <*> setKeyword
   static let setterThanGetter = curry { setter, getter in (getter: getter, setter: setter) } <^> setterClause <*> getterClause 
   static let setterThanGetterClause = openBlock *> setterThanGetter <* closeBlock
   static let getterThanSetter = curry { getter, setter in (getter: getter, setter: setter) } <^> getterClause <*> orEmpty(setterClause.?)
   static let getterThanSetterClause = openBlock *> getterThanSetter <* closeBlock
   static let getterSetterClause = getterThanSetterClause <|> setterThanGetterClause
   static let propertyMember = curry { head, name, _, t, getset in PropertyMember(attributes: head.attributes, modifiers: head.modifiers, name: name, type: t, getterClause: getset.getter, setterClause: getset.setter) }
      <^> variableDeclarationHead
      <*> variableName
      <*> colon
      <*> typeAnnotation
      <*> getterSetterClause

   static let propertyProtocolMember = propertyMember.map { ProtocolMember.property($0) }

/*
   static let functionHead = attribute.many() <*> methodDeclarationModifiers.many() <*> funcKeyword
   static let methodMember = functionHead
      <*> functionName
      <*> optionalGenericParameterClause
      <*> functionSignature
      <*> optionalGenericWhereClause

   static let methodProtocolMember = methodMember.map { ProtocolMember.method($0) }
*/
   //TODO:
   static let protocolMember: Parser<ProtocolMember> = propertyProtocolMember // <|> methodProtocolMember
   static let protocolBlock: Parser<[ProtocolMember]> = openBlock *> protocolMember.separatedBy(statementSeparator) <* closeBlock

   static let protocolDeclaration = curry { attrs, optModifier, _, xs, members in ProtocolDeclaration(attributes: attrs, accessModifier: optModifier, inheritance: xs, members: members) }
      <^> attribute.many()
      <*> accessModifier
      <*> protocolKeyword
      <*> inheritanceList
      <*> protocolBlock
}
