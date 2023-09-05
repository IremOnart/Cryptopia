//
//  DateFormatter.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 26.08.2023.
//

import Foundation

public enum Decoders {
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yy"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
