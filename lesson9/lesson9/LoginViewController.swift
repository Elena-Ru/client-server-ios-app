//
//  ViewController.swift
//  lesson9
//
//  Created by Елена Русских on 14.10.2022.
//

import UIKit
import SwiftUI
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUp(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegVC")
        
        self.present(vc, animated: true)
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        service.signIn(email.text!, password.text!) { isSign in
            if isSign{
                UserDefaults.standard.set(true, forKey: "isLogin")
               
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
              
                self.present(vc, animated: true)
            }
        }

    }
}

