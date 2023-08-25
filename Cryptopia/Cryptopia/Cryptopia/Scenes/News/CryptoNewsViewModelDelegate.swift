//
//  CryptoNewsViewModelDelegate.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.08.2023.
//

import Foundation
import CryptopiaAPI

protocol CryptoNewsViewModelProtocol {
    var delegate: CryptoNewsViewModelDelegate? { get set }
    var numberOfRows: Int { get }
    func getCoin(for indexPath: IndexPath) -> New
    func getNewsData()
}


protocol CryptoNewsViewModelDelegate {
    func newListFetch()
}
