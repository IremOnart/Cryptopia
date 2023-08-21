//
//  OnBoardingViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 7.08.2023.
//

import UIKit

class OnBoardingViewController: UIViewController , UIScrollViewDelegate{
    var viewModel = OnboardingViewModel()
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBAction func btnGetStarted(_ sender: Any) {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var btnSignIn: UIButton!
    //    var slides:[SlideView] = [];
    //
    //    static func loadFromNib() -> OnBoardingViewController{
    //        OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
    //    }
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.frame.size.height)
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchOnboardingList { error in
            if let error = error{
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
            
            self.setupScrollView()
        }
        
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.setupScrollView()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        
        
        //crete the slides and add them
        //           var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        
        //set width of scrollview to accomodate all the slides
        //           scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        //
        //           //disable vertical scroll/bounce
        //           self.scrollView.contentSize.height = 1.0
        //
        //           //initial state
        //           pageControl.numberOfPages = titles.count
        //           pageControl.currentPage = 0
        
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        
        for index in 0..<viewModel.numberOfItems {
            let onboarding = viewModel.getOnboarding(index: index)
            guard let slideView = SlideView.fromNib() as? SlideView else {
                return
            }
            slideView.titleLabel.text = onboarding.title
            slideView.descriptionLabel.text = onboarding.description
            slideView.imageView.image = UIImage(named: onboarding.image)
            slideView.translatesAutoresizingMaskIntoConstraints = false
            slideView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//            slideView.heightAnchor.constraint(equalToConstant: 125).isActive = true
            stackView.addArrangedSubview(slideView)
            
          
            
        }
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
}


extension UIView {
    public class func fromNib<T: UIView>() -> T {
        let name = String(describing: Self.self);
        guard let nib = Bundle(for: Self.self).loadNibNamed(
            name, owner: nil, options: nil)
        else {
            fatalError("Missing nib-file named: \(name)")
        }
        return nib.first as! T
    }
}
