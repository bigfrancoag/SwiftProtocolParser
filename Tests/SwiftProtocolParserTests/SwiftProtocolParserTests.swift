import XCTest
@testable import SwiftProtocolParser
@testable import ParseKit

class SwiftProtocolParserTests: XCTestCase {
   func testOrEmpty_nil() {
      let parser: Parser<String?> = Parser(pure: nil)
      let s = "test"

      let sut = SwiftProtocolParser.orEmpty(parser)
     
      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "")
      XCTAssertEqual(result[0].remaining, s)
   }

   func testOrEmpty_notnil() {
      let parser: Parser<String?> = Parser(pure: "blah")
      let s = "test"

      let sut = SwiftProtocolParser.orEmpty(parser)
     
      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "blah")
      XCTAssertEqual(result[0].remaining, s)
   }

   func testPadRight_nil() {
      let parser: Parser<String?> = Parser(pure: nil)
      let s = "test"

      let sut = SwiftProtocolParser.padRight(parser)
     
      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "")
      XCTAssertEqual(result[0].remaining, s)
   }

   func testPadRight_notnil() {
      let parser: Parser<String?> = Parser(pure: "blah")
      let s = "test"

      let sut = SwiftProtocolParser.padRight(parser)
     
      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "blah ")
      XCTAssertEqual(result[0].remaining, s)
   }

   func testAnyChar_emptyString_returns_emptyArray() {
      let chars = ""
      let s = "test"

      let sut = SwiftProtocolParser.anyChar(from: chars)

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testAnyChar_abc_returns_emptyArray() {
      let chars = "abc"
      let s = "test"

      let sut = SwiftProtocolParser.anyChar(from: chars)

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testAnyChar_rst_returns_t_est() {
      let chars = "rst"
      let s = "test"

      let sut = SwiftProtocolParser.anyChar(from: chars)

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "t")
      XCTAssertEqual(result[0].remaining, "est")
   }

   func testDigit_on_test_returns_emptyArray() {
      let s = "test"

      let sut = SwiftProtocolParser.digit

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testDigit_on_1234_with_leading_space_returns_emptyArray() {
      let s = " 1234"

      let sut = SwiftProtocolParser.digit

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testDigit_on_1234_returns_1_234() {
      let s = "1234"

      let sut = SwiftProtocolParser.digit

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "1")
      XCTAssertEqual(result[0].remaining, "234")
   }

   func testCharacter_on_1234_returns_emptyArray() {
      let s = "1234"

      let sut = SwiftProtocolParser.character

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testCharacter_on_test_with_leading_space_returns_emptyArray() {
      let s = " test"

      let sut = SwiftProtocolParser.character

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testCharacter_on_test_returns_t_est() {
      let s = "test"

      let sut = SwiftProtocolParser.character

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "t")
      XCTAssertEqual(result[0].remaining, "est")
   }

   func testCharacter_on_TEST_returns_T_EST() {
      let s = "TEST"

      let sut = SwiftProtocolParser.character

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "T")
      XCTAssertEqual(result[0].remaining, "EST")
   }

   func testUnderscore_on_test_returns_emptyArray() {
      let s = "test"

      let sut = SwiftProtocolParser.underscore

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testUnderscore_on__test_with_leading_space_returns_emptyArray() {
      let s = " _test"

      let sut = SwiftProtocolParser.underscore

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testUnderscore_on__test_returns___test() {
      let s = "_test"

      let sut = SwiftProtocolParser.underscore

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "_")
      XCTAssertEqual(result[0].remaining, "test")
   }

   func testComma_on_test_returns_emptyArray() {
      let s = "test"

      let sut = SwiftProtocolParser.comma

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testComma_on_comma_test_with_leading_space_returns_comma_test() {
      let s = " ,test"

      let sut = SwiftProtocolParser.comma

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, ",")
      XCTAssertEqual(result[0].remaining, "test")
   }

   func testComma_on_comma_test_returns_comma_test() {
      let s = ",test"

      let sut = SwiftProtocolParser.comma

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, ",")
      XCTAssertEqual(result[0].remaining, "test")
   }

   func testProtocolKeyword_on_test_returns_emptyArray() {
      let s = "test"

      let sut = SwiftProtocolParser.protocolKeyword

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testProtocolKeyword_on_protocol_with_leading_space_returns_protocol_() {
      let s = " protocol"

      let sut = SwiftProtocolParser.protocolKeyword

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "protocol")
      XCTAssertEqual(result[0].remaining, "")
   }

   func testProtocolKeyword_on_protocol_returns_protocol_() {
      let s = "protocol"

      let sut = SwiftProtocolParser.protocolKeyword

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "protocol")
      XCTAssertEqual(result[0].remaining, "")
   }

   func testIdentifier_on_pipetest_returns_empty() {
      let s = "|test"

      let sut = SwiftProtocolParser.identifier

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testIdentifier_on_9test_returns_empty() {
      let s = "9test"

      let sut = SwiftProtocolParser.identifier

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testIdentifier_on__test_returns__test_empty() {
      let s = "_test"

      let sut = SwiftProtocolParser.identifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "_test")
      XCTAssertEqual(result[0].remaining, "")
   }

   func testIdentifier_on_test9_returns_test9_empty() {
      let s = "test9"

      let sut = SwiftProtocolParser.identifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "test9")
      XCTAssertEqual(result[0].remaining, "")
   }

   func testIdentifier_on_test__it_out_with_leading_space_returns_test__it_out() {
      let s = "  test_it out"

      let sut = SwiftProtocolParser.identifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "test_it")
      XCTAssertEqual(result[0].remaining, " out")
   }

   func testInvalidRawAttribute_returns_empty() {
      let s = "blah"

      let sut = SwiftProtocolParser.rawAttribute

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testSimpleRawAttribute_returns_name_no_args() {
      let s = "@discardableResult;"

      let sut = SwiftProtocolParser.rawAttribute

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result.name, "discardableResult")
      XCTAssertEqual(result[0].result.args, "")
      XCTAssertEqual(result[0].remaining, ";")
   }

   func testComplexRawAttribute_returns_name_and_args() {
      let s = "@available(*, unavailable, renamed: \"MyRenamedProtocol\");"

      let sut = SwiftProtocolParser.rawAttribute

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result.name, "available")
      XCTAssertEqual(result[0].result.args, "(*, unavailable, renamed: \"MyRenamedProtocol\")")
      XCTAssertEqual(result[0].remaining, ";")
   }

   func testInvalidOptionalAttributeString_returns_empty_remainig() {
      let s = "some stuff"

      let sut = SwiftProtocolParser.optionalAttributesString

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "")
      XCTAssertEqual(result[0].remaining, "some stuff")
   }

   func testSingleOptionalAttributeString_returns_attribute_remainig() {
      let s = "@attr some stuff"

      let sut = SwiftProtocolParser.optionalAttributesString

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "@attr ")
      XCTAssertEqual(result[0].remaining, " some stuff")
   }

   func testMultiOptionalAttributeString_returns_attributes_remainig() {
      let s = "@attr @some stuff"

      let sut = SwiftProtocolParser.optionalAttributesString

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "@attr @some ")
      XCTAssertEqual(result[0].remaining, " stuff")
   }

   func testAccessModifierList_invalid_returns_empty() {
      let s = "test"

      let sut = SwiftProtocolParser.accessModifiers

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testAccessModifierList_valid_returns_modifier() {
      let s = "public stuff"

      let sut = SwiftProtocolParser.accessModifiers

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "public")
      XCTAssertEqual(result[0].remaining, " stuff")
   }

   func testTypeAccessModifier_invalid_returns_internal() {
      let s = "test stuff"

      let sut = SwiftProtocolParser.typeAccessModifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result.rawValue, "internal")
      XCTAssertEqual(result[0].remaining, "test stuff")
   }

   func testTypeAccessModifier_valid_returns_modifier() {
      let s = " fileprivate test stuff"

      let sut = SwiftProtocolParser.typeAccessModifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result.rawValue, "fileprivate")
      XCTAssertEqual(result[0].remaining, " test stuff")
   }

   func testTypeString() {
      let s = "String test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeSingleTupleInt() {
      let s = "(Int) test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int)")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeOptionalInt() {
      let s = "Int? test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Int?")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeOptionalOptionalBool() {
      let s = "Bool?? test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Bool??")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIUODouble() {
      let s = "Double! test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Double!")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAny() {
      let s = "Any test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Any")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeOptionalAny() {
      let s = "Any? test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Any?")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeSelf() {
      let s = "Self test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Self")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeStringArray() {
      let s = "[String] test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "[String]")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeOptionalStringArray() {
      let s = "[String?] test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "[String?]")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntArrayArray() {
      let s = "[[Int]] test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "[[Int]]")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntDoubleDict() {
      let s = "[Int:Double] test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "[Int:Double]")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntDoubleArrayDict() {
      let s = "[Int : [Double]] test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)

      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "[Int:[Double]]")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntBoolTuple() {
      let s = "(Int,Bool) test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int, Bool)")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeStringStringTupleIntArrayTuple() {
      let s = "( (String  , String) ,  [Int]   ) test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "((String, String), [Int])")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntIntIntStringTuple() {
      let s = "(Int,Int,Int,String) test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int, Int, Int, String)")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeEmptyFunc() {
      let s = "() -> () test"
      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "() -> ()")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeSupplierFunc() {
      let s = "()-> String test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "() -> String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeConsumerFunc() {
      let s = "(Int) -> () test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int) -> ()")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeBasicFunc() {
      let s = "(Bool) -> String test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Bool) -> String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeFuncInToStringFunc() {
      let s = "((String) -> Bool) -> Int test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "((String) -> Bool) -> Int")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntToFuncFunc() {
      let s = "(Int) -> ((Bool) -> String) test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int) -> ((Bool) -> String)")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntToCurriedFunc() {
      let s = "(Int) -> (Bool) -> String test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int) -> (Bool) -> String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeIntBoolStringBiFunc() {
      let s = "(Int,Bool) -> String test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "(Int, Bool) -> String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeArrayGeneric() {
      let s = "Array<String> test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Array<String>")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeDictGeneric() {
      let s = "Dictionary<String, Int> test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Dictionary<String, Int>")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeProtocolComposition() {
      let s = "Hashable & RawRepresentable test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Hashable & RawRepresentable")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeMultiPartIdentifier() {
      let s = "Iterator.Element test"

      let sut = SwiftProtocolParser.type

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "Iterator.Element")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationFull() {
      let s = "@blah inout String test"

      let sut = SwiftProtocolParser.typeAnnotation

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "@blah inout String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationAttribute() {
      let s = "@blah String test"

      let sut = SwiftProtocolParser.typeAnnotation

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "@blah String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationInout() {
      let s = "inout String test"

      let sut = SwiftProtocolParser.typeAnnotation

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "inout String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationSimple() {
      let s = "String test"

      let sut = SwiftProtocolParser.typeAnnotation

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, "String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationClauseInvalid() {
      let s = "String test"

      let sut = SwiftProtocolParser.typeAnnotationClause

      let result = sut.run(on: s)
      XCTAssertTrue(result.isEmpty)
   }

   func testTypeAnnotationClauseLeadingSpace() {
      let s = " : String test"

      let sut = SwiftProtocolParser.typeAnnotationClause

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, ": String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testTypeAnnotationClause() {
      let s = ":String test"

      let sut = SwiftProtocolParser.typeAnnotationClause

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      XCTAssertEqual(result[0].result, ": String")
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testInheritanceListClass() {
      let s = ":class test"

      let sut = SwiftProtocolParser.inheritanceList

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertEqual(result[0].result.count, 1)
      guard result[0].result.count == 1 else { return }
      XCTAssertEqual(result[0].result[0], .classRequirement)
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testInheritanceListSimple() {
      let s = ":Equatable test"

      let sut = SwiftProtocolParser.inheritanceList

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertEqual(result[0].result.count, 1)
      guard result[0].result.count == 1 else { return }
      XCTAssertEqual(result[0].result[0], .protocolRequirement("Equatable"))
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testInheritanceListMulti() {
      let s = ":Equatable, Hashable test"

      let sut = SwiftProtocolParser.inheritanceList

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertEqual(result[0].result.count, 2)
      guard result[0].result.count == 2 else { return }
      XCTAssertEqual(result[0].result[0], .protocolRequirement("Equatable"))
      XCTAssertEqual(result[0].result[1], .protocolRequirement("Hashable"))
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testInheritanceListMixedSimple() {
      let s = ":class, Equatable test"

      let sut = SwiftProtocolParser.inheritanceList

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertEqual(result[0].result.count, 2)
      guard result[0].result.count == 2 else { return }
      XCTAssertEqual(result[0].result[0], .classRequirement)
      XCTAssertEqual(result[0].result[1], .protocolRequirement("Equatable"))
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testInheritanceListMixedMulti() {
      let s = ":class, Equatable, Hashable test"

      let sut = SwiftProtocolParser.inheritanceList

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertEqual(result[0].result.count, 3)
      guard result[0].result.count == 3 else { return }
      XCTAssertEqual(result[0].result[0], .classRequirement)
      XCTAssertEqual(result[0].result[1], .protocolRequirement("Equatable"))
      XCTAssertEqual(result[0].result[2], .protocolRequirement("Hashable"))
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testOptionalModifier() {
      let s = " optional test"

      let sut = SwiftProtocolParser.optionalModifier

      let result = sut.run(on: s)
      XCTAssertFalse(result.isEmpty)
      XCTAssertEqual(result.count, 1)
      guard result.count == 1 else { return }
      XCTAssertTrue(result[0].result == DeclarationModifier.isOptional)
      XCTAssertEqual(result[0].remaining, " test")
   }

   func testLinuxTestSuiteIncludesAllTests() {
#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
      let thisClass = type(of: self)
      let linuxTestCount = thisClass.allTests.count
      let darwinTestCount = Int(thisClass.defaultTestSuite().testCaseCount)
      XCTAssertEqual(linuxTestCount, darwinTestCount, "\(darwinTestCount - linuxTestCount) tests are missing from allTests")
#endif
   }

   static var allTests = [
      ("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests)
      , ("testOrEmpty_nil", testOrEmpty_nil)
      , ("testOrEmpty_notnil", testOrEmpty_notnil)
      , ("testPadRight_nil", testPadRight_nil)
      , ("testPadRight_notnil", testPadRight_notnil)
      , ("testAnyChar_emptyString_returns_emptyArray", testAnyChar_emptyString_returns_emptyArray)
      , ("testAnyChar_abc_returns_emptyArray", testAnyChar_abc_returns_emptyArray)
      , ("testAnyChar_rst_returns_t_est", testAnyChar_rst_returns_t_est)
      , ("testDigit_on_test_returns_emptyArray", testDigit_on_test_returns_emptyArray)
      , ("testDigit_on_1234_with_leading_space_returns_emptyArray", testDigit_on_1234_with_leading_space_returns_emptyArray)
      , ("testDigit_on_1234_returns_1_234", testDigit_on_1234_returns_1_234)
      , ("testCharacter_on_1234_returns_emptyArray", testCharacter_on_1234_returns_emptyArray)
      , ("testCharacter_on_test_with_leading_space_returns_emptyArray", testCharacter_on_test_with_leading_space_returns_emptyArray)
      , ("testCharacter_on_test_returns_t_est", testCharacter_on_test_returns_t_est)
      , ("testCharacter_on_TEST_returns_T_EST", testCharacter_on_TEST_returns_T_EST)
      , ("testUnderscore_on_test_returns_emptyArray", testUnderscore_on_test_returns_emptyArray)
      , ("testUnderscore_on__test_with_leading_space_returns_emptyArray", testUnderscore_on__test_with_leading_space_returns_emptyArray)
      , ("testUnderscore_on__test_returns___test", testUnderscore_on__test_returns___test)
      , ("testComma_on_test_returns_emptyArray", testComma_on_test_returns_emptyArray)
      , ("testComma_on_comma_test_with_leading_space_returns_comma_test", testComma_on_comma_test_with_leading_space_returns_comma_test)
      , ("testComma_on_comma_test_returns_comma_test", testComma_on_comma_test_returns_comma_test)
      , ("testProtocolKeyword_on_test_returns_emptyArray", testProtocolKeyword_on_test_returns_emptyArray)
      , ("testProtocolKeyword_on_protocol_with_leading_space_returns_protocol_", testProtocolKeyword_on_protocol_with_leading_space_returns_protocol_)
      , ("testProtocolKeyword_on_protocol_returns_protocol_", testProtocolKeyword_on_protocol_returns_protocol_)
      , ("testIdentifier_on_pipetest_returns_empty", testIdentifier_on_pipetest_returns_empty)
      , ("testIdentifier_on_9test_returns_empty", testIdentifier_on_9test_returns_empty)
      , ("testIdentifier_on__test_returns__test_empty", testIdentifier_on__test_returns__test_empty)
      , ("testIdentifier_on_test9_returns_test9_empty", testIdentifier_on_test9_returns_test9_empty)
      , ("testIdentifier_on_test__it_out_with_leading_space_returns_test__it_out", testIdentifier_on_test__it_out_with_leading_space_returns_test__it_out)
      , ("testInvalidRawAttribute_returns_empty", testInvalidRawAttribute_returns_empty)
      , ("testSimpleRawAttribute_returns_name_no_args", testSimpleRawAttribute_returns_name_no_args)
      , ("testComplexRawAttribute_returns_name_and_args", testComplexRawAttribute_returns_name_and_args)
      , ("testInvalidOptionalAttributeString_returns_empty_remainig", testInvalidOptionalAttributeString_returns_empty_remainig)
      , ("testSingleOptionalAttributeString_returns_attribute_remainig", testSingleOptionalAttributeString_returns_attribute_remainig)
      , ("testMultiOptionalAttributeString_returns_attributes_remainig", testMultiOptionalAttributeString_returns_attributes_remainig)
      , ("testAccessModifierList_invalid_returns_empty", testAccessModifierList_invalid_returns_empty)
      , ("testAccessModifierList_valid_returns_modifier", testAccessModifierList_valid_returns_modifier)
      , ("testTypeAccessModifier_invalid_returns_internal", testTypeAccessModifier_invalid_returns_internal)
      , ("testTypeAccessModifier_valid_returns_modifier", testTypeAccessModifier_valid_returns_modifier)
      , ("testTypeString", testTypeString)
      , ("testTypeOptionalInt", testTypeOptionalInt)
      , ("testTypeOptionalOptionalBool", testTypeOptionalOptionalBool)
      , ("testTypeIUODouble", testTypeIUODouble)
      , ("testTypeAny", testTypeAny)
      , ("testTypeOptionalAny", testTypeOptionalAny)
      , ("testTypeSelf", testTypeSelf)
      , ("testTypeSingleTupleInt", testTypeSingleTupleInt)
      , ("testTypeStringArray", testTypeStringArray)
      , ("testTypeOptionalStringArray", testTypeOptionalStringArray)
      , ("testTypeIntArrayArray", testTypeIntArrayArray)
      , ("testTypeIntDoubleDict", testTypeIntDoubleDict)
      , ("testTypeIntDoubleArrayDict", testTypeIntDoubleArrayDict)
      , ("testTypeIntBoolTuple", testTypeIntBoolTuple)
      , ("testTypeStringStringTupleIntArrayTuple", testTypeStringStringTupleIntArrayTuple)
      , ("testTypeIntIntIntStringTuple", testTypeIntIntIntStringTuple)
      , ("testTypeEmptyFunc", testTypeEmptyFunc)
      , ("testTypeSupplierFunc", testTypeSupplierFunc)
      , ("testTypeConsumerFunc", testTypeConsumerFunc)
      , ("testTypeBasicFunc", testTypeBasicFunc)
      , ("testTypeFuncInToStringFunc", testTypeFuncInToStringFunc)
      , ("testTypeIntToFuncFunc", testTypeIntToFuncFunc)
      , ("testTypeIntToCurriedFunc", testTypeIntToCurriedFunc)
      , ("testTypeIntBoolStringBiFunc", testTypeIntBoolStringBiFunc)
      , ("testTypeArrayGeneric", testTypeArrayGeneric)
      , ("testTypeDictGeneric", testTypeDictGeneric)
      , ("testTypeProtocolComposition", testTypeProtocolComposition)
      , ("testTypeMultiPartIdentifier", testTypeMultiPartIdentifier)
      , ("testTypeAnnotationFull", testTypeAnnotationFull)
      , ("testTypeAnnotationAttribute", testTypeAnnotationAttribute)
      , ("testTypeAnnotationInout", testTypeAnnotationInout)
      , ("testTypeAnnotationSimple", testTypeAnnotationSimple)
      , ("testTypeAnnotationClause", testTypeAnnotationClause)
      , ("testTypeAnnotationClauseInvalid", testTypeAnnotationClauseInvalid)
      , ("testTypeAnnotationClauseLeadingSpace", testTypeAnnotationClauseLeadingSpace)
      , ("testInheritanceListClass", testInheritanceListClass)
      , ("testInheritanceListSimple", testInheritanceListSimple)
      , ("testInheritanceListMulti", testInheritanceListMulti)
      , ("testInheritanceListMixedSimple", testInheritanceListMixedSimple)
      , ("testInheritanceListMixedMulti", testInheritanceListMixedMulti)
      , ("testOptionalModifier", testOptionalModifier)
   ]
}
