//
//  FavouritesContracts.swift
//  Cryptopia
//
//  Created by İrem Onart on 14.08.2023.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var delegate: FavouritesViewModelDelegate? { get set }
    var numberOfRows: Int { get }
//    func getCoinName(for indexPath: IndexPath) -> String
}

protocol FavouritesViewModelDelegate {
    func coinListFetch()
}
