import csv

def read_data(filename):
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        header = next(reader)
        data = [row for row in reader]
    return data

def divide_data(data):
    national = []
    international = []
    for row in data:
        if row[4] == "US":
            national.append(row)
        else:
            international.append(row)
    return national, international

def analyze_national(national):
    destination_city = [row[2] for row in national]
    destination_state = [row[3] for row in national]
    airliners = [row[5] for row in national]
    return set(destination_city), set(destination_state), set(airliners)

def analyze_international(international):
    destination_city = [row[2] for row in international]
    destination_country = [row[4] for row in international]
    airliners = [row[5] for row in international]
    return set(destination_city), set(destination_country), set(airliners)

def conquer(national, international):
    national_city, national_state, national_airliner = analyze_national(national)
    international_city, international_country, international_airliner = analyze_international(international)
    print("Passenger {} are the national travel".format(','.join([row[0] for row in national])))
    print("Passenger {} are the international travel".format(','.join([row[0] for row in international])))
    print("The destination of passenger {} are different with passenger {}".format(','.join([row[0] for row in international]), 
    ','.join([row[0] for row in national])))
    print("The passenger {} have the different destination with each other.".format(','.join([row[0] for row in international])))
    if len(national_airliner) == 1:
        print("The airliners passenger {} taken are the same".format(','.join([row[0] for row in national])))
    else:
        print("The airliners passenger {} taken are different".format(','.join([row[0] for row in national])))
    if len(international_airliner) == 1:
        print("The airliners passenger {} taken are the same".format(','.join([row[0] for row in international])))
    else:
        print("The airliners passenger {} taken are different".format(','.join([row[0] for row in international])))

def main(filename):
    data = read_data(filename)
    national, international = divide_data(data)
    conquer(national, international)

if __name__ == "__main__":
    main("/home/xuyuhan/Desktop/BU-learn-S2023/METCS566O1/HW2/python_code/passenger_information.csv")
