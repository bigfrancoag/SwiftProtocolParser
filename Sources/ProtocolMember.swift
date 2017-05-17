public enum ProtocolMember {
   case initializer(InitializerMember)
   case property(PropertyMember)
   case method(MethodMember)
   case sub(SubscriptMember)
   case associatedType(AssociatedTypeMember)
}
