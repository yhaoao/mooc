import pymongo

client = pymongo.MongoClient('localhost', 27017)
db = client.school
students=db.students


for student in students.find():
	min_homework=None
	for scoreItem in student['scores']:
		if(scoreItem["type"]=='homework'):
			if(min_homework):
				if(min_homework["score"]>scoreItem["score"]):
					min_homework=scoreItem
			else:
				min_homework=scoreItem
	student['scores'].remove(min_homework)

	students.update({'_id':student['_id']},student)