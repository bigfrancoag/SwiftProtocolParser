import ParseKit

extension Parser {
   func debug(_ s: String = "Found") -> Parser {
      return self.map {
         print("\(s): \($0)")
         return $0
      }
   }
}

public enum SwiftProtocolParser {
   static func operatorHeadCharString() -> String {
      var chars = "/=-+!*%<>&|^~?"

      //TODO: Add all unicode accepatable chars
      chars += "\u{A1}\u{A2}\u{A3}\u{A4}\u{A5}\u{A6}\u{A7}"
/*
      chars += "\u{A9}\u{AA}\u{AB}"
      chars += "\u{AC}\u{AD}\u{AE}"
      chars += "\u{B0}\u{B1}\u{B6}\u{BB}\u{BF}\u{D7}\u{F7}"
      chars += "\u{2016}\u{2017}\u{2020}\u{2021}\u{2022}\u{2023}\u{2024}\u{2025}\u{2026}\u{2027}"
      chars += "\u{2030}\u{2031}\u{2032}\u{2033}\u{2034}\u{2035}\u{2036}\u{2037}\u{2038}\u{2039}\u{203A}\u{203B}\u{203C}\u{203D}\u{203E}"
      chars += "\u{2041}\u{2042}\u{2043}\u{2044}\u{2045}\u{2046}\u{2047}\u{2048}\u{2049}\u{204A}\u{204B}\u{204C}\u{204D}\u{204E}\u{204F}\u{2050}\u{2051}\u{2052}\u{2053}"
      chars += "\u{2055}\u{2056}\u{2057}\u{2058}\u{2059}\u{205A}\u{205B}\u{205C}\u{205D}\u{205E}"
      chars += "\u{2190}\u{2191}\u{2192}\u{2193}\u{2194}\u{2195}\u{2196}\u{2197}\u{2198}\u{2199}\u{219A}\u{219B}\u{219C}\u{219D}\u{219E}\u{219F}"
      chars += "\u{21A0}\u{21A1}\u{21A2}\u{21A3}\u{21A4}\u{21A5}\u{21A6}\u{21A7}\u{21A8}\u{21A9}\u{21AA}\u{21AB}\u{21AC}\u{21AD}\u{21AE}\u{21AF}"
      chars += "\u{21B0}\u{21B1}\u{21B2}\u{21B3}\u{21B4}\u{21B5}\u{21B6}\u{21B7}\u{21B8}\u{21B9}\u{21BA}\u{21BB}\u{21BC}\u{21BD}\u{21BE}\u{21BF}"
      chars += "\u{21C0}\u{21C1}\u{21C2}\u{21C3}\u{21C4}\u{21C5}\u{21C6}\u{21C7}\u{21C8}\u{21C9}\u{21CA}\u{21CB}\u{21CC}\u{21CD}\u{21CE}\u{21CF}"
      chars += "\u{21D0}\u{21D1}\u{21D2}\u{21D3}\u{21D4}\u{21D5}\u{21D6}\u{21D7}\u{21D8}\u{21D9}\u{21DA}\u{21DB}\u{21DC}\u{21DD}\u{21DE}\u{21DF}"
      chars += "\u{21E0}\u{21E1}\u{21E2}\u{21E3}\u{21E4}\u{21E5}\u{21E6}\u{21E7}\u{21E8}\u{21E9}\u{21EA}\u{21EB}\u{21EC}\u{21ED}\u{21EE}\u{21EF}"
      chars += "\u{21F0}\u{21F1}\u{21F2}\u{21F3}\u{21F4}\u{21F5}\u{21F6}\u{21F7}\u{21F8}\u{21F9}\u{21FA}\u{21FB}\u{21FC}\u{21FD}\u{21FE}\u{21FF}"
      chars += "\u{2200}\u{2201}\u{2202}\u{2203}\u{2204}\u{2205}\u{2206}\u{2207}\u{2208}\u{2209}\u{220A}\u{220B}\u{220C}\u{220D}\u{220E}\u{220F}"
      chars += "\u{2210}\u{2211}\u{2212}\u{2213}\u{2214}\u{2215}\u{2216}\u{2217}\u{2218}\u{2219}\u{221A}\u{221B}\u{221C}\u{221D}\u{221E}\u{221F}"
      chars += "\u{2220}\u{2221}\u{2222}\u{2223}\u{2224}\u{2225}\u{2226}\u{2227}\u{2228}\u{2229}\u{222A}\u{222B}\u{222C}\u{222D}\u{222E}\u{222F}"
      chars += "\u{2230}\u{2231}\u{2232}\u{2233}\u{2234}\u{2235}\u{2236}\u{2237}\u{2238}\u{2239}\u{223A}\u{223B}\u{223C}\u{223D}\u{223E}\u{223F}"
      chars += "\u{2240}\u{2241}\u{2242}\u{2243}\u{2244}\u{2245}\u{2246}\u{2247}\u{2248}\u{2249}\u{224A}\u{224B}\u{224C}\u{224D}\u{224E}\u{224F}"
      chars += "\u{2250}\u{2251}\u{2252}\u{2253}\u{2254}\u{2255}\u{2256}\u{2257}\u{2258}\u{2259}\u{225A}\u{225B}\u{225C}\u{225D}\u{225E}\u{225F}"
      chars += "\u{2260}\u{2261}\u{2262}\u{2263}\u{2264}\u{2265}\u{2266}\u{2267}\u{2268}\u{2269}\u{226A}\u{226B}\u{226C}\u{226D}\u{226E}\u{226F}"
      chars += "\u{2270}\u{2271}\u{2272}\u{2273}\u{2274}\u{2275}\u{2276}\u{2277}\u{2278}\u{2279}\u{227A}\u{227B}\u{227C}\u{227D}\u{227E}\u{227F}"
      chars += "\u{2280}\u{2281}\u{2282}\u{2283}\u{2284}\u{2285}\u{2286}\u{2287}\u{2288}\u{2289}\u{228A}\u{228B}\u{228C}\u{228D}\u{228E}\u{228F}"
      chars += "\u{2290}\u{2291}\u{2292}\u{2293}\u{2294}\u{2295}\u{2296}\u{2297}\u{2298}\u{2299}\u{229A}\u{229B}\u{229C}\u{229D}\u{229E}\u{229F}"
      chars += "\u{22A0}\u{22A1}\u{22A2}\u{22A3}\u{22A4}\u{22A5}\u{22A6}\u{22A7}\u{22A8}\u{22A9}\u{22AA}\u{22AB}\u{22AC}\u{22AD}\u{22AE}\u{22AF}"
      chars += "\u{22B0}\u{22B1}\u{22B2}\u{22B3}\u{22B4}\u{22B5}\u{22B6}\u{22B7}\u{22B8}\u{22B9}\u{22BA}\u{22BB}\u{22BC}\u{22BD}\u{22BE}\u{22BF}"
      chars += "\u{22C0}\u{22C1}\u{22C2}\u{22C3}\u{22C4}\u{22C5}\u{22C6}\u{22C7}\u{22C8}\u{22C9}\u{22CA}\u{22CB}\u{22CC}\u{22CD}\u{22CE}\u{22CF}"
      chars += "\u{22D0}\u{22D1}\u{22D2}\u{22D3}\u{22D4}\u{22D5}\u{22D6}\u{22D7}\u{22D8}\u{22D9}\u{22DA}\u{22DB}\u{22DC}\u{22DD}\u{22DE}\u{22DF}"
      chars += "\u{22E0}\u{22E1}\u{22E2}\u{22E3}\u{22E4}\u{22E5}\u{22E6}\u{22E7}\u{22E8}\u{22E9}\u{22EA}\u{22EB}\u{22EC}\u{22ED}\u{22EE}\u{22EF}"
      chars += "\u{22F0}\u{22F1}\u{22F2}\u{22F3}\u{22F4}\u{22F5}\u{22F6}\u{22F7}\u{22F8}\u{22F9}\u{22FA}\u{22FB}\u{22FC}\u{22FD}\u{22FE}\u{22FF}"
      chars += "\u{2300}\u{2301}\u{2302}\u{2303}\u{2304}\u{2305}\u{2306}\u{2307}\u{2308}\u{2309}\u{230A}\u{230B}\u{230C}\u{230D}\u{230E}\u{230F}"
      chars += "\u{2310}\u{2311}\u{2312}\u{2313}\u{2314}\u{2315}\u{2316}\u{2317}\u{2318}\u{2319}\u{231A}\u{231B}\u{231C}\u{231D}\u{231E}\u{231F}"
      chars += "\u{2320}\u{2321}\u{2322}\u{2323}\u{2324}\u{2325}\u{2326}\u{2327}\u{2328}\u{2329}\u{232A}\u{232B}\u{232C}\u{232D}\u{232E}\u{232F}"
      chars += "\u{2330}\u{2331}\u{2332}\u{2333}\u{2334}\u{2335}\u{2336}\u{2337}\u{2338}\u{2339}\u{233A}\u{233B}\u{233C}\u{233D}\u{233E}\u{233F}"
      chars += "\u{2340}\u{2341}\u{2342}\u{2343}\u{2344}\u{2345}\u{2346}\u{2347}\u{2348}\u{2349}\u{234A}\u{234B}\u{234C}\u{234D}\u{234E}\u{234F}"
      chars += "\u{2350}\u{2351}\u{2352}\u{2353}\u{2354}\u{2355}\u{2356}\u{2357}\u{2358}\u{2359}\u{235A}\u{235B}\u{235C}\u{235D}\u{235E}\u{235F}"
      chars += "\u{2360}\u{2361}\u{2362}\u{2363}\u{2364}\u{2365}\u{2366}\u{2367}\u{2368}\u{2369}\u{236A}\u{236B}\u{236C}\u{236D}\u{236E}\u{236F}"
      chars += "\u{2370}\u{2371}\u{2372}\u{2373}\u{2374}\u{2375}\u{2376}\u{2377}\u{2378}\u{2379}\u{237A}\u{237B}\u{237C}\u{237D}\u{237E}\u{237F}"
      chars += "\u{2380}\u{2381}\u{2382}\u{2383}\u{2384}\u{2385}\u{2386}\u{2387}\u{2388}\u{2389}\u{238A}\u{238B}\u{238C}\u{238D}\u{238E}\u{238F}"
      chars += "\u{2390}\u{2391}\u{2392}\u{2393}\u{2394}\u{2395}\u{2396}\u{2397}\u{2398}\u{2399}\u{239A}\u{239B}\u{239C}\u{239D}\u{239E}\u{239F}"
      chars += "\u{23A0}\u{23A1}\u{23A2}\u{23A3}\u{23A4}\u{23A5}\u{23A6}\u{23A7}\u{23A8}\u{23A9}\u{23AA}\u{23AB}\u{23AC}\u{23AD}\u{23AE}\u{23AF}"
      chars += "\u{23B0}\u{23B1}\u{23B2}\u{23B3}\u{23B4}\u{23B5}\u{23B6}\u{23B7}\u{23B8}\u{23B9}\u{23BA}\u{23BB}\u{23BC}\u{23BD}\u{23BE}\u{23BF}"
      chars += "\u{23C0}\u{23C1}\u{23C2}\u{23C3}\u{23C4}\u{23C5}\u{23C6}\u{23C7}\u{23C8}\u{23C9}\u{23CA}\u{23CB}\u{23CC}\u{23CD}\u{23CE}\u{23CF}"
      chars += "\u{23D0}\u{23D1}\u{23D2}\u{23D3}\u{23D4}\u{23D5}\u{23D6}\u{23D7}\u{23D8}\u{23D9}\u{23DA}\u{23DB}\u{23DC}\u{23DD}\u{23DE}\u{23DF}"
      chars += "\u{23E0}\u{23E1}\u{23E2}\u{23E3}\u{23E4}\u{23E5}\u{23E6}\u{23E7}\u{23E8}\u{23E9}\u{23EA}\u{23EB}\u{23EC}\u{23ED}\u{23EE}\u{23EF}"
      chars += "\u{23F0}\u{23F1}\u{23F2}\u{23F3}\u{23F4}\u{23F5}\u{23F6}\u{23F7}\u{23F8}\u{23F9}\u{23FA}\u{23FB}\u{23FC}\u{23FD}\u{23FE}\u{23FF}"

      chars += "\u{2500}\u{2501}\u{2502}\u{2503}\u{2504}\u{2505}\u{2506}\u{2507}\u{2508}\u{2509}\u{250A}\u{250B}\u{250C}\u{250D}\u{250E}\u{250F}"
      chars += "\u{2510}\u{2511}\u{2512}\u{2513}\u{2514}\u{2515}\u{2516}\u{2517}\u{2518}\u{2519}\u{251A}\u{251B}\u{251C}\u{251D}\u{251E}\u{251F}"
      chars += "\u{2520}\u{2521}\u{2522}\u{2523}\u{2524}\u{2525}\u{2526}\u{2527}\u{2528}\u{2529}\u{252A}\u{252B}\u{252C}\u{252D}\u{252E}\u{252F}"
      chars += "\u{2530}\u{2531}\u{2532}\u{2533}\u{2534}\u{2535}\u{2536}\u{2537}\u{2538}\u{2539}\u{253A}\u{253B}\u{253C}\u{253D}\u{253E}\u{253F}"
      chars += "\u{2540}\u{2541}\u{2542}\u{2543}\u{2544}\u{2545}\u{2546}\u{2547}\u{2548}\u{2549}\u{254A}\u{254B}\u{254C}\u{254D}\u{254E}\u{254F}"
      chars += "\u{2550}\u{2551}\u{2552}\u{2553}\u{2554}\u{2555}\u{2556}\u{2557}\u{2558}\u{2559}\u{255A}\u{255B}\u{255C}\u{255D}\u{255E}\u{255F}"
      chars += "\u{2560}\u{2561}\u{2562}\u{2563}\u{2564}\u{2565}\u{2566}\u{2567}\u{2568}\u{2569}\u{256A}\u{256B}\u{256C}\u{256D}\u{256E}\u{256F}"
      chars += "\u{2570}\u{2571}\u{2572}\u{2573}\u{2574}\u{2575}\u{2576}\u{2577}\u{2578}\u{2579}\u{257A}\u{257B}\u{257C}\u{257D}\u{257E}\u{257F}"
      chars += "\u{2580}\u{2581}\u{2582}\u{2583}\u{2584}\u{2585}\u{2586}\u{2587}\u{2588}\u{2589}\u{258A}\u{258B}\u{258C}\u{258D}\u{258E}\u{258F}"
      chars += "\u{2590}\u{2591}\u{2592}\u{2593}\u{2594}\u{2595}\u{2596}\u{2597}\u{2598}\u{2599}\u{259A}\u{259B}\u{259C}\u{259D}\u{259E}\u{259F}"
      chars += "\u{25A0}\u{25A1}\u{25A2}\u{25A3}\u{25A4}\u{25A5}\u{25A6}\u{25A7}\u{25A8}\u{25A9}\u{25AA}\u{25AB}\u{25AC}\u{25AD}\u{25AE}\u{25AF}"
      chars += "\u{25B0}\u{25B1}\u{25B2}\u{25B3}\u{25B4}\u{25B5}\u{25B6}\u{25B7}\u{25B8}\u{25B9}\u{25BA}\u{25BB}\u{25BC}\u{25BD}\u{25BE}\u{25BF}"
      chars += "\u{25C0}\u{25C1}\u{25C2}\u{25C3}\u{25C4}\u{25C5}\u{25C6}\u{25C7}\u{25C8}\u{25C9}\u{25CA}\u{25CB}\u{25CC}\u{25CD}\u{25CE}\u{25CF}"
      chars += "\u{25D0}\u{25D1}\u{25D2}\u{25D3}\u{25D4}\u{25D5}\u{25D6}\u{25D7}\u{25D8}\u{25D9}\u{25DA}\u{25DB}\u{25DC}\u{25DD}\u{25DE}\u{25DF}"
      chars += "\u{25E0}\u{25E1}\u{25E2}\u{25E3}\u{25E4}\u{25E5}\u{25E6}\u{25E7}\u{25E8}\u{25E9}\u{25EA}\u{25EB}\u{25EC}\u{25ED}\u{25EE}\u{25EF}"
      chars += "\u{25F0}\u{25F1}\u{25F2}\u{25F3}\u{25F4}\u{25F5}\u{25F6}\u{25F7}\u{25F8}\u{25F9}\u{25FA}\u{25FB}\u{25FC}\u{25FD}\u{25FE}\u{25FF}"

      chars += "\u{2600}\u{2601}\u{2602}\u{2603}\u{2604}\u{2605}\u{2606}\u{2607}\u{2608}\u{2609}\u{260A}\u{260B}\u{260C}\u{260D}\u{260E}\u{260F}"
      chars += "\u{2610}\u{2611}\u{2612}\u{2613}\u{2614}\u{2615}\u{2616}\u{2617}\u{2618}\u{2619}\u{261A}\u{261B}\u{261C}\u{261D}\u{261E}\u{261F}"
      chars += "\u{2620}\u{2621}\u{2622}\u{2623}\u{2624}\u{2625}\u{2626}\u{2627}\u{2628}\u{2629}\u{262A}\u{262B}\u{262C}\u{262D}\u{262E}\u{262F}"
      chars += "\u{2630}\u{2631}\u{2632}\u{2633}\u{2634}\u{2635}\u{2636}\u{2637}\u{2638}\u{2639}\u{263A}\u{263B}\u{263C}\u{263D}\u{263E}\u{263F}"
      chars += "\u{2640}\u{2641}\u{2642}\u{2643}\u{2644}\u{2645}\u{2646}\u{2647}\u{2648}\u{2649}\u{264A}\u{264B}\u{264C}\u{264D}\u{264E}\u{264F}"
      chars += "\u{2650}\u{2651}\u{2652}\u{2653}\u{2654}\u{2655}\u{2656}\u{2657}\u{2658}\u{2659}\u{265A}\u{265B}\u{265C}\u{265D}\u{265E}\u{265F}"
      chars += "\u{2660}\u{2661}\u{2662}\u{2663}\u{2664}\u{2665}\u{2666}\u{2667}\u{2668}\u{2669}\u{266A}\u{266B}\u{266C}\u{266D}\u{266E}\u{266F}"
      chars += "\u{2670}\u{2671}\u{2672}\u{2673}\u{2674}\u{2675}\u{2676}\u{2677}\u{2678}\u{2679}\u{267A}\u{267B}\u{267C}\u{267D}\u{267E}\u{267F}"
      chars += "\u{2680}\u{2681}\u{2682}\u{2683}\u{2684}\u{2685}\u{2686}\u{2687}\u{2688}\u{2689}\u{268A}\u{268B}\u{268C}\u{268D}\u{268E}\u{268F}"
      chars += "\u{2690}\u{2691}\u{2692}\u{2693}\u{2694}\u{2695}\u{2696}\u{2697}\u{2698}\u{2699}\u{269A}\u{269B}\u{269C}\u{269D}\u{269E}\u{269F}"
      chars += "\u{26A0}\u{26A1}\u{26A2}\u{26A3}\u{26A4}\u{26A5}\u{26A6}\u{26A7}\u{26A8}\u{26A9}\u{26AA}\u{26AB}\u{26AC}\u{26AD}\u{26AE}\u{26AF}"
      chars += "\u{26B0}\u{26B1}\u{26B2}\u{26B3}\u{26B4}\u{26B5}\u{26B6}\u{26B7}\u{26B8}\u{26B9}\u{26BA}\u{26BB}\u{26BC}\u{26BD}\u{26BE}\u{26BF}"
      chars += "\u{26C0}\u{26C1}\u{26C2}\u{26C3}\u{26C4}\u{26C5}\u{26C6}\u{26C7}\u{26C8}\u{26C9}\u{26CA}\u{26CB}\u{26CC}\u{26CD}\u{26CE}\u{26CF}"
      chars += "\u{26D0}\u{26D1}\u{26D2}\u{26D3}\u{26D4}\u{26D5}\u{26D6}\u{26D7}\u{26D8}\u{26D9}\u{26DA}\u{26DB}\u{26DC}\u{26DD}\u{26DE}\u{26DF}"
      chars += "\u{26E0}\u{26E1}\u{26E2}\u{26E3}\u{26E4}\u{26E5}\u{26E6}\u{26E7}\u{26E8}\u{26E9}\u{26EA}\u{26EB}\u{26EC}\u{26ED}\u{26EE}\u{26EF}"
      chars += "\u{26F0}\u{26F1}\u{26F2}\u{26F3}\u{26F4}\u{26F5}\u{26F6}\u{26F7}\u{26F8}\u{26F9}\u{26FA}\u{26FB}\u{26FC}\u{26FD}\u{26FE}\u{26FF}"

      chars += "\u{2700}\u{2701}\u{2702}\u{2703}\u{2704}\u{2705}\u{2706}\u{2707}\u{2708}\u{2709}\u{270A}\u{270B}\u{270C}\u{270D}\u{270E}\u{270F}"
      chars += "\u{2710}\u{2711}\u{2712}\u{2713}\u{2714}\u{2715}\u{2716}\u{2717}\u{2718}\u{2719}\u{271A}\u{271B}\u{271C}\u{271D}\u{271E}\u{271F}"
      chars += "\u{2720}\u{2721}\u{2722}\u{2723}\u{2724}\u{2725}\u{2726}\u{2727}\u{2728}\u{2729}\u{272A}\u{272B}\u{272C}\u{272D}\u{272E}\u{272F}"
      chars += "\u{2730}\u{2731}\u{2732}\u{2733}\u{2734}\u{2735}\u{2736}\u{2737}\u{2738}\u{2739}\u{273A}\u{273B}\u{273C}\u{273D}\u{273E}\u{273F}"
      chars += "\u{2740}\u{2741}\u{2742}\u{2743}\u{2744}\u{2745}\u{2746}\u{2747}\u{2748}\u{2749}\u{274A}\u{274B}\u{274C}\u{274D}\u{274E}\u{274F}"
      chars += "\u{2750}\u{2751}\u{2752}\u{2753}\u{2754}\u{2755}\u{2756}\u{2757}\u{2758}\u{2759}\u{275A}\u{275B}\u{275C}\u{275D}\u{275E}\u{275F}"
      chars += "\u{2760}\u{2761}\u{2762}\u{2763}\u{2764}\u{2765}\u{2766}\u{2767}\u{2768}\u{2769}\u{276A}\u{276B}\u{276C}\u{276D}\u{276E}\u{276F}"
      chars += "\u{2770}\u{2771}\u{2772}\u{2773}\u{2774}\u{2775}"
*/
      return chars
   }
   static func padRight(_ parser: Parser<String?>) -> Parser<String> {
      return orEmpty(parser.map { $0.map { s in "\(s) " } })
   }

