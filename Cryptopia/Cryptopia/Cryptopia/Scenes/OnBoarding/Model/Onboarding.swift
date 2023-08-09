//
//  Onboarding.swift
//  Cryptopia
//
//  Created by İrem Onart on 9.08.2023.
//

import Foundation

struct OnboardingBaseResponse: Decodable {
    let result: [Onboarding]
}

struct Onboarding: Decodable {
    let title: String
    let description: String
    let image: String
}
