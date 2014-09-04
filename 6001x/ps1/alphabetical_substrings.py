#s = 'azcbobobegghakl'
low=0

a=list()

for i in range(1,len(s)):
	if(s[i]<s[i-1]):
		a.append(s[low:i])
		low=i
a.append(s[low:])

maxLen=0
result=''
for part in a:
	if len(part)>maxLen:
		maxLen=len(part)
		result=part
print result