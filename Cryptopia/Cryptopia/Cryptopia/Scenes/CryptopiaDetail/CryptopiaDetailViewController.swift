//
//  CryptopiaDetailViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 27.07.2023.
//

import UIKit
import CryptopiaAPI
import Kingfisher
import Charts
import DGCharts
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import FirebaseDatabase

class CryptopiaDetailViewController: UIViewController {
    
    private var clearAction = false
    var database = Database()
    let db = Firestore.firestore()
    let viewModel: CryptopiaDetailViewModel
    var boolean: String = ""
    var booleanValue: String = ""
    var nameOfButton: String = ""
    //    private var database = Database
    init(_ viewModel: CryptopiaDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    private let userCollection = Firestore.firestore().collection("users")
    
    func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    func userFavouriteProductCollection(userId: String) -> CollectionReference{
        userDocument(userId: userId).collection("favourite_products")
        
    }
    func userFavouriteProductDocument(userId: String, favouriteProductId: String) -> DocumentReference {
        userFavouriteProductCollection(userId: userId).document(favouriteProductId)
    }
    
    @IBOutlet weak var outletButton: UIButton!
    
    
    @IBAction func addToFavButton(_ sender: UIButton) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        userFavouriteProductDocument(userId: userID, favouriteProductId: viewModel.coin.id ?? "").collection("buttonBoolean").document("buttonBoolean").getDocument { documentSnapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.booleanValue = documentSnapshot?.data()?["buttonBoolean"] as? String ?? "null"
        }
        outletButton.setTitle(booleanValue, for: .normal)
        print(booleanValue)
        
        if booleanValue == "Add Favorites" {
            print(SingletonModel.sharedInstance.productId)
            removeUserFavProd(userId: userID, favouriteProductId: viewModel.coin.id ?? "")
            nameOfButton = "Delete Favourite"
            sender.setTitle(booleanValue, for: .normal)
            print("iremmm")
            clearAction = false
        }else {
            addUserfavProd(userId: userID, productId: viewModel.coin.id!)
            nameOfButton = "Add Favorites"
            sender.setTitle(booleanValue, for: .normal)
            clearAction = true
        }
        
        userFavouriteProductDocument(userId: userID, favouriteProductId: viewModel.coin.id ?? "").collection("buttonBoolean").document("buttonBoolean").setData([
            "buttonBoolean": nameOfButton], merge: true)
        
    }
    
    func addUserfavProd(userId: String, productId: String) {
        let document = userFavouriteProductCollection(userId: userId).document(viewModel.coin.id ?? "")
        let documentId = document.documentID
        
        let data: [String:Any] = [
            "Userid": documentId,
            "coinId": viewModel.coin.id ?? "",
            "icon": viewModel.coin.icon ?? "",
            "name": viewModel.coin.name ?? "",
            "price": viewModel.coin.price ?? "",
            "priceChange": viewModel.coin.priceChange1d ?? "",
            "symbol": viewModel.coin.symbol ?? ""
        ]
        document.setData(data, merge: false)
    }
    
    func removeUserFavProd(userId: String, favouriteProductId: String){
        userFavouriteProductDocument(userId: userId, favouriteProductId: favouriteProductId).delete()
    }
    
    @IBOutlet weak var volumeLabel: UILabel!{
        didSet{
            volumeLabel.text = "\(round(10000 * (viewModel.coin.volume ?? 0))/10000)"
        }
    }
    @IBOutlet weak var marketCapLabel: UILabel!{
        didSet{
            marketCapLabel.text = "\(round(10000 * (viewModel.coin.marketCap ?? 0))/10000)"
        }
    }
    @IBOutlet weak var availableSupplyLabel: UILabel!{
        didSet{
            availableSupplyLabel.text = "\(round(10000 * (viewModel.coin.availableSupply ?? 0))/10000)"
        }
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            viewModel.getTimeFromSegmentedControl = "24h"
        case 1:
            viewModel.getTimeFromSegmentedControl = "1w"
        case 2:
            viewModel.getTimeFromSegmentedControl = "1m"
        case 3:
            viewModel.getTimeFromSegmentedControl = "3m"
        case 4:
            viewModel.getTimeFromSegmentedControl = "6m"
        case 5:
            viewModel.getTimeFromSegmentedControl = "1y"
        default:
            break
        }
    }
    
    @IBOutlet weak var coinNameLabel: UILabel!{
        didSet{
            coinNameLabel.text = viewModel.coin.name
        }
    }
    @IBOutlet weak var coinImageView: UIImageView!{
        didSet{
            coinImageView.kf.setImage(with: URL(string: viewModel.coin.icon ?? ""))
        }
    }
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            priceLabel.text = "$ \(round(10000 * (viewModel.coin.price ?? 0))/10000)"
            
        }
    }
    @IBOutlet weak var priceChangeLabel: UILabel!{
        didSet{
            priceChangeLabel.text = "% \(viewModel.coin.priceChange1d ?? 0)"
            priceChangeLabel.textColor = viewModel.coin.priceChange1d ?? 0 > 0 ? .green : viewModel.coin.priceChange1d ?? 0 < 0 ? .red : .black
        }
        
    }
    
    @IBOutlet weak var lineChartView: LineChartView!{
        didSet{
            lineChartView.rightAxis.enabled = false
            let yAxis = lineChartView.leftAxis
            yAxis.labelFont = .boldSystemFont(ofSize: 8)
            yAxis.labelTextColor = .lightGray
            yAxis.setLabelCount(6, force: false)
            yAxis.axisLineColor = .darkGray
            yAxis.labelPosition = .outsideChart
            
            lineChartView.xAxis.labelPosition = .bottom
            lineChartView.xAxis.labelRotationAngle = CGFloat(90.0)
            lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 15)
            lineChartView.xAxis.axisLineColor = .darkGray
            lineChartView.xAxis.labelTextColor = .lightGray
            lineChartView.xAxis.valueFormatter = DateValueFormatter()
            lineChartView.xAxis.granularity = 1.0
            lineChartView.leftAxis.gridColor = .clear
            lineChartView.rightAxis.gridColor = .clear
            lineChartView.animate(xAxisDuration: 2.5)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        lineChartView.backgroundColor = .white
        title = viewModel.coin.symbol
        print(viewModel.coin.name ?? "")
        viewModel.getData()
        
        self.containerView.layer.cornerRadius = 16
        self.containerView.layer.masksToBounds = true
        containerView.applyShadow(cornerRadius: 8)
        
        self.detailView.layer.cornerRadius = 16
        self.detailView.layer.masksToBounds = true
        detailView.applyShadow(cornerRadius: 8)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(r: 219, g: 202, b: 227)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .purple
        
        
        outletButton.setTitle(booleanValue, for: .normal)
        
        
        
    }
    
}

extension UIColor {
    convenience init(r: CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: a
        )
    }
}

extension CryptopiaDetailViewController: CryptopiaDetailViewModelDelegate{
    func didPeriodChanged() {
        viewModel.getData()
    }
    
    
    func didCoinDetailFetched() {
        DispatchQueue.main.async {
            self.lineChartView.data = self.viewModel.chartData
        }
        
    }
    
    
}

extension CryptopiaDetailViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}