   static func orEmpty(_ parser: Parser<String?>) -> Parser<String> {
      return parser.map { $0 ?? "" }
   }

   static func anyChar(from chars: String) -> Parser<String> {
      return Parser { s in
         
         guard let (head, rest) = s.uncons()
            , chars.contains(head) else {
            return []
         }
         return [(head, rest)]
      }
   }

   static let digit = Parsers.regex(pattern: "[0-9]")
   static let character = Parsers.regex(pattern: "[A-Za-z]")
   static let underscore = Parsers.token("_")
   static let questionMark = Parsers.token("?")
   static let bang = Parsers.token("!")
   static let atSign = Parsers.token("@")

   //Include leading whitespace
   static let colon = Parsers.token(":").token()
   static let comma = Parsers.token(",").token()
   static let period = Parsers.token(".").token()
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
   static let staticKeyword = Parsers.token("static").token()
   static let optionalInout = padRight(inoutKeyword.?)
   static let optionalEllipsis = orEmpty(ellipsis.?)
   static let semicolon = Parsers.token(";").token()
   static let newLine = (Parsers.token("\n") <|> Parsers.token("\r") <|> Parsers.token("\r\n")).token()
   static let statementSeparator = semicolon <|> newLine

   static let identifierChar = digit <|> identifierHead
   static let identifierHead = character <|> underscore
   static let baseIdentifier = curry { s, xs in s + xs.joined(separator: "") } <^> identifierHead <*> identifierChar.*
   static let identifier = baseIdentifier.token()

