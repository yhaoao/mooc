low =balance/12
high=((balance * (1 + annualInterestRate/12))**12) / 12.0

def payOff(paid,balance):
	for i in range(1,13):
		balance=(balance-paid)*(annualInterestRate/12+1)

	if(balance<0 and balance>-1):
		return 0
	elif balance>0:
		return -1
	else:
		return 1


paid=(high+low)/2
result=payOff(paid,balance)
while result!=0:
	if(result>0):
		high=paid
	else:
		low=paid
	paid=(high+low)/2
	result=payOff(paid,balance)

print round(paid,2)
