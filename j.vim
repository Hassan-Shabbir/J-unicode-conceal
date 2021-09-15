" Conceal J symbols to look like math/APL
"
" Comments have unicode characters that might be used instead
"
" see the following links for extra characters:
" https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode
" http://shapecatcher.com/index.html
" https://unicode-table.com/en/sets/arrow-symbols/
" https://unicode-table.com/en/blocks/mathematical-operators/
" https://unicode-table.com/en/blocks/miscellaneous-technical/
"
" concealing can be removed in comments using quotes
"
" generally, horizontal lines in concealed characters means:
" reversed, inverse, negated, uncommon, inner (rank)
" see the following examples: ⤉ ¯ ⊼ ⍛ ⍊ ⍪


"" remove highlighting which occurs when concealing
hi clear conceal



"" J shorthands for modifiers
"syntax match jOp "\." conceal cchar=∙ " used for dot product
syntax match jOp "\.\." conceal cchar=‥
syntax match jOp "\.:" conceal cchar=⠪
syntax match jOp ":\." conceal cchar=⠕
syntax match jOp "::" conceal cchar=∷ "⁞ ⦙ ⠛ ⠶


"" APL inspired (may be different)
syntax match jOp "\$:" conceal cchar=∇
syntax match jOp "NB\." conceal cchar=⍝
syntax match jOp "\<Note\>" conceal cchar=⍝ " multiline comment (distinguished by y num/str)

syntax match jOp "=\." conceal cchar=← "≝ ⇽ 🠐 🠔
syntax match jOp "=:" conceal cchar=⇽
syntax match jOp "-:" conceal cchar=≡ "∹

" iota
syntax match jOp "i\." conceal cchar=ι
syntax match jOp ">:i\." conceal cchar=ί " iota 1-indexed does not work?
syntax match jOp "i:" conceal cchar=ϊ " ι 𝜾 𝜄⍸ ⍳
syntax match jOp "\<steps\>" conceal cchar=ῑ

" tally
"syntax match jOp "#" conceal cchar=𝍸

" empty vector (different properties when summed)
syntax match jOp "0$0" conceal cchar=⍬ " ∅
syntax match jOp "0 $ 0" conceal cchar=⍬ " ∅
syntax match jOp "a:" conceal cchar=⍬ " ∅
syntax match jOp "\<EMPTY\>" conceal cchar=⍬ " ∅
syntax match jOp "\<empty\>" conceal cchar=⍬ " ∅

" tacks (left and right identity)
syntax match jOp "\[[^:]"me=e-1 conceal cchar=⊣ " ⋄ ⬥ ⬦ ↤
syntax match jOp "\]" conceal cchar=⊢

" reverse and transpose
syntax match jOp "|\." conceal cchar=ꝋ "⌽
syntax match jOp "|:" conceal cchar=⍉ "ᴓ

" grade and sort
syntax match jOp "/:" conceal cchar=⍋
syntax match jOp "\\:" conceal cchar=⍒
syntax match jOp "/:\~" conceal cchar=⇑
syntax match jOp "\<sort\>" conceal cchar=⇑
syntax match jOp "\\:\~" conceal cchar=⇓

" take, drop, take-from-last, drop-from-last
syntax match jOp "{\." conceal cchar=↑
syntax match jOp "}\." conceal cchar=↓
syntax match jOp "\<take\>" conceal cchar=↑
syntax match jOp "\<drop\>" conceal cchar=↓
syntax match jOp "{:[^:]"me=e-1 conceal cchar=⤉
syntax match jOp "}:" conceal cchar=⤈

" base (reversed from apl since 'to' should be up, according to me)
syntax match jOp "#\." conceal cchar=⊤ "⟙ ⏊
syntax match jOp "#:" conceal cchar=⊥

" lesser, greater
syntax match jOp "<\." conceal cchar=⌊
syntax match jOp ">\." conceal cchar=⌈


