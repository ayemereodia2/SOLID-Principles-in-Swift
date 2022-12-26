import Foundation

/*
 S: Single Responsibility Principle
 O: Open-Closed Principle
 L: Liskov Substitution Principle
 I: Interface Segregation Principle
 D: Dependency Inversion Principle
 */

// Single Responsibility Principle states that
// A class should have only a single responsibility/have only one reason to change.
/*
 Example 1.0, One class is handling all the different operations like calling API, parsing the response, save to DB whereas according to Single Responsibility principle (Example 1.1) we should have single responsibility for a class so we made one class for each type of responsibilty
 */

// Example 1.0: Non-Single Responsibility

class OneForAllPurposeClass {
    func handle() {
        guard let apiResponse = requestDataFromAPI(),
        let parsedResponse = parse(data: apiResponse) else {
            return
        }
        saveToDataBase(array: parsedResponse)
    }
    
    private func requestDataFromAPI() -> Data? {
        // send api request and wait for response
        nil
    }
    
    private func parse(data: Data?) -> [String]? {
        // parse data and create array
        nil
    }
    
    private func saveToDataBase(array: [String]?) {
        // cache data to DataBase
    }
}

// Example 1.1: Single Responsibility

class MainClassWithAssistanceFromOtherClasses {
    let apiRequest: HandleDataRequestFromAPI
    let dataParsing: HandleDataParsing
    let dataBase: HandleAccessToDataBase
    
    init(apiRequest: HandleDataRequestFromAPI, dataParsing: HandleDataParsing, dataBase: HandleAccessToDataBase) {
        self.apiRequest = apiRequest
        self.dataParsing = dataParsing
        self.dataBase = dataBase
    }
}

class HandleDataRequestFromAPI {
    func requestDataFromAPI() -> Data? {
        // send api request and wait for response
        nil
    }
}

class HandleDataParsing {
    func parse(data: Data?) -> [String]? {
        // parse data and create array
        nil
    }
}

class HandleAccessToDataBase {
    func saveToDataBase(array: [String]?) {
        // cache data to DataBase
    }
}

// MARK :-

// Open-Closed Principle
// If you have to modify a class every time a new behavior is added then something isn't right. Software should be open for extension but closed for modification.

// Example 2.0 Non Open-Closed
/*
 In Example 2.0 We are handling printing for Cars and Buses separately in printData() method. One more vehicle addition & modification required again. If we make a protocol that confirms to all vehicle types then printData() doesn't need modification on any new change.
 */

class Vehicle_NOT_SOLID {
    func printDetails() {
        let cars = [
            Car_NOT_SOLID(name: "Falcon24", color: "Yellow"),
            Car_NOT_SOLID(name: "Zapp2000", color: "Black"),
            Car_NOT_SOLID(name: "BlueAngel", color: "White")]
        
        cars.forEach { car in
            print(car.printDetails())
        }
        
        let buses = [Bus_NOT_SOLID(type: "Marcopolo"),
                     Bus_NOT_SOLID(type: "Haice"),
                     Bus_NOT_SOLID(type: "Hummer")]
        buses.forEach { bus in
            print(bus.printDetails())
        }
    }
}

class Car_NOT_SOLID {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        "name: \(name) and color:\(color)"
    }
}

class Bus_NOT_SOLID {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func printDetails() -> String {
        "bus type: \(type)"
    }
}

// Example 2.1 Open-Closed
protocol Printable {
    func printDetails() -> String
}

class Vehicle_SOLID {
    func printDetails() {
        let vehicles:[Printable] = [Car_SOLID(name: "Falcon24", color: "Yellow"),
                                    Car_SOLID(name: "Zapp2000", color: "Black"),
                                    Car_SOLID(name: "BlueAngel", color: "White"),
                                    Bus_SOLID(type: "Marcopolo"),
                                    Bus_SOLID(type: "Haice"),
                                    Bus_SOLID(type: "Hummer")]
        
        vehicles.forEach { vehicle in
            print(vehicle.printDetails())
        }
        
    }
}

class Car_SOLID:Printable {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        "name: \(name) and color:\(color)"
    }
}

class Bus_SOLID:Printable {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func printDetails() -> String {
        "bus type: \(type)"
    }
}
