import csv
import unittest

from main import ClearanceOrder


class TestClearanceOrder(unittest.TestCase):
    def test_clearance_order(self):
        filename = 'test_passenger_data.csv'
        with open(filename, 'w') as file:
            writer = csv.writer(file)
            headers = ['Passenger Name', 'Airport', 'City', 'State', 'Country', 'Airliner']
            writer.writerow(headers)
            writer.writerow(['John Doe', 'JFK', 'New York', 'NY', 'US', 'Delta Airlines'])
            writer.writerow(['Jane Doe', 'LAX', 'Los Angeles', 'CA', 'US', 'American Airlines'])
            writer.writerow(['John Smith', 'ORD', 'Chicago', 'IL', 'US', 'United Airlines'])
            writer.writerow(['Jane Smith', 'LHR', 'London', '', 'UK', 'British Airways'])

        co = ClearanceOrder(filename)
        order = co.sort()

        assert len(order) == 4
        assert order[0][0] == 'Jane Smith'
        assert order[1][0] == 'John Smith'
        assert order[2][0] == 'Jane Doe'
        assert order[3][0] == 'Jane Doe'


if __name__ == '__main__':
    unittest.main()
