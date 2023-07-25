//
//  ViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.07.2023.
//

import UIKit
import CryptopiaAPI


class ViewController: UIViewController {

    let service: TopCrytopiaProtocol = TopCrytopiaService()
    override func viewDidLoad() {
        super.viewDidLoad()
        service.fetchTopCoins(){ (currensies) in
          
                print(currensies)
            
            
        }


    }
    
        
}
