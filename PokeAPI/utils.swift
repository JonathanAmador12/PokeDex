//
//  utils.swift
//  PokeAPI
//
//  Created by JonathanA on 16/09/22.
//

import Foundation

//enum MockError: Error {
//    case fileDoesNotExist
//    case fileCanNotBeRead
//    case fileContectIsNotAJSON
//}

//func getDataListFromMockFile<T>(mockFileName: String) throws -> [T] where T: Decodable {
//    // Path to the mock file
//    guard let path: String = Bundle.main.path(forResource: mockFileName, ofType: ".json") else {
//        throw MockError.fileDoesNotExist
//    }
//
//    guard let mockFileContent = try? String(contentsOfFile: path) else {
//        throw MockError.fileCanNotBeRead
//    }
//
//    guard let mockFileData = mockFileContent.data(using: .utf8) else {
//        throw MockError.fileCanNotBeRead
//    }
//
//    let decoder = JSONDecoder()
//    let data: [T]
//
//    do {
//        data = try decoder.decode([T].self, from: mockFileData)
//    } catch {
//        print(error)
//        throw MockError.fileContectIsNotAJSON
//    }
//
//    return data
//}


func getDataFromMoclFile<T>(mockFileNme: String) -> T? where T: Decodable {
    guard let mockPath: String = Bundle.main.path(forResource: mockFileNme, ofType: "json")else {
        return nil
    }
    
    guard let mockFileContent: String = try? String(contentsOfFile: mockPath) else {
        return nil
    }
    
    guard let mockData: Data = try? mockFileContent.data(using: .utf8) else {
        return nil
    }
    
    guard let data: T = try? JSONDecoder().decode(T.self, from: mockData) else{
        return nil
    }
    return data
}