"" diaeresis for rank operations
syntax match jOp "\"" conceal cchar=¨
syntax match jOp " &\.>" conceal cchar=¨ "hide preceding space
syntax match jOp "&\.>" conceal cchar=¨
syntax match jOp " \<each\>" conceal cchar=¨ "hide preceding space
syntax match jOp "\<each\>" conceal cchar=¨


"" separator symbols for definitions
syntax match jOp "^)$" conceal cchar=∎ " ∇  does not work with monad define
syntax match jOp "^:$" conceal cchar=⬥ " ⋄ ⬦ §


"" basic algebra operators
syntax match jOp "\*" conceal cchar=×
syntax match jOp "\<sign\>" conceal cchar=×
syntax match jOp "%" conceal cchar=÷
syntax match jOp "%:" conceal cchar=√ "⎷

"" inequalities
syntax match jOp "<:" conceal cchar=≤
syntax match jOp ">:" conceal cchar=≥
syntax match jOp "\~:" conceal cchar=≠ "≢


"" logic symbols
syntax match jOp "-\." conceal cchar=¬
syntax match jOp "+\." conceal cchar=∨
syntax match jOp "\*\." conceal cchar=∧
syntax match jOp "+:" conceal cchar=⊽ "⍱
syntax match jOp "*:" conceal cchar=⊼ "⍲
syntax match jOp "e\." conceal cchar=∈
syntax match jOp "-\.@:e\." conceal cchar=∉
syntax match jOp "e\.\~" conceal cchar=∋


"" double-struck reduction shorthands
syntax match jOp "+/" conceal cchar=⅀
syntax match jOp "*/" conceal cchar=ℿ
syntax match jOp "<\./" conceal cchar=𝕃
syntax match jOp ">\./" conceal cchar=ℾ
syntax match jOp "+\./" conceal cchar=⩔
syntax match jOp "*\./" conceal cchar=⩓
syntax match jOp "+/ . \?\*" conceal cchar=⸱ " optional space after dot


"" function modifiers repeat and undo
syntax match jOp "\^:(_)" conceal cchar=∞
syntax match jOp "\<inf\>" conceal cchar=∞
"syntax match jOp "\<inv\>" conceal cchar=¯ " overridden by rank infinity
"syntax match jOp "\<inverse\>" conceal cchar=¯

" rank operations (subscripts left for when I can get x_0 to conceal properly)
syntax match jOp '"(0)' conceal cchar=⁰ "₀
syntax match jOp '"(1)' conceal cchar=¹ "₁
syntax match jOp '"(2)' conceal cchar=² "₂
syntax match jOp '"(3)' conceal cchar=³ "₃
syntax match jOp '"(4)' conceal cchar=⁴ "₄
syntax match jOp '"(5)' conceal cchar=⁵ "₅
syntax match jOp '"(6)' conceal cchar=⁶ "₆
syntax match jOp '"(7)' conceal cchar=⁷ "₇
syntax match jOp '"(8)' conceal cchar=⁸ "₈
syntax match jOp '"(9)' conceal cchar=⁹ "₉
syntax match jOp '"(_)' conceal cchar=¯

syntax match jOp '("0)' conceal cchar=⁰ "₀
syntax match jOp '("1)' conceal cchar=¹ "₁
syntax match jOp '("2)' conceal cchar=² "₂
syntax match jOp '("3)' conceal cchar=³ "₃
syntax match jOp '("4)' conceal cchar=⁴ "₄
syntax match jOp '("5)' conceal cchar=⁵ "₅
syntax match jOp '("6)' conceal cchar=⁶ "₆
syntax match jOp '("7)' conceal cchar=⁷ "₇
syntax match jOp '("8)' conceal cchar=⁸ "₈
syntax match jOp '("9)' conceal cchar=⁹ "₉
syntax match jOp '("_)' conceal cchar=¯

