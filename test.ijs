Note 'display redefined primitives as op′'
"" allow for 'redefinition' of primitives; displayed as primitive′
" causing user defined primitives to look different to the built-in ones
" (see relational operators section for conceal without sprime)
" (technically can be used to define conceals of multiple characters)
"
" this then allows this:
"    match =: /:~@:{.@:[ -: /:~@:{.@:]
" to display as:
"    ≡′ ← ⇑∘↑∘⊣ ≡ ⇑∘↑∘⊢
"
" J code to generate the 'redefinitions':
" replace the string in f with the primitives you wish to generate
"
" replace ff in the output with primitive
" replace pp in the output with prime character (causes issues in J strings)
"
"p =: {{
"smoutput'syntax match j',y,' contained "',(}:y),'" conceal cchar=ff'
"smoutput'syntax match jprime contained "',({:y),'" conceal cchar=pp'
"smoutput'syntax match jOp "\<',y,'\>" contains=j',y,',jprime'
"smoutput''
"y
"}}
"
"]f =: ;: 'match'
"
"p each f

" example
"syntax match jmatch contained "matc" conceal cchar=≡
"syntax match jprime contained "h" conceal cchar=′
"syntax match jOp "\<match\>" contains=jmatch,jprime
)




vec #~ -. 2 | vec =: ?. 10 # 10				NB. 3rd version
(#~ -.@:(2&|)) ?. 10 # 10							NB. 4th version





NB. my own relational algebra library in J

Note 'some examples follow'
p =: torel 'pno,pname; p1,bolt; p2,nut'
'sno,sname' project s
'pno' =&'p1' select 'price' >&0.3 select sp
'city,CiTy;sname,SNAME' rename s
s cross p
)

