import csv
import requests

# To define a Airports class to save the airports information
class Airports:
    def __init__(self, airport_iata_code, airport_name, city, region, country, country_iso_alpha2, timezone, time_offset, latitude, longitude):
        self.airport_iata_code = airport_iata_code
        self.airport_name = airport_name
        self.city = city
        self.region = region
        self.country = country
        self.country_iso_alpha2 = country_iso_alpha2
        self.timezone = timezone
        self.time_offset = time_offset
        self.latitude = latitude
        self.longitude = longitude

# To define a Passengers class to save the Passengers information
class Passengers:
    def __init__(self, passenger_id, airport, city, state, country, airliner):
        self.passenger_id = passenger_id
        self.airport = airport
        self.city = city
        self.state = state
        self.country = country
        self.airliner = airliner

# To define a function to calculate the distance between two cities
def distance(city1, city2, airports):
    lat1 = float(airports[city1].latitude)
    lon1 = float(airports[city1].longitude)
    lat2 = float(airports[city2].latitude)
    lon2 = float(airports[city2].longitude)
    distance = ((lat1-lat2)**2 + (lon1-lon2)**2)**0.5
    return distance

# To read the airports information and save it in a dictionary
response = requests.get("https://raw.githubusercontent.com/G-Tarik/Airports_IATA_Codes/master/airports_iata_codes.csv")
airports_dict = {}
reader = csv.reader(response.text.strip().split('\n'))
header = next(reader)
for row in reader:
    airport = Airports(*row)
    airports_dict[airport.city] = airport

# input the path of the file
filename = input("Please input the path of your csv file：")

# read the csv file and save it to a list
passengers_list = []
with open(filename, newline='') as csvfile:
    reader = csv.reader(csvfile)
    header = next(reader)
    for row in reader:
        passenger = Passengers(*row)
        passengers_list.append(passenger)

# To sort the passenger by Greedy Algorithm
sorted_passengers_list = []
start_city = "Boston"
while passengers_list:
    min_distance = float('inf')
    next_passenger = None
    for passenger in passengers_list:
        d = distance(start_city, passenger.city, airports_dict)
        if d < min_distance:
            min_distance = d
            next_passenger = passenger
    sorted_passengers_list.append(next_passenger)
    passengers_list.remove(next_passenger)
    start_city = next_passenger.city

# print the passengers information after sorted
for passenger in sorted_passengers_list:
    print(passenger.passenger_id, passenger.airport, passenger.city, passenger.state, passenger.country, passenger.airliner)