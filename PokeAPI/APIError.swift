//
//  APIError.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation
enum APIError: Error {
    case badUrl, badDecode, badResponse, notAutorized
}