load 'tables/csv'
filter =: {{ u # ] }}

NB. comma (val) and semicolon (row) to separate values
NB. WARNING: no 'nulls' in torel
torel =: {{~. makenum dltb each > ',' cutopen each ';' cutopen y}}
]s =: torel 'sno,sname,city; s1,magna,hull; s2,budd,ajax; s2,budd,ajax'
]t =: torel 'city,sname,sno; hull,magna,s2; ajax,budd,s2; ajax,budd,s1'
]p =: torel 'pno,pname; p1,bolt; p2,nut; p3,screw'
]sp =: torel 'sno,pno,price; s1,p1,0.5; s1,p2,0.25; s1,p3,0.3; s2,p3,0.4'
]sprime =: 0 2 1 { s
]sprime1 =: 0 2 1 {"(1) s

NB. project columns from relation
NB. WARNING: project expects names to exist and be correct
NB. */ $ result will give 0 when nothing matched
project =: {{ y {~"(1) I. +/ (',' cutopen x) =/ {."(2) y }}
'sno,sname' project s

NB. select rows from relation
select =: {{ y {~ 0 , 1 + I. , > *./ each u each}. x project y }}
'price' >&0.3 select sp
'pno' =&'p1' select 'price' >&0.3 select sp
'sno' 's1'&= select s
'sno' 's2'&= select s


NB. rename a column to a new name, x has form 'old0,new0;old1,new1;'
NB. length error before on idx due to extra generated dimension (use {.)
rename =: {{ )d
  ]n =: ';' cutopen x 
	]c =: y
	for_i. n do.
		newstr =: }. ',' cutopen > i
		idx =: {. I. ({. ',' cutopen > i) =/  {."(2) c
		f =: {{ ({. y) #~ x u i. # {. y }}
    c =: (}. c) ,~ (idx >f c) , newstr , idx <f c
  end.
}}
'city,CiTy;sname,SNAME' rename s


NB. doesn"t rename if names collide
cross =: {{
]sh =: ((#}.x) * #}.y) , 2 * (#{.y) >. #{.x
(({.x), {.y), a:&~: filter"(1) sh $ ,>(<"(1)}.x) ,"(0)/ <"(1)}.y
}}
s cross p
p cross s


eqcolnames =: /:~@:{.@:[ -: /:~@:{.@:] NB. union-compatible
(s cross p) eqcolnames p cross s
s eqcolnames sprime
s eqcolnames sprime1


eqrel =: {{
]ordxprime =: (/: {. x) {"(1) }. x [ ordx =:  (/: {. x) {  {. x
]ordyprime =: (/: {. y) {"(1) }. y [ ordy =:  (/: {. y) {  {. y
(ordx, /:~ ordxprime) *./@:,@:-: ordy, /:~ ordyprime
}}

s eqrel s
sprime1 eqrel sprime1 

s eqrel sprime
sprime eqrel sprime1

s eqrel 0 0 0 { s
s eqrel p
s eqrel sp


unionrel =: {{ 
assert. x eqcolnames y
~. x, }. y {"(1)~ , I. ({.x) =/ {.y
}}
s unionrel s
s unionrel sprime
s unionrel sprime1

s unionrel sp
s unionrel p

diffrel =: {{
assert. x eqcolnames y
b =: y [ a =: x
a =: a {~"(1) , I. ({.b) =/ {.a
b {~ I. b -.@:e. (}. a) {~ I. (}. a) e. }. b
}}
s diffrel t
t diffrel s

dir =: 'C:\Users\Hassan Shabbir\Desktop\'
writerel =: {{ y [ smoutput y writecsv dir,x  }}
readrel =: {{ readcsv dir,y }}
delrel =: {{ ferase dir,y,'.csv' }}
appendrel =: {{
assert. y eqcolnames readcsv dir,x 
x writerel y unionrel~ readrel x   NB. x unionrel y has cols of x
}}

]s =: 's' writerel s
readrel 's'
's' appendrel t
delrel 's'



NB. END RELATIONAL LIBRARY


steps =: {{
  assert. (2 -: #y) +. 3 -: #y 
  if. 2 -: #y do.
    'a b' =. y
    assert. a < b
    a + i. b - a - 1
  elseif. 3 -: #y do.
    'a b c' =. y
    assert. a < b
    assert. c > 0
    NB. lol, what do? :s
    a + ((b-a)%c) * i. (%(b-a)%c) * b - a - ((b-a)%c)
  end.
}}
steps 1 2 10

x =: a <: b
x =: a >: b
x =: a ~: b
x =: a * b
x =: a % b
x =: a e. b
x =: a e.~ b
x =: a +. b
x =: a *. b
x =: a +: b
x =: a *: b
x =: -.a
x =: a
x =. a
NB. this is a comment
x =: +/ a
x =. */ a
x =. F.. a
x =: i. 10
x =. >:i. 10
x =. i: 10
x =. 1 + $:
x =: define
  y * 2
:
  x * 2 
)

x =. x_1 + x_2
x =. 
x =: 10 [ 20
x =: 10 ] 20
x =: 10 F:: 20
x =: {{ x + y }}
x =: a.
x =. {{ throw. }}
x =. |. i. 10
x =: |: i. 10 10
x =: /: ? 10 # 10
x =: \: ? 10 # 10
x =: /:~ ? 10 # 10
x =: \:~ ? 10 # 10
x =. 10 {. i. 10
x =. 10 }. i. 100
x =. {. i. 10
x =. }. i. 100
x =: {: i. 100
x =. }: i. 100
x =: <. a
x =. >. a
x =: a <. b
x =. a >. b
x =. {{ assert.}} 
a =.'ji'

NB. Test of "normal" J code
load'viewmat'
rule =: 60
padb =: |. @ (8&{.) @ |. @ #:
match =: {&(padb rule) @ (#. @: -.)
next =: 3 match\ (0:, ], 0:, 0:)
init =: 1
viewmat (3 ({&(|.8{.|.#:60)@#.@:-.)\0:,],0:,0:)^:(i.200) 1
load'viewmat'
glider =: (3 3 $ (i.9)) e. 1 5 6 7 8
R =: 6 (|."1) 6 |. 9 9 {. glider
neighbors =: {{ +/ y |.~ >, { (_1 0 1); (_1 0 1) }}
next =: {{ (3&= +. (y&*.) @ (4&=)) neighbors y }}
viewmat next^:3 R
load'viewmat'
size =: 100
mandel =: {{(2 > | (y + _&[`*: @.(2&>@:|))^:(i.20) y) i. 0}}"0
plane =: (j.i.size) + (size, size) $ i.size
center =: (0.75 * size) j. (0.5 * size)
scale =: % 0.35 * size
viewmat mandel scale * plane - center
dna =: +/"1 @: ('ACGT'=/])
rna =: (] ` (]&'U') @. ('T'=]))"0
revc =: |. @ ('TCAG' {~ 'AGTC' i."1 ])
simulate =: 3 : 0
  shuffle =. {~ # ? #
	vitamins =. shuffle y $ 0 1
	take =. _4 ]\ vitamins
	percentages =. +/"1 take % 4
	(+/ % #) percentages
)
simulate 60  NB. => 0.5

a =: 1 2 3
b =: 4 5 6
{.@:[ 

1.04&*@:+
1.04&*@:+ / (|.x) , y

a =: 1e6 * 4 ^~ 1 + 0.10 % 4
a =: >./ a
a =: >./ a
3 %: 10
^@o. y
({.^:_)i. 2 3 4 5
{.@:{.@:{.@:{. i. 2 3 4 5
{.@:{.@:{.@:{. i. 2 3 4 5
y * 1 + 0 = 2 | y
(x * -.sv) + y * sv =. (#y) $ 1 0
+/ x * y ^ i. #: x
(i.~ (] - {) /:@/:) y
2 o.^:_ (0)
+`-`*`%`(+/)
isRight =: ([: *: {:) = ([: +/ [: *: }:)
>:^:_1 (5)
{.@:>@}. a
1&+&.> 4;5;6
(+/%#)&.:^. 1 2 4

b =: 0 0 0 0 0 0 0 0 0
p =: 'OX_' {~ 3 3 $ b
p =: 'X_' {~ 3 3 $ b + i
NB. Ammend } can be used to modify arrays

smoutput 'hi'
Alpha
beta
Beta
gamma
Gamma
delta
Deltax

+/(1 2 3)
+/

+/("1)
>./("1) 
+./("1) 
*./("1) 

+/a
+/("1)
#/("1)

<./("1)
>./("1)
<./
>./
+./
*./

[ 
[ 
[x
[.
[:

]m =: a. e. '0x123456789abcdefABCDEF'
]m =: m + a. e. '0x'
]m =: m + a. e. '0'

s =:   1 4 2 $ 0 0 0 0 0 0 1 1
s =: s , 4 2 $ 0 0 0 0 2 0 0 0
s =: s , 4 2 $ 0 0 3 0 0 0 3 0
s =: s , 4 2 $ 0 3 3 0 0 3 3 0

(0;s;m;0 _1 0 0) ;: 'qqq0x30x30x40x0xxxx'
(0;s;m;0 _1 0 0) ;: 'qqq0x30x30x40x0x34a'

0 (1 1)} 4 4 $ 5
< 1 1 
0 (< 1 1 2) } i. 2 3 4
smoutput 10

(x'') [ x =: {{ for. i. 10 do. smoutput 'hi' end. }}
(x'') [ x =: {{ for_i. i. 10 do. smoutput i + 1 end. }}

LoopWithInitial =: {{u&.>/\.&.(,&(<v))&.|.&.(<"_1)}}

*: deriv_jcalculus_ 1
! pderiv_jcalculus_ 1 (1)

load 'plot'
plot 3 1 4 1 5 9
plot (0.02 * i. 10); ^ 0.02 * i. 10
plot _15 15; 'sin' NB. Wow, this is cool!
plot 0 10; '^'
plot 0 10; 'sin`cos`tan'
plot 0 10; '+:`%:'
plot _10 10; '%'
plot 0.001 0.1; 'sin % y'
]f =: {{(cos r) % 1 + r =. x +&:*: y}}
plot _4 4 100 ; _4 4 100 ; 'f'
]z =: 0 10 20 + 1, x,: *: x [ y =: *: x =: i.5
'line' plot x; y; z
plot 0 2p1; 'sin`cos'
plot (; sin,:cos) steps 0 2p1 100

x =. y =. steps _4 4 100
f =. {{ (cos r) % 1 + r =. x +&:*: y }}
plot x ; y ; x f"0/ y


(* $:@<:) ^: (1&<) 4 NB. factorial
histogram =: ~. ,. #/.~
/:~ histogram 3 1 4 1 5 9 2 6 5 3 5 8 9 7 9 3 2 3 8 4 6 2 6 4 3 3 8 3 2 7 9 5 0 2 8 8 4 1 9 7 1 6 9 3 9 9 3 7 5 1 0 5 8 2 0 9 7 4 9 4 4 5 9 2 3 0 7 8 1 6 4 0 6 2 8 6 2 0 8 9 9 8 6 2 8 0 3 4 8 2 5 3 4 2 1 1 7 0 6 7 9 

enclose =: {.@:[ , ] , {:@:[ 
'*' enclose 'xyz'
'()' enclose 'abc'



NB. Heres your code Ahson

10 # 10          NB. 10 copies of 10
?. 10 # 10       NB. randomize each value; max value 9
vec =: ?. 10 # 10 NB. save to vector
vec              NB. show the vector

2 | vec          NB. the remainder of dividing by 2
-. 2 | vec        NB. the negation (1 -> 0, 0 -> 1)
pred =: -. 2 | vec NB. save to predicate vector
pred             NB. show the predicate vector

pred # vec       NB. copy the value if the predicate value is 1


NB. simplified, skip unnecessary lines and comments
vec =: ?. 10 # 10
pred =: -. 2 | vec
pred # vec


NB. one-liner
vec #~ -. 2 | vec =: ?. 10 # 10

ssteps

]s =: ;: 'abc aabc bcccc'
*./ 0= (#s) | #/.~ ,> s

a =: {{ smoutput 'hi' }}
a''

+/0$0

3 (+,-) 4

{.$i.3 4

x =: 3 1 4 1 5 9
'.#' {~ x >/ i.>./x

/:~;:'to be or not to be'

]a =: 10 ? 10
]b =: 10 ? 10
b { b
(#?#){~ a

<<<a:

+/\ x #~ (<&50) +/\ x =: 1 2.3 5.2 12.6 16.9 62.0

d =: 3 4 $ 0 75  0 53 0 0 67 67 93 51 83 0
$. 67 -~ 65 66 67 67 67 67 67 68 69

]R =: 2 3 $ 'Apple';'Paris';99;'Apple';'Quebec';50

0 1 2 3 4 !/ 0 1 2 3 4 

]d=: $.^:(_1) [ 2 + $. 3 4 $ 0 75 0 53 0 0 67 67 93 51 83 0

+table 1 2 3


{{assert. 4 = 2 + 2}}''
{{assert. 4 = 2 + 3}}''
assert 4 = 2 + 2
assert 4 = 2 + 3

x =: 10 2 1 0
0~:x#x
%+/% (#~0&~:) x =: 10 2 1 0
+/&.:% (#~0&~:) x =: 10 2 1 0 NB. Total resistance in parallel

1 0 1 # 1 2 3 

{{({.y)=y}} 1 2 3 4
*./{.@:= 1 2 3 4
*./{.@:= 1 1 1 1
(1=#)~. 1 1 1
1&>:@:# ~. 1 1 1
1&>:@:#@:~. 1 1 1
(/:-:\:) 1 2 3
(/:-:\:) 1 1 1

# $ a:

] T =: 'the cat' ; 'sat' ; < 'on' ; < 'the' ; 'mat'
T {::~ _1 
{:: T
(# S: 1) {:: T

]a =: > (steps 0 9 3) { 4 <\ 3 2 1 2 1 2 3 2 1 2 1 2 3
+/"(1)a
0 4}a


+/ -. ([ = /:~) 1 1 4 2 1 3

>2<\;:'we will we will rock you'
0 { ('we';'will')=/>2<\;:'we will we will rock you'

+/>(0=2|#)&.> cutopen '12 345 2 6 7896'

+/^:(_) 0 > 100 -~ ?. 10 10 $ 200
+/ , 0 > 100 -~ ?. 10 10 $ 200

i =: '(1+(2*3)+((8)/4)) + 1'
a =: '(' = i
b =: _1 * ')' = i
]o =: >./ +/\ +/ a ,: b

]i =: >./ +/"(1) 3 3 $ 1 2 3 5 5 5 3 1 4

1 2 3 */ 1 2 3 NB. ∘.* in APL is */ dyadically in J
1 2 3 =/ 1 2 3

-. 0 1
% 4 5 8 
% 4r1 5 8 

1|. i.5
2|. i.5

10 +each 1;2;3

+/"(1) (1 + i. 6)  =/ 1 + ? 1e6 $ 6

({{smoutput 'The origins of APL'}})^:(_)



NB.* Base system/locale functions

NB. File Operations
1!:0 '..\..\..\*' NB. Top-level
d =: 'C:\Users\Hassan Shabbir\Desktop\'
1!:0 d,'\*'
1!:1 <d,'Github.txt'
'write this' 1!:2 <d,'Github.txt'
', and this' 1!:3 <d,'Github.txt'

smoutput 'to screen output'
0 0 $ 1!:2&2 'to screen output'
0 0 $ 1!:2&4 'to stdout'
0 0 $ 1!:2&5 'to stderr'

1!:4 <d,'Github.txt' NB. File size
1!:5 <d,'JFolder' NB. Create folder

1!:43 '' NB. ls
1!:44 '.\bin' NB. cd ..
1!:55 <d,'JFolder' NB. rm


NB. Tree display
nub =: ] #~ i.@# = i.~
5!:4 <'nub'

NB. Time
6!:0 ''
6!:0 'YYYY-MM-DD hh:mm:ss'
6!:1 '' NB. seconds since start of session
6!:2 'a' [ a =: ? 50 50 $ 100 NB. seconds to execute

NB. Space
7!:0 '' NB. Space in use
7!:2 'a' [ a =: ? 50 50 $ 100 NB. space to execute

NB. Global Parameters
9!:3 (4) NB. set default as tree for verbs
+/%#
9!:11 (3) NB. set 3 point precision total
o. 1

NB. Tasks
fork_jtask_ 'notepad.exe'           NB. run notepad, no wait, no I/O
5000 fork_jtask_ 'notepad.exe'      NB. run notepad, wait 5 sec, no I/O
_1 fork_jtask_ 'notepad.exe'        NB. run notepad, until closed, no I/O

5000 fork_jtask_ 'cmd /k dir'  NB. show dir in cmd window for 5 sec and close
_1 fork_jtask_ 'cmd /k dir'    NB. show dir in cmd window until user closes it

launch jpath'~system'        NB. run default application, no wait

spawn_jtask_ 'net users'                    NB. get stdout from process
'+/i.3 4' spawn_jtask_ 'jconsole'           NB. call process with I/O

shell'echo.|time'                    NB. get result of shell command

(shell'dir /b')shell'find ".dll"'    NB. get all DDL names by piping

NB. stdlib functions continued
assert 0 <: 0
assert 0 <: 1

NB. box if open
boxopen 10
boxopen <10
boxopen 0 $ 0

NB. delimit boxes by x
cutopen 10;20;30
',' cutopen '10,20,30'

datatype 'hi'
datatype 1
datatype o. 1

NB. format data
1 list 10;20;30
6 list 10;20;30
9 list 10;20;30

Note '' NB. a value to the right is required
this is a long
comment that 
spans multiple
lines
)

({.;}.) 'abcde'
split 'abcde'
2 split 'abcde'

1 2 3 * table 10 11 12 13

timespacex '+/"(1) (1 + i. 6)  =/ 1 + ? 1e6 $ 6'
10 timespacex '+/"(1) (1 + i. 6)  =/ 1 + ? 1e6 $ 6'

timex '+/"(1) (1 + i. 6)  =/ 1 + ? 1e6 $ 6'
10 timex '+/"(1) (1 + i. 6)  =/ 1 + ? 1e6 $ 6'

10&+inv 10 
10&+inverse 10 


10&+each 10;20;30

EMPTY
empty 10


inf =: ^:(_)
+/inf ?. 10 10 $ 6
+/ +/ ?. 10 10 $ 6

sort 5 3 7

drop 10 20 30
take 10 20 30

tmoutput 'hi'

tolist 10;20;30

tolower 'HI EVERYONE'
toupper 'hi everyone'

'hi' = 'hey'
'hi' compare 'hey'
'hi' compare 'hi'

timestamp ''

calendar 2021 8

getdate '2021 8 3'
getdate 'Aug 3 2021'
getdate '3 Aug 2021'
getdate '3/8/21'
getdate 'aug 3, 21'
1 getdate '8/3/21' NB. months first

isotimestamp getdate '3 Aug 2021'

todate 0 1 2 3 + todayno 2021 8 3

dir ''
dirtree ''

', heyah!' fappend d,'Github.txt'
', heyah!' 1!:3 <d,'Github.txt'

ferase d,'Github.txt'

fexist d,'Github.txt'

fread d,'Github.txt'

freadblock (d,'Github.txt');17
freadblock 17;~d,'Github.txt'

freadr (d,'Github.txt');0 NB. seems to require a newline
freadr (d,'Github.txt');2 NB. cant access last line alone

(d,'github.txt') frename d,'Github.txt'
(d,'Github.txt') frename d,'github.txt'

'the great github file' freplace (d,'Github.txt');0 NB. overwrites

fsize d,'Github.txt'

'great' fss d,'Github.txt'

('great';'awesome') fssrplc d,'Github.txt'

ftype d,'Github.txt' NB. 0 does not exist, 1 file, 2 dir

fpathcreate 'C:\Users\Hassan Shabbir\Desktop\Hi' NB. create dir

fview d,'Github.txt'

fstamp d,'Github.txt'


'the github file' fwrite d,'Github.txt'

scripts ''

load 'numeric plot'

require 'numeric'

cut 'a b c' NB. cut on spaces (default)
',' cut 'a b c,d e f'

deb '   hi    ' NB. delete extra blanks

'foo ' delstring 'foo bar foo baz'

dlb '     hi' NB. delete leading blanks

dtb '     hi' NB. delete trailing blanks

< dltb '     hi    how are you     '

'x' dropafter 'foo x bar'

'x' dropto 'foo x bar'

',' joinstring 'a';'b';'c'
',' joinstring ;:'a b c'

'' joinstring 'a';'b';'c'

ljust '       hi'

rjust 'hi       '

'''' ({.@:[,],{.@:[) 'hi'
quote 'hi'

'foo' ss 'hey foo bar'

'foo' takeafter 'hey foo bar'

'foo' taketo 'hey foo bar'

cutpara 'one',LF,'two',LF2,'three',LF2,'four'

A =: 'In the very middle of the court was a table, with a large dish of tarts upon it.'
30 foldtext A

timespacex '? 1e6 $ 2'
timespacex '1e6 ?@$ 2'

prompt=: {{1!:1]1 [ ((2) 1!:2~ ]) y }}
prompt ''

name =: prompt 'Enter name: '
smoutput 'hello ',name

writetable =: {{ (toHOST, (": x),"1 LF) 1!:2 y }}
readtable =: {{ >0 ". each cutopen toJ 1!:1 y}}

(i. 5 5) writetable <d,'Github.txt'
]t =: readtable <d,'Github.txt'

 

rmchar =: {{ y #~ y e. a. {~ , 65 97 +/ i. 26 }}
p =: [: *./ ] = |.@:]
p =: [: *./ |.=]
p =: -:|. N                   B. wow, just two chars and that's it!
p =: (*./@:(|.=]))@:rmchar

p 'race car'
p 'a man a plan a canal panama'


pal s
pal p # s [ p =: (' '&=) s
p

apply =: {{
]a =: ' ' cutopen x
]b =: a:
for_i. a do. 
  if. i_index ~: <:#a do.
    b =: b, (<'[:'), i_index { a
  end.
end.

b =: ' ' joinstring b, {: a
". '(', b , ')' , y
}}
'%: +/ *:' apply '3 4'


{{
'a b c d' =: y
+./ (a*.b*.(-.c)),(a*.(-.b)*.d),((-.a)*.c*.(-.d))
}}"(1) ,"(2) #: ,.i. 16 

#:"(0) i. 16

#:"(0) i. 16

1 +. 0
1 *. 0
<i.0
'abc'


arrseg =: {{*./ +./"(1) ({.x) = {. > (-}.x) <\ y }}
arrsegt =: [:*./[:+./"(1) {.@[ = [:{.[:> -@}.@[ <\ ]
1 2 arrseg 1 2 1 3 4 1
1 2 arrsegt 1 2 1 3 4 1

a =: 2 3 $ 4 3 8 6 5 3
b =: 3 2 $ 5 4 9 6 4 2
a +/ .* b

t =: ?. 2 3 $ 5
+/t 
+/"(1) t 
+/"0 t 
+/"1 t 
+/"2 t 
+/"3 t 
+/"4 t 
+/"5 t 
+/"6 t 
+/"7 t 
+/"8 t 
+/"9 t 
+/rows t
+/items t

+/ *: 1 2 3
+/@*: 1 2 3
+/@:*: 1 2 3

0 *: 0
0 *: 1
1 *: 0
1 *: 1
x *:table x [ x =: 0 1 2
plot _10 10; '*:'

(],:*:) i. 10

x =: i. 2 2
x =: i. 2 2 2
x,x
x,.x
x,:x

dPP =: [: +/&.:*: - 
dPP 10 20

filter =: {{ u # ] }}
10&< filter 9 10 11 

load 'tables/csv'
] dat =: (34;'45';'hello';_5.34),: 12;'32';'goodbye';1.23
] dat1 =: _.;'';'hey';23.83

datatype each dat NB. show the types
makecsv dat NB. what gets written

dat writecsv d,'Github.txt' NB. write to the file
dat1 appendcsv d,'Github.txt'

] datcsv =: readcsv d,'Github.txt' NB. read into var


filter =: {{ u # ] }}
>&10 filter i. 15

(1&+^:(_1),1&+^:(1)) 10
conjunctionfandfprime =: {{ u ^:(n,~ -n) y }}
1&+ conjunctionfandfprime (1) 10 

adverbfunction =: {{ x u y }}
10 *adverbfunction 10

adverbtwice =: {{ u ^:2 y}}
1&+ adverbtwice 10

NB. why does this work?
1 2 3 + i. 3
1 2 3 + i. 3 3
1 2 3 + i. 3 3 3 

]A =: 3 4 $ 1 3 2 0 2 1 0 1 4 0 0 2
]B =: 4 2 $ 4 1 0 3 0 2 2 0
A < . = B
A +/ . = B
+/"(2) > A < . = B

A +/ . = B
A +/ . +/ . = B
A +/ . +/ . +/ . = B
A +/ . ~: B
A +/ . -:"(2) B
A +/ . >: B
A +/ . <: B
A +/ . -. B
A +/ . ~. B NB. domain error
A +/ . i. B
A +/ . i. B
A +/ . < B
A +/ . > B
A +/ . <. B
A +/ . >. B
A +/ . + B
A +/ . - B
A +/ . * B
A +/ . % B
A +/ . +. B
A +/ . *. B
A +/ . +: B NB. domain error
A +/ . *: B NB. domain error
A +./ . e. B


(+/@:]%+/) 1 3 5 7
(1*.],%) 1.375

sprime {.~ 2 -~ # sprime =: 3 }. s =: '09014KT'
sprime {.~ 2 -~ # sprime =: 3 }. s =: '09014KT'
100 %~ 100 100 #. 60 60 #: 194

a +/ .* b
a +/ . * b
xprime

p =: {{
smoutput'syntax match j',y,' contained "',(}:y),'" conceal cchar=ff'
smoutput'syntax match jprime contained "',({:y),'" conceal cchar=pp'
smoutput'syntax match jOp "\<',y,'\>" contains=j',y,',jprime'
smoutput''
y
}}
]f=: ;:'Note'
p each f



#: 21
#. 1 0 1 0 1


* 5 -~ i. 10



+/ (+/&.:*:) 1 ,: | -/ (}.,:}:) ? 20 # 8


]a =: +/\ <: 2 * ? 10000 # 2
plot a
plot 90 (+/%#)\ a

3&o. 1
toa
plot 0 10 ;'sin`cos`tan'


load 'stats/base'
(+/%#) binomialrand 0.314 100000

reverse =: -:|.
pi =: (+%)/\ 3 7 16 _294
allints =: -:<.
domainrange =: {{ y ,: u y }}
f =: #~ >&3 *. <&6


NB. el should be like the following:
NB. x : find element to insert into
NB. y : generate element using emmet-like syntax
el =: {{
'<',y,'></',y,'>'
:
'<',x,'>' , y , '</',x,'>'
}}

]a =: 'div' el 'p' el 'hey'
]b =: el 'div'
]c =: 'html' el ('head' el ''), 'body' el 'h1' el 'Hello World!'


]a =: ?. 10 # 10
]b =: ~. ?. 10 # 10
b i. a
]c =: 0 $~ # b
]c =: (>: c {~ 2) (2) } c
f =: {{ (u d {~ 2) (2) } c }}

(~. a) ,: a #/. a
3* 5+ i. 10


(+/`*/)@. 1

length =: [: %: [: +/ *:
to =: [ + [: i. [: >: -~
4 to 8

(+,-) 3
(-,+) 3

a =: 13 : '*: -: |. y' NB. create tacit from explicit


3 4 $ cut 'John M USA 26 Mary F UK 24 Monika F DE 31'
]r =: 4 4 $ cut 'Name Sex Country Age John M USA 26 Mary F UK 24 Monika F DE 31'



]r =: 6 4 $ cut 'John M USA 26 Mary F UK 24 Monika F DE 31'
invert =: [: <"(1) |:
vert =: [: |: >
<"(1)|:r
|:><"(1)|:r

r -: vert invert r



}: , |: 5 #"(0) 'Alex '



Note 'subscripts'
a_0 b_0 c_0
x0 y0 z0
a_0 b_0 c_0
x0 y0 z0
__ _ _1 _2 _3  non-subscripts
)

Note 'How to get a J console in NeoVim'
Integrated J console: 
ctrl-w v to open buffer in new window
ctrl-w w to switch to other window
:term to open a new terminal
j OR cd "C:\Program Files\J902\bin"; .\jconsole.exe
ctrl-\ ctrl-n to go to normal mode from terminal mode
yank into j register yypA
j with "jy
run with '@j'
to quit run exit''
)
