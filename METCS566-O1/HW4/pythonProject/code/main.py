import csv
import heapq

class Graph:
    def __init__(self):
        self.edges = {}

    def add_edge(self, from_node, to_node, distance):
        if from_node not in self.edges:
            self.edges[from_node] = {}
        self.edges[from_node][to_node] = distance
        if to_node not in self.edges:
            self.edges[to_node] = {}
        self.edges[to_node][from_node] = distance

def dijkstra(graph, initial_node):
    distances = {node: float('inf') for node in graph.edges}
    distances[initial_node] = 0
    pq = [(0, initial_node)]
    while pq:
        current_distance, current_node = heapq.heappop(pq)
        if current_distance > distances[current_node]:
            continue
        for neighbor, distance in graph.edges[current_node].items():
            total_distance = current_distance + distance
            if total_distance < distances[neighbor]:
                distances[neighbor] = total_distance
                heapq.heappush(pq, (total_distance, neighbor))
    return distances

# Ask the user for the path to the CSV file
csv_path = input("Please enter the path of the CSV file: ")

# Read the passenger data from the CSV file
passenger_data = []
with open(csv_path, "r") as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader) # Skip the header row
    for row in csv_reader:
        passenger_data.append(row)

# Create a graph of cities and their distances from Boston
graph = Graph()
graph.add_edge("Boston", "Boston", 0) # add Boston as a node
for row in passenger_data:
    from_node = "Boston"
    to_node = row[2]
    distance = int(row[6])
    graph.add_edge(from_node, to_node, distance)

# Calculate the shortest distance from Boston to each destination city
passenger_distances = []
for row in passenger_data:
    passenger_id = row[0]
    destination_city = row[2]
    distance = dijkstra(graph, "Boston")[destination_city]
    passenger_distances.append((passenger_id, destination_city, distance))

# Sort the passengers by their distance from Boston
passenger_distances.sort(key=lambda x: x[2])

# Print the sorted list of passengers and their distances
print("Passenger information sorted by shortest distance from Boston:")
print("Passenger ID\tDestination City\tDistance from Boston")
for passenger in passenger_distances:
    print(f"{passenger[0]}\t{passenger[1]}\t{passenger[2]} miles")