   static let rawAttribute = curry { name, args in (name: name, args: args) } <^> (atSign *> baseIdentifier).token() <*> orEmpty(Parsers.regex(pattern: "\\(.*\\)").token().?)
   static let attributeString = rawAttribute.map { "@\($0.name)\($0.args)" } 
   static let optionalAttributesString = rawAttribute.many().map { xs in xs.map {"@\($0.name)\($0.args)" }.joined(separator: " ") }.map { $0.isEmpty ? "" : $0 + " " }
   static let attribute = rawAttribute.map { Attribute(name: $0.name, argumentsClause: $0.args) } 

   static let accessModifiers = publicKeyword <|> privateKeyword <|> fileprivateKeyword <|> internalKeyword <|> openKeyword 
   static let typeAccessModifier = ((accessModifiers <|> Parser(pure: "internal")).token()).map { AccessModifier(rawValue: $0)! }

   static let typeName = identifier
   static let anyType = anyKeyword
   static let selfType = selfKeyword
   static let singleTupleType = (openParens *> type <* closeParens).map { "(\($0))" }
   static let arrayType = curry { _, t, _ in "[\(t)]" } <^> openSquare <*> type <*> closeSquare
   static let dictType = curry { _, k, _, v, _ in "[\(k):\(v)]" }
      <^> openSquare
      <*> type
      <*> colon
      <*> type
      <*> closeSquare

