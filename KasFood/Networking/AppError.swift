//
//  AppError.swift
//  KasFood
//
//  Created by Aziz Zhandar on 05.07.2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh, I have no idea what go on"
        case .invalidUrl:
            return "HEYY! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