syntax match jOp '"0 [^_0-9]'me=s+2 conceal cchar=⁰
syntax match jOp '"1 [^_0-9]'me=s+2 conceal cchar=¹
syntax match jOp '"2 [^_0-9]'me=s+2 conceal cchar=²
syntax match jOp '"3 [^_0-9]'me=s+2 conceal cchar=³
syntax match jOp '"4 [^_0-9]'me=s+2 conceal cchar=⁴
syntax match jOp '"5 [^_0-9]'me=s+2 conceal cchar=⁵
syntax match jOp '"6 [^_0-9]'me=s+2 conceal cchar=⁶
syntax match jOp '"7 [^_0-9]'me=s+2 conceal cchar=⁷
syntax match jOp '"8 [^_0-9]'me=s+2 conceal cchar=⁸
syntax match jOp '"9 [^_0-9]'me=s+2 conceal cchar=⁹


" circle functions
syntax match jOp "o\." conceal cchar=○
syntax match jOp "\v1[ &]o\." conceal cchar=①
syntax match jOp "\v2[ &]o\." conceal cchar=②
syntax match jOp "\v3[ &]o\." conceal cchar=③
syntax match jOp "\v4[ &]o\." conceal cchar=④
syntax match jOp "\v5[ &]o\." conceal cchar=⑤
syntax match jOp "\v6[ &]o\." conceal cchar=⑥
syntax match jOp "\v7[ &]o\." conceal cchar=⑦
syntax match jOp "\v8[ &]o\." conceal cchar=⑧
syntax match jOp "\v9[ &]o\." conceal cchar=⑨
syntax match jOp "\v10[ &]o\." conceal cchar=⑩
syntax match jOp "\v11[ &]o\." conceal cchar=⑪
syntax match jOp "\v12[ &]o\." conceal cchar=⑫

syntax match jOp "\v_1[ &]o\." conceal cchar=❶
syntax match jOp "\v_2[ &]o\." conceal cchar=❷
syntax match jOp "\v_3[ &]o\." conceal cchar=❸
syntax match jOp "\v_4[ &]o\." conceal cchar=❹
syntax match jOp "\v_5[ &]o\." conceal cchar=❺
syntax match jOp "\v_6[ &]o\." conceal cchar=❻
syntax match jOp "\v_7[ &]o\." conceal cchar=❼
syntax match jOp "\v_8[ &]o\." conceal cchar=❽
syntax match jOp "\v_9[ &]o\." conceal cchar=❾
syntax match jOp "\v_10[ &]o\." conceal cchar=❿
syntax match jOp "\v_11[ &]o\." conceal cchar=⓫
syntax match jOp "\v_12[ &]o\." conceal cchar=⓬


"" lambda (direct definition) syntax
syntax match jOp "{{" conceal cchar=⦃ "⟨❴⋋
syntax match jOp "}}" conceal cchar=⦄ "⟩❵⋌


"" control operators
syntax match jOp "\<assert\>" conceal cchar=❔ "❓ ‼
syntax match jOp "assert\." conceal cchar=❔ "❓ ‼
syntax match jOp "[^a-zA-Z]throw\.[^a-zA-Z]" conceal cchar=❗ " ❕ ‼


"" composition operators ∘⨀⍎↥⍕⦁⦾⦿⏂ ⊝⊖○⇴⟴⊕↚⬰⦗⧫⦂¦⫶⧁
syntax match jOp "@[^\.]"me=e-1 conceal cchar=⍛ " compose with inside app (uncommon, has dash/minus)
syntax match jOp "@:" conceal cchar=∘ " normal composition
syntax match jOp "\<on\>" conceal cchar=∘
syntax match jOp "\[:" conceal cchar=⋄ " statement separator (compose later) (caps fork)
syntax match jOp "&\.[^>]"me=e-1 conceal cchar=⍑ " base for function applied inside (uncommon)
syntax match jOp "&\.:" conceal cchar=⍊ " base applied on whole (normal)


"" concatenation operators
syntax match jOp ",\." conceal cchar=⍪
syntax match jOp ",:" conceal cchar=⸴


