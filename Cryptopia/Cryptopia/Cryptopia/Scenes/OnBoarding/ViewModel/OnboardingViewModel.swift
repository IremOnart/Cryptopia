//
//  OnboardingViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 9.08.2023.
//

import Foundation

final class OnboardingViewModel {
    typealias OnboardingList = [Onboarding]
    
    var onboardingList = OnboardingList()
    
    var numberOfItems: Int {
        onboardingList.count
    }
    
    func getOnboarding(index: Int) -> Onboarding {
        onboardingList[index]
    }
    
    func fetchOnboardingList(completion: (Error?) -> Void) {
        guard let url = Bundle.main.url(forResource: "OnboardingList", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let onboardingList = try JSONDecoder().decode(OnboardingBaseResponse.self, from: data)
            self.onboardingList = onboardingList.result
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
