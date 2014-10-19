(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun is_in(s,lst)=
	case lst of
		  []	 =>false
		| x::xs' =>if same_string(s,x) then true else is_in(s,xs')

fun append (xs,ys) =
    case xs of
		  []     => ys
		| x::xs' =>x::append(xs',ys)

fun all_except_option(s,xs)=
	let fun except(s,lst,acc)=
			case lst of
				  []     =>acc
				| x::xs' =>if same_string(s,x) then except(s,xs',acc) else except(s,xs',x::acc)
		
	in
		if is_in(s,xs)
		then SOME(except(s,xs,[]))
		else NONE
	end

fun get_substitutions1(xs,s)=
	case xs of
		  []        =>[]
		| lst::xs'  =>case all_except_option(s,lst) of
							NONE       =>get_substitutions1(xs',s)
						  |	SOME(lst') =>append(lst',get_substitutions1(xs',s))

fun get_substitutions2(xs,s)=
	let fun aux(xs,s,acc)=
		case xs of
			  []        =>acc
			| lst::xs'  =>case all_except_option(s,lst) of
								NONE       =>aux(xs',s,acc)
							  |	SOME(lst') =>aux(xs',s,lst'@acc)
	in
		aux(xs,s,[])
	end

fun similar_names(xs:string list list,name:{first:string,middle:string,last:string})=
	let fun aux(xs:string list,middle:string,last:string,acc:{first:string,middle:string,last:string} list)=
		case xs of
			  []     =>acc
			| s::xs' =>aux(xs',middle,last,{first=s,middle=middle,last=last}::acc)
	in
		case name of
			{first=x,middle=y,last=z} =>name::aux(get_substitutions2(xs,x),y,z,[])
	end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)


fun card_color(su,ra)=
	case su of
		  Clubs    =>Black
		| Spades   =>Black
		| Diamonds =>Red
		| Hearts   =>Red

fun card_value(su,ra)=
	case ra of
		  Num(n) => n
		| Ace    => 11
		| _      => 10

fun remove_card(cs,c,e)=
	let fun is_in(cs,c)=
		case cs of
			  []      =>false
			| c'::cs' =>if c'=c then true else is_in(cs',c)

		fun remove(cs,c,acc)=
			case cs of
				  []    =>acc
				| c'::cs' =>if c'=c then cs' @ acc else remove(cs',c,c'::acc) 
	in
		if is_in(cs,c)
		then remove(cs,c,[])
		else raise e
	end

fun all_same_color(xs)=
	case xs of
		  [] =>true
		| _::[] =>true
		| x::(y::xs') =>card_color(x)=card_color(y) andalso  all_same_color(y::xs')

fun sum_cards(xs)=
	let fun aux(xs,acc)=
		case xs of
			  [] =>acc
			| x::xs' =>aux(xs',card_value(x)+acc)
	in
		aux(xs,0)
	end

fun score(xs,x)=
	let val sum=sum_cards(xs)
		val prescore=if(sum>x) then (sum-x)*3 else x-sum
	in
		if all_same_color(xs) then prescore div 2 else prescore
	end

fun officiate(cs,ms,goal) =
	let fun aux(cs,ms,goal,acc)=
		case ms of
			  []   =>acc
			| m::ms' =>case m of
						  Discard(cd) =>aux(cs,ms',goal,remove_card(acc,cd,IllegalMove))
						| Draw        =>case cs of
											  [] => acc
											| c'::cs' =>if sum_cards(c'::acc)>goal then c'::acc else aux(cs',ms',goal,c'::acc)
	in
		score(aux(cs,ms,goal,[]),goal)
	end














