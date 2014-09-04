totalPaid=0
for i in range(1,13):
	mp=balance*monthlyPaymentRate
	totalPaid+=mp
	balance=(balance-mp)*(annualInterestRate/12+1)

	print 'Month:' +str(i)
	print 'Minimum monthly payment: '+str(round(mp,2))
	print 'Remaining balance: '+str(round(balance,2))

print 'Total paid: '+str(round(totalPaid,2))
print 'Remaining balance: '+str(round(balance,2))