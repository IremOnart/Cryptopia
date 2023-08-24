//
//  CryptopiaContracts.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import CryptopiaAPI
import UIKit

protocol CryptopiaViewModelProtocol {
    var filteredCoins: [GetDataModel] { get set }
    var numberOfRows: Int { get }
    var delegate: CryptopiaViewModelDelegate? { get set }
    var product: [GetDataModel] { get set }
    func inSearchModel(_ searchController: UISearchController) -> Bool
    func updateSearchController(searchBarText: String?)
    func getCoin(for indexPath: IndexPath) -> GetDataModel
    func getData()
    func getCoinsDetails()
}

enum CryptopiaViewModelOutput {
    case updateTitle(String)
    case showCryptopiaList([CoinsPresentation])
}

enum CryptopiaViewRoute{
    case detail(CryptopiaViewModelProtocol)
}

protocol CryptopiaViewModelDelegate {
    func handleViewModelOutput(_ output: CryptopiaViewModelOutput)
    func navigate(to route: CryptopiaViewRoute)
    func coinListFetch()
}