   static let optType = curry { t, xs in t + xs.joined(separator: "") } <^> (typeName <|> singleTupleType) <*> (questionMark <|> bang).+

   static let funcArgsNoParams = openParens *> Parser(pure: "()") <* closeParens
   static let labeledArg = curry { name, t in "\(name)\(t)" } <^> identifier <*> Parser(lazy: typeAnnotationClause)
   static let funcArg = typeAnnotation <|> labeledArg
   static let funcArgsList = funcArg.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let funcArgParams = curry { args, ellipsis in "\(args)\(ellipsis)" } <^> funcArgsList <*> optionalEllipsis
   static let funcArgsWithParams = (openParens *> funcArgParams <* closeParens).map { "(\($0))" }
   static let funcArguments = funcArgsNoParams <|> funcArgsWithParams
   static let optionalThrows = padRight((throwsKeyword <|> rethrowsKeyword).?)
   static let functionType = curry { attrs, args, thrws, _, t in "\(attrs)\(args)\(thrws) -> \(t)" }
      <^> optionalAttributesString
      <*> funcArguments
      <*> optionalThrows
      <*> arrowOperator
      <*> type

   static let tupleElementName = identifier
   static let tupleElement = (curry { name, t in "\(name)\(t)" } <^> tupleElementName <*> typeAnnotationClause) <|> type