"" reduction (having +/"(1) conceal to +⌿ conflicts with +/ concealing to ⅀)
syntax match jOp "/\." conceal cchar=⌿
syntax match jOp "\\\." conceal cchar=⍀



"" calculus; load 'math/calculus' first
"syntax match jOp "deriv_jcalculus_" conceal cchar=𝓭
"syntax match jOp "pderiv_jcalculus_" conceal cchar=𝒹
"syntax match jOp "sslope_jcalculus_" conceal cchar=𝓈 " 𝓼


"" file system related functions (also includes csv) ⍐⍗⏍⍯⌸⍞𐌇◻
" box denotes file

" show files
syntax match jOp "1!:0[^0-9]"me=e-1 conceal cchar=⎕

" exists
syntax match jOp "\<fexist\>" conceal cchar=⍰

" read
syntax match jOp "1!:1[^0-9]"me=e-1 conceal cchar=⍇
syntax match jOp "\<fread\>" conceal cchar=⍇
syntax match jOp "\<freadblock\>" conceal cchar=⍇
syntax match jOp "\<freadr\>" conceal cchar=⍇
syntax match jOp "\<readcsv\>" conceal cchar=⍇

" (over)write
syntax match jOp "1!:2[^0-9]"me=e-1 conceal cchar=⍈
syntax match jOp "\<fwrite\>" conceal cchar=⍈
syntax match jOp "\<writecsv\>" conceal cchar=⍈

" append (like comma)
syntax match jOp "1!:3[^0-9]"me=e-1 conceal cchar=⍞
syntax match jOp "\<fappend\>" conceal cchar=⍞
syntax match jOp "\<appendcsv\>" conceal cchar=⍞

" open
syntax match jOp "1!:21[^0-9]"me=e-1 conceal cchar=⍐

" close
syntax match jOp "1!:22[^0-9]"me=e-1 conceal cchar=⍗

" delete 
syntax match jOp "1!:55[^0-9]"me=e-1 conceal cchar=⊟ " 𐌇 ⍗
syntax match jOp "\<ferase\>" conceal cchar=⊟ " 𐌇 ⍗


"" print
syntax match jOp "\<smoutput\>"     conceal cchar=→
syntax match jOp "0 0 $ 1!:2&2" conceal cchar=→ " smoutput
syntax match jOp "0 0 $ 1!:2&4" conceal cchar=→ " stdout
syntax match jOp "0 0 $ 1!:2&5" conceal cchar=→ " stderr
syntax match jOp "0 0 $ 1!:2&2" conceal cchar=→ " smoutput
syntax match jOp "\<stdout\>" conceal cchar=→
syntax match jOp "\<tmoutput\>" conceal cchar=→
syntax match jOp "\<stderr\>" conceal cchar=→


"" character functions
syntax match jOp "a\." conceal cchar=⍺


"" functions ⍂⧅⎅⧄⍁
syntax match jOp "\<boxx\?open\>" conceal cchar=◫
syntax match jOp "\<cutopen\>" conceal cchar=◫


"" primes (only works as prefix; ie. primex → ′x)
" could be an issue with my personal setup
syntax match jOp "prime" conceal cchar=′
syntax match jOp "prime0" conceal cchar=′
syntax match jOp "prime1" conceal cchar=″
syntax match jOp "prime2" conceal cchar=‴
"syntax match jOp "prime3" conceal cchar=⁗


"" Greek letters; be aware of multiple uses (Gamma for ceiling, etc.)
syntax match jOp "Alpha" conceal cchar=Α
syntax match jOp "Beta" conceal cchar=Β
syntax match jOp "Gamma" conceal cchar=Γ
syntax match jOp "Delta" conceal cchar=Δ
syntax match jOp "Epsilon" conceal cchar=Ε
syntax match jOp "Zeta" conceal cchar=Ζ
syntax match jOp "Eta" conceal cchar=Η
syntax match jOp "Theta" conceal cchar=Θ
syntax match jOp "Iota" conceal cchar=Ι
syntax match jOp "Kappa" conceal cchar=Κ
syntax match jOp "Lambda" conceal cchar=Λ
syntax match jOp "Mu" conceal cchar=Μ
syntax match jOp "Nu" conceal cchar=Ν
syntax match jOp "Xi" conceal cchar=Ξ
syntax match jOp "Omicron" conceal cchar=Ο
syntax match jOp "Pi" conceal cchar=Π
syntax match jOp "Rho" conceal cchar=Ρ
syntax match jOp "Sigma" conceal cchar=Σ
syntax match jOp "Tau" conceal cchar=Τ
syntax match jOp "Upsilon" conceal cchar=Υ
syntax match jOp "Phi" conceal cchar=Φ
syntax match jOp "Chi" conceal cchar=Χ
syntax match jOp "Psi" conceal cchar=Ψ
syntax match jOp "Omega" conceal cchar=Ω

syntax match jOp "alpha" conceal cchar=α
syntax match jOp "beta" conceal cchar=β 
syntax match jOp "gamma" conceal cchar=γ
syntax match jOp "delta" conceal cchar=δ
syntax match jOp "epsilon" conceal cchar=ε
syntax match jOp "zeta" conceal cchar=ζ
syntax match jOp "eta" conceal cchar=η
syntax match jOp "theta" conceal cchar=θ
syntax match jOp "iota" conceal cchar=ι
syntax match jOp "kappa" conceal cchar=κ
syntax match jOp "lambda" conceal cchar=λ
syntax match jOp "mu" conceal cchar=μ
syntax match jOp "nu" conceal cchar=ν
syntax match jOp "xi" conceal cchar=ξ
syntax match jOp "omicron" conceal cchar=ο
syntax match jOp "pi" conceal cchar=π
syntax match jOp "rho" conceal cchar=ρ
syntax match jOp "sigma" conceal cchar=σ
syntax match jOp "tau" conceal cchar=τ
syntax match jOp "upsilon" conceal cchar=υ
syntax match jOp "phi" conceal cchar=ϕ
syntax match jOp "chi" conceal cchar=χ
syntax match jOp "psi" conceal cchar=ψ
syntax match jOp "omega" conceal cchar=ω
syntax match jOp "nabla" conceal cchar=∇


"" relational operators (example for user-written code)
syntax match jOp "\<rename\>" conceal cchar=ρ
syntax match jOp "\<select\>" conceal cchar=σ
syntax match jOp "\<project\>" conceal cchar=∏
syntax match jOp "\<cross\>" conceal cchar=×
syntax match jOp "\<join\>" conceal cchar=⋈
syntax match jVerb "\<eqrel\>" conceal cchar=≡
syntax match jVerb "\<eqcolnames\>" conceal cchar=≋
syntax match jVerb "\<unionrel\>" conceal cchar=∪
syntax match jVerb "\<diffrel\>" conceal cchar=∖
syntax match jVerb "\<interel\>" conceal cchar=⋂
syntax match jVerb "\<symrel\>" conceal cchar=△
syntax match jOp "\<writerel\>" conceal cchar=⍈
syntax match jOp "\<readrel\>" conceal cchar=⍇
syntax match jOp "\<delrel\>" conceal cchar=⊟
syntax match jOp "\<appendrel\>" conceal cchar=⍞






"" =============================
"" leftover things not completed
"" =============================
"syntax match jOp '\v<[[:alpha:]_]+0>'ms=e conceal cchar=₀
"
" not generalizeable due to first rank being reversed, ie.
" horizontal with vector, vertical with matrix, etc.
"syntax match jOp "|\." conceal cchar=⊖
"
"syntax match jOp "/(\"1)" conceal cchar=⌿ "can't get this to take first precedence
"
"syntax match jOp "[A-Za-z]prime"ms=s+1 conceal cchar=⍴ ms=s+1 doesn't work?
" 
" add directory commands (4,5,11,12,43,44,46,55)
"
"" remove duplicated quotes ('') (which are used to escape a literal quote)
" can't because it is inside a string?
"syntax match jOp "\'\'" conceal cchar=′ "`՚ʹ´'
"
"" remove locales (does not work yet)
"syntax match jOp "_z_" conceal cchar=′
"syntax match jOp "_base_" conceal cchar=′
