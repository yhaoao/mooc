def canPayOff(paid,balance):
	for i in range(1,13):
		balance=(balance-paid)*(annualInterestRate/12+1)
	return balance<=0

paid=10

while(not canPayOff(paid,balance)):
	paid+=10

print paid