   static let tupleElements = tupleElement.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let nonEmptyTuple = (openParens *> tupleElements <* closeParens).map { "(\($0))" }
   static let emptyTuple = (openParens *> Parser(pure: "()") <* closeParens)
   static let tupleType = (emptyTuple <|> nonEmptyTuple)

   static let protocolIdentifier = typeIdentifier
   static let protocolCompositionType = protocolIdentifier.separatedBy(ampersand).map { xs in xs.joined(separator: " & ") }

   static let type: Parser<String> = Parser(lazy: (
      Parser(lazy: functionType)
      <|> Parser(lazy: optType)
      <|> Parser(lazy: anyType)
      <|> Parser(lazy: selfType)
      <|> Parser(lazy: arrayType)
      <|> Parser(lazy: dictType)
      <|> Parser(lazy: singleTupleType)
      <|> Parser(lazy: tupleType)
      <|> Parser(lazy: protocolCompositionType)
      <|> Parser(lazy: typeIdentifierPart)
   ).token())

   static let typeAnnotation = curry { attrs, inOut, t in "\(attrs)\(inOut)\(t)" }
      <^> optionalAttributesString
      <*> optionalInout
      <*> type

   static let typeAnnotationClause = (curry { _, t in ": \(t)" } <^> colon <*> typeAnnotation.token()).token()

