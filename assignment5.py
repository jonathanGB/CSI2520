# RUNNING ON PYTHON 2.7.6

# Question 1

def cubeLess(X, B):
	return B - X**3


def smallerCube(num):
	listOfSmaller = []
	
	for i in xrange(1, num):
		rest = cubeLess(i, num)

		if rest >= 0:
			listOfSmaller.append((i, rest))
		else:
			break

	return listOfSmaller


def restSum(listSmaller):
	sumSmaller = 0

	for i in listSmaller:
		sumSmaller += i[1]

	return sumSmaller


def showAllRestSum(minVal, maxVal):
	allRestList = []

	for i in range(minVal, maxVal + 1):
		result = restSum(smallerCube(i))

		if result % 3 == 0:
			allRestList.append((i, result))

	return allRestList



# Question 2
fi = open('car_imperial.txt', 'rb')
fo = open('car_metric.txt', 'wb')

for row in fi:
	cells = row.split(' ')
	
	cells[-1] = 'm^3'
	cells[-3] = 'L/100km,'
	cells[-2] = str(round(0.0283168466 * int(cells[-2]), 3))
	cells[-4] = str(round(235.215 / int(cells[-4]), 1)) 

	fo.write(' '.join(cells) + '\n')


fi.close()
fo.close()	
