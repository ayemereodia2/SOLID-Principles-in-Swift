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

// MARK :-

// Liskov Substitution Principle
// Objects in a program should be replaceable with instances of their sub types without altering the correctness of the program

//  Example 3.0 Non Liskov Substitution

class Rectangle_NON_SOLID {
    var width: Double = 0.0
    var height: Double = 0.0
    
    var area: Double {
        width * height
    }
}

class Square_NON_SOLID: Rectangle_NON_SOLID {
    //Square class is trying to play around with it's parent class Rectangle's properties
    override var width: Double {
        didSet {
            height = width
        }
    }
}

func printArea(of rectangle: Rectangle_NON_SOLID) {
    rectangle.width = 40.0
    rectangle.height = 10.0
    
    print(rectangle.area)
}

let rect = Rectangle_NON_SOLID()
printArea(of: rect)

let square = Square_NON_SOLID()
printArea(of: square)

/* Square class is trying to play around with it's parent class Rectangle's properties whereas according to Liskov Substitution it's not allowed so we made a new protocol that handles the area and left calculation is handled by each class individually.
 */

// Example 3.1 Liskov Substitution
protocol Polygon {
    var area: Double { get }
}

class Rectangle_SOLID: Polygon {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    var area: Double {
        return width * height
    }
}

class Square_SOLID: Polygon {
    var sides: Double
    
    init(side: Double) {
        self.sides = side
    }
    
    var area: Double {
        return pow(sides, 2)
    }
}

func printArea(of polygon: Polygon) {
    print(polygon.area)
}

let rectO = Rectangle_SOLID(width: 40.0, height: 10.0)
printArea(of: rectO)

let squareO = Square_SOLID(side: 40.0)
printArea(of: squareO)

// MARK :-

// Interface Segregation Principle

// Many client-specific abstractions (interfaces) are better than one general-purpose interface.

protocol LargeGeneralPurposeAbstarction {
    func didTap()
    func didLongPress()
    func didSwipe()
}

// Example 4.1 Non Interface Segregation

class Rich_Button_NOT_SOLID: LargeGeneralPurposeAbstarction {
    func didTap() {
        print("didTap")
    }
    
    func didLongPress() {
        print("didLongPress")
    }
    
    func didSwipe() {
        print("didSwipe")
    }
}


class Poor_Button_NOT_SOLID: LargeGeneralPurposeAbstarction {
    func didTap() {
        print("didTap")
    }
    
    func didLongPress() {
        // not used
    }
    
    func didSwipe() {
        // not used
    }
}

// Example 4.2 Interface Segregation Principle

/* In Example 4.1, we made one FAT protocol that has everything at one place whereas in Rich Button you have more functionalities than in Poor Button were we have limited functionalities to play around with, therefore we made requirement specific protocols in Example 4.2 */

protocol TapGesture {
    func didTap()
}

protocol LongPressGesture {
    func didLongPress()
}

protocol SwipeGesture {
    func didSwipe()
}

class Rich_Button_SOLID: TapGesture, LongPressGesture, SwipeGesture {
    func didTap() {
        print("didTap")
    }
    
    func didLongPress() {
        print("didLongPress")
    }
    
    func didSwipe() {
        print("didSwipe")
    }
}

class Poor_Button_SOLID: TapGesture {
    func didTap() {
        print("didTap")
    }
}

// MARK :-

// Dependency Inversion Principle

// High level modules should not depend on low level modules. Both should depend on abstractions

// Example 5.1 Non Dependency Inversion

class SaveData_NOT_SOLID {
    let fileSystem = FileSystemManager_NOT_SOLID()
    
    func handle(data: String) {
        fileSystem.save(file: data)
    }
}

class FileSystemManager_NOT_SOLID {
    func save(file: String) {
        // save data
    }
}

// Example 5.2 Dependency Inversion
/*
 In Example 5.1 SaveData Class is completely dependent on FileSystemManager which makes former non reusuable. In Example 5.2 if we want to play around with the way we save Data or If we want to use any DataBase Technology so we defined Storage protocol & made every single peace independent.
 */

// Example 5.2 Dependency Inversion

protocol Storage {
    func save(file: String)
}

class SaveData_SOLID {
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}

class FileSystemManager_SOLID: Storage {
    func save(file: String) {
        // save data
    }
}

class MySQLDataBase: Storage {
    func save(file: String) {
        // save data
    }
}

var numbers = [3, 7, 9]
numbers.removeFirst()
print(numbers)