   static let genericArg = type
   static let genericArgumentsList = genericArg.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   static let genericArgumentsClause = (openAngle *> genericArgumentsList <* closeAngle).map { "<\($0)>" }
   static let typeIdentifierPart = (curry { name, genArgs in "\(name)\(genArgs)" } <^>  typeName <*> orEmpty(genericArgumentsClause.?)).token()

   static let typeIdentifier = Parser(lazy: typeIdentifierPart.separatedBy(period).map { $0.joined(separator: ".") })
   static let protocolList = typeIdentifier.separatedBy(some: comma).map { xs in xs.map { Inheritance.protocolRequirement($0) } }

   static let classInheritance = colon *> classKeyword.map { _ in [Inheritance.classRequirement] }
   static let protocolListInheritance = colon *> protocolList
   static let inheritanceList =  { xs in { xs + $0 } } <^> classInheritance <*> (comma *> protocolList)
      <|> classInheritance
      <|> protocolListInheritance 
      <|> Parser(pure: [])

//TODO: Continue tests here
   static let optionalModifier = optionalKeyword.map { _ in DeclarationModifier.isOptional }
   static let mutationModifier = mutationKeyword.map { _ in DeclarationModifier.isMutation }
   static let nonmutationModifier = nonmutationKeyword.map { _ in DeclarationModifier.isNonmutation }
   static let accessModifiersMapped: Parser<AccessModifier> = accessModifiers.map { AccessModifier(rawValue: $0)! } 
   static let memberAccessModifier = curry { (access: AccessModifier, setter: String?) in setter.map { _ in DeclarationModifier.setterAccess(access) } ?? .access(access) }
      <^> accessModifiersMapped
      <*> (openParens *> setKeyword <* closeParens).?

