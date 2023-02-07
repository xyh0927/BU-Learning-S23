import csv

# Class ClearanceOrder is used to sort passenger data
class ClearanceOrder:
    # Constructor that initializes an empty list 'data' and reads a csv file
    def __init__(self, filename):
        self.data = []
        with open(filename, 'r') as file:
            reader = csv.reader(file)
            headers = next(reader)
            for row in reader:
                self.data.append(row)

    # Partition method used in quicksort
    def partition(self, low, high):
        pivot = self.data[high][5][0] # pivot is the first character of the 6th column (airliner)
        i = low - 1
        for j in range(low, high):
            # compare priority of current row and pivot row
            if self.priority(self.data[j], self.data[high]) < 0:
                i = i + 1
                self.data[i], self.data[j] = self.data[j], self.data[i]
        self.data[i + 1], self.data[high] = self.data[high], self.data[i + 1]
        return i + 1

    # Quicksort method
    def quickSort(self, low, high):
        if low < high:
            pi = self.partition(low, high)
            self.quickSort(low, pi - 1)
            self.quickSort(pi + 1, high)

    # Method that returns 1 if priority of row 'a' is greater than row 'b', -1 otherwise
    def priority(self, a, b):
        if a[4] != b[4]:  # compare country
            if a[4] == 'US':
                return 1
            else:
                return -1
        else:  # country is same, compare first character of airliner
            if a[5][0] > b[5][0]:
                return -1
            else:
                return 1

    # Method that calls quicksort and returns sorted 'data'
    def sort(self):
        self.quickSort(0, len(self.data) - 1)
        return self.data

# Get path of csv file from user
csvfile = str(input("Please enter the path of your CSV file: "))
# Create an instance of ClearanceOrder
co = ClearanceOrder(csvfile)
# Get sorted data
order = co.sort()

# Print sorted data for US passengers
print("National:")
for passenger in order:
    if passenger[4] == 'US':
        print("Passenger:", passenger[0])
        print("Destination Airport:", passenger[1])
        print("Destination City:", passenger[2] + "," + passenger[3])
        print("Airliner:", passenger[5])
        print()
print()
print()

# Print sorted data for non-US passengers
print("International:")
for passenger in order:
    if passenger[4] != 'US':
        print("Passenger:", passenger[0])
        print("Destination Airport:", passenger[1])
        print("Destination Country:", passenger[4])
        print("Destination City:", passenger[2] + "," + passenger[3])
        print("Airliner:", passenger[5])
        print()

#Print the sorted order for the passenger
print("Clearance Order:")
for passenger in order:
    print(passenger[0], end=" ")


