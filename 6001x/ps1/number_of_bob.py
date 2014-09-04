s = 'azcbobobegghakl'
l=len(s)-2
result=0

for i in range(l):
	if(s[i:i+3]=='bob'):
		result+=1
print result
