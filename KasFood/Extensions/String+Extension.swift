//
//  String+Extension.swift
//  KasFood
//
//  Created by Aziz Zhandar on 28.06.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
