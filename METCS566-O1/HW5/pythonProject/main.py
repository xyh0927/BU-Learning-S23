import pandas as pd

class FlightAllocator:
    def __init__(self, flights_file, passengers_file):
        # Read flight data from CSV file into a pandas dataframe
        self.flights = pd.read_csv(flights_file, header=None, names=['flight_id', 'city', 'region', 'country'])

        # Create a dictionary to map regions to flight IDs
        self.region_flight_map = {}
        for region, group in self.flights.groupby('region'):
            self.region_flight_map[region] = list(group['flight_id'])

        # Read passenger data from CSV file into a pandas dataframe
        self.passengers = pd.read_csv(passengers_file, header=None, names=['passenger_id', 'region'])

        # Create a dictionary to store the mapping of passengers to flights
        self.passenger_flight_map = {}

    def allocate_flights(self):
        # Use dynamic programming to assign passengers to flights based on their destination region
        for i, passenger in self.passengers.iterrows():
            region = passenger['region']
            if region in self.region_flight_map:
                flight_options = self.region_flight_map[region]
                min_passengers = float('inf')
                best_flight = None
                for flight in flight_options:
                    if flight not in self.passenger_flight_map:
                        self.passenger_flight_map[flight] = []
                    passengers_on_flight = len(self.passenger_flight_map[flight])
                    if passengers_on_flight < min_passengers:
                        min_passengers = passengers_on_flight
                        best_flight = flight
                self.passenger_flight_map[best_flight].append(passenger['passenger_id'])

    def print_allocation(self):
        # Output the passenger allocation result in the format of flight id plus passenger id
        for flight_id, passengers in self.passenger_flight_map.items():
            for passenger_id in passengers:
                print(f"Passenger {passenger_id} allocated to flight {flight_id},")


flight_csv_path = input(str("Insert the path of Flight.csv: "))
passenger_requirement_path = input(str("Insert the path of passenger_requirement.csv: "))
flight_allocator = FlightAllocator(flight_csv_path, passenger_requirement_path)
flight_allocator.allocate_flights()
flight_allocator.print_allocation()
