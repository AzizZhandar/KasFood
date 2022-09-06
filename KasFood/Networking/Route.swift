//
//  Route.swift
//  KasFood
//
//  Created by Aziz Zhandar on 05.07.2022.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me"
    
    case temp
    case placeOrder(String)
    
    var description: String {
        switch self {
        case .temp: return "/temp"
        case .placeOrder(let dishId): return "/order/\(dishId)"
        }
    }
}
