//
//  Result.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
