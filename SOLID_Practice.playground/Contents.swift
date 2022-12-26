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

// Example Non-Single Responsibility

class OneForAllPurposeClass {
    func handle() {
        guard let apiResponse = requestDataFromAPI(),
        let parsedResponse = parse(data: apiResponse) else {
            return
        }
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

// Single Responsibility

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
