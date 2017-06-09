func curry<T1, T2, U>(_ f: @escaping (T1, T2) -> U) -> (T1) -> (T2) -> U {
   return { t1 in { t2 in f(t1, t2) } }
}

func curry<T1, T2, T3, U>(_ f: @escaping (T1, T2, T3) -> U) -> (T1) -> (T2) -> (T3) -> U {
   return { t1 in { t2 in { t3 in f(t1, t2, t3) } } }
}

func curry<T1, T2, T3, T4, U>(_ f: @escaping (T1, T2, T3, T4) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> U {
   return { t1 in { t2 in { t3 in { t4 in f(t1, t2, t3, t4) } } } }
}

func curry<T1, T2, T3, T4, T5, U>(_ f: @escaping (T1, T2, T3, T4, T5) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> (T5) -> U {
   return { t1 in { t2 in { t3 in { t4 in { t5 in f(t1, t2, t3, t4, t5) } } } } }
}

func curry<T1, T2, T3, T4, T5, T6, U>(_ f: @escaping (T1, T2, T3, T4, T5, T6) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> (T5) -> (T6) -> U {
   return { t1 in { t2 in { t3 in { t4 in { t5 in { t6 in f(t1, t2, t3, t4, t5, t6) } } } } } }
}

func curry<T1, T2, T3, T4, T5, T6, T7, U>(_ f: @escaping (T1, T2, T3, T4, T5, T6, T7) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> (T5) -> (T6) -> (T7) -> U {
   return { t1 in { t2 in { t3 in { t4 in { t5 in { t6 in { t7 in f(t1, t2, t3, t4, t5, t6, t7) } } } } } } }
}

func curry<T1, T2, T3, T4, T5, T6, T7, T8, U>(_ f: @escaping (T1, T2, T3, T4, T5, T6, T7, T8) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> (T5) -> (T6) -> (T7) -> (T8) -> U {
   return { t1 in { t2 in { t3 in { t4 in { t5 in { t6 in { t7 in { t8 in f(t1, t2, t3, t4, t5, t6, t7, t8) } } } } } } } }
}
