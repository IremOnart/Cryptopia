//
//  ProfileViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 11.08.2023.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProfileViewController: UIViewController {

    
    let viewModel = ProfileViewModel()
    
    private let storage = Storage.storage().reference()
    
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.cornerRadius = 75
            userImage.clipsToBounds = true
            userImage.layer.borderWidth = 1
            userImage.layer.borderColor = UIColor.purple.cgColor
        }
    }
    @IBOutlet weak var containervView: UIView!
    
    @IBAction func editUserPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    @IBOutlet weak var userName: UILabel!{
        didSet{
            userName.text = SingletonModel.sharedInstance.username
        }
    }
    
    @IBOutlet weak var userMail: UILabel!{
        didSet{
            userMail.text = viewModel.userInfo()
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        print("iremmm")
        Database.shared.signOut { error in
            if let error = error {
                print(error)
                return
            }
//            let welcomeControl = LoginViewController()
//            let welcomeNavCon = UINavigationController(rootViewController: welcomeControl)
//            let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
//            welcomeNavCon.modalPresentationStyle = .fullScreen
            tabBarController?.navigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func showFavorutes(_ sender: Any) {
        let vc = FavorutesPageViewController(nibName: "FavorutesPageViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barTintColor = .white
        
        userName.text = SingletonModel.sharedInstance.username
       
        
        self.containervView.layer.cornerRadius = 16
        self.containervView.layer.masksToBounds = true
        containervView.applyShadow(cornerRadius: 8)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(r: 219, g: 202, b: 227)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .purple
        
        SingletonModel.sharedInstance.getUserInfos()
        userName.text = SingletonModel.sharedInstance.username
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.storage.child("image/\(userID)/file.png").downloadURL { url, error in
            guard url == url , error == nil else{
                return
            }
            let urlString = url?.absoluteString
            print("downlanded \(String(describing: urlString))")
            UserDefaults.standard.set(urlString, forKey: "url")
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.userImage.image = image
                
            }
           
        }
        task.resume()
        
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        storage.child("image/\(userID)/file.png").putData(imageData, completion: { _, error in
            guard error == nil else {
                print("failed to upload")
                return
            }
        })
      
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
