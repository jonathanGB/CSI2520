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
