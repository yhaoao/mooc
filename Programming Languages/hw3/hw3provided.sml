(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)



val only_capitals =List.filter (fn x => Char.isUpper(String.sub(x,0)))


val  longest_string1=foldl (fn (x,y)=>if String.size x>String.size y then x else y) ""

val  longest_string2=foldl (fn (x,y)=>if String.size x>=String.size y then x else y) ""

fun longest_string_helper cond =foldl (fn (x,y)=>if cond(String.size x,String.size y) then x else y) ""

val longest_string3 =longest_string_helper (fn(x,y)=>x>y)

val longest_string4 =longest_string_helper (fn(x,y)=>x>=y)

val longest_capitalized =longest_string1  o only_capitals

val rev_string=String.implode o List.rev o String.explode

val f=String.tokens (fn x =>true);

fun first_answer f xs=
	case xs of
		  []      =>raise NoAnswer
		| x::xs'  =>case f(x) of
			     	  SOME x =>x
			     	| NONE   =>first_answer f xs'

fun all_answers f xs = let
    fun app (SOME x) (SOME l) = SOME (l @ x)
      | app _ _ = NONE
  	in
    	foldl (fn (x,r) => app (f x) r) (SOME []) xs
  	end

fun g f1 f2 p =
    let
      val r = g f1 f2
    in
      case p
        of Wildcard          => f1 ()
         | Variable x        => f2 x
         | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
         | ConstructorP(_,p) => r p
         | _                 => 0
    end
 
val count_wildcards = g (fn _ => 1) (fn _ => 0)
val count_wild_and_variable_lengths = g (fn _ => 1) String.size
 
fun count_some_var (s: string, p: pattern) =
  g (fn _ => 0) (fn x => if x = s then 1 else 0) p
 
fun check_pat (p: pattern) = let
    fun concat [] = []
      | concat (x::xs) = x @ concat xs
    fun concat_map f l = concat (map f l)
    fun strings (Variable v) = [v]
      | strings (TupleP ps) = concat_map strings ps
      | strings (ConstructorP (_,p)) = strings p
      | strings _ = []
    fun non_duplicated [] = true
      | non_duplicated (x::xs) =
          (List.all (fn x => x) (map (fn y => x <> y) xs)) andalso (non_duplicated xs)
  in
    non_duplicated (strings p)
  end
 
fun match (v: valu, p: pattern): (string * valu) list option = case p
  of Wildcard => SOME []
   | Variable var => SOME [(var, v)]
   | UnitP => if v = Unit then SOME [] else NONE
   | ConstP i => if v = Const i then SOME [] else NONE
   | TupleP ps =>
       ( case v
           of Tuple vs => all_answers match (ListPair.zip (vs,ps))
            | _ => NONE
       )
   | ConstructorP (s,p') =>
       ( case v
           of Constructor (s',v') => if (s = s') then match (v', p') else NONE
            | _ => NONE
       )
 
fun first_match v ps =
  SOME (first_answer (fn p => match (v,p)) ps)
  handle NoAnswer => NONE