   static let staticModifier = staticKeyword.map { _ in DeclarationModifier.isStatic }

   static let propertyDeclarationModifiers = (optionalModifier <|> mutationModifier <|> nonmutationModifier <|> memberAccessModifier <|> staticModifier).many()
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
   static let methodAccessModifier = accessModifiersMapped.map { DeclarationModifier.access($0) }
   static let methodDeclarationModifiers = (optionalModifier <|> mutationModifier <|> nonmutationModifier <|> methodAccessModifier <|> staticModifier).many()
   static let functionHead: Parser<(attributes: [Attribute], modifiers: [DeclarationModifier])> = curry { attrs, mods, _ in (attributes: attrs, modifiers: mods) } <^> attribute.many() <*> methodDeclarationModifiers <*> funcKeyword
   static let operatorHead = anyChar(from: operatorHeadCharString())
   static let operatorChar = operatorHead //TODO: add unicode chars
   static let operatorName = (curry { head, rest in head + rest.joined(separator: "") } <^> operatorHead <*> operatorChar.many()).token()
   static let dotOperatorHead = Parsers.token(".")
   static let dotOperatorChar = dotOperatorHead <|> operatorChar
   static let dotOperatorName = (curry { head, rest in head + rest.joined(separator: "") } <^> dotOperatorHead <*> dotOperatorChar.many()).token()
   static let functionName = identifier <|> operatorName <|> dotOperatorName

  
   static let genericParameter = Parser(pure: "NOT IMPLEMENTED") 
   static let genericParameterList = genericParameter.separatedBy(some: comma).map { $0.joined(separator: ", ") }
   //TODO: CONTINUE HERE!
   static let genericParameterClause = openAngle *> genericParameterList <* closeAngle
   static let optionalGenericParameterClause = genericParameterClause.?
   static let functionSignature = Parser(pure: "NOT IMPLEMENTED")
   static let optionalGenericWhereClause = Parser(pure: "NOT IMPLEMENTED")

   static let methodMember: Parser<MethodMember> = curry { head, name, gens, sig, whr in MethodMember(attributes: head.attributes, modifiers: head.modifiers, name: name, genericsClause: gens, parameters: [], isThrows: false, isRethrows: false, returnType: nil, whereClause: nil) }
      <^> functionHead
      <*> functionName
      <*> optionalGenericParameterClause
      <*> functionSignature
      <*> optionalGenericWhereClause

   static let methodProtocolMember = methodMember.map { ProtocolMember.method($0) }

   //TODO:
   static let protocolMember: Parser<ProtocolMember> = propertyProtocolMember <|> methodProtocolMember
   static let protocolBlock: Parser<[ProtocolMember]> = openBlock *> protocolMember.separatedBy(some: statementSeparator) <* closeBlock

   static let protocolDeclaration = curry { attrs, optModifier, _, xs, members in ProtocolDeclaration(attributes: attrs, accessModifier: optModifier, inheritance: xs, members: members) }
      <^> attribute.many()
      <*> typeAccessModifier
      <*> protocolKeyword
      <*> inheritanceList
      <*> protocolBlock
}
