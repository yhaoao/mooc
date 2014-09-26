import pymongo

client = pymongo.MongoClient('localhost', 27017)
db = client.students
grades=db.grades

# for grade in grades.find():
# 	print grade

for i in range(200):
	for grade in grades.find({'student_id':i,'type':'homework'}).sort('score').limit(1):
		id=grade['_id']
		print grades.remove({'_id':id})



