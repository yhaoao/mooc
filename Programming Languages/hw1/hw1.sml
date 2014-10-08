fun is_older ( x:int*int*int , y:int*int*int) =
	(#1 x)*10000+(#2 x)*100+(#3 x)<(#1 y)*10000+(#2 y)*100+(#3 y)

fun number_in_month(l :(int*int*int) list,n : int)=
	if null l
	then 0
	else 
		if #2 (hd l)=n
		then 1+number_in_month(tl l,n)
		else number_in_month(tl l,n)


fun number_in_months(l1 : (int*int*int) list,l2 : int list)=
	if null l2
	then 0
	else
		number_in_month(l1 , hd l2)+number_in_months(l1 , tl l2)

fun dates_in_month(l :(int*int*int) list,n : int)=
	if null l
	then []
	else
		if #2 (hd l)=n
		then hd l :: dates_in_month(tl l,n)
		else dates_in_month(tl l,n)

fun append (xs : (int*int*int) list, ys : (int*int*int) list) =
    if null xs
    then ys
    else hd(xs) :: append(tl(xs), ys)

fun dates_in_months(l1 : (int*int*int) list,l2 : int list)=
	if null l2
	then []
	else
		append(dates_in_month(l1,hd l2),dates_in_months(l1,tl l2))

fun get_nth(l : 'a list,n : int)=
	if n=1
	then hd l
	else get_nth(tl l,n-1)

fun date_to_string( x:int*int*int)=
	let
		val months = ["January", "February", "March", "April", "May", "June", 
		"July", "August", "September", "October", "November", "December"]
	in
		get_nth(months,#2 x) ^ " " ^ Int.toString(#3 x) ^ ", " ^ Int.toString(#1 x)
	end

fun number_before_reaching_sum(sum : int , l : int list)=
	if sum <= hd l
	then 0
	else 1 + number_before_reaching_sum(sum - (hd l) , tl l)

fun what_month(i : int)=
	1+number_before_reaching_sum(i , [31,28,31,30,31,30,31,31,30,31,30,31])

fun month_range(x : int , y : int)=
	if x>y
	then []
	else what_month(x)::month_range(x+1,y)

fun oldest(l : (int*int*int) list)=
	if null l
	then NONE
	else 
		let val tl_ans = oldest(tl l)
		in if isSome tl_ans andalso  is_older(valOf tl_ans , hd l)
			then tl_ans
			else SOME (hd l)
		end



































