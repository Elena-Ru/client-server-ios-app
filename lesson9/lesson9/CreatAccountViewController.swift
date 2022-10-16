//
//  CreatAccountViewController.swift
//  lesson9
//
//  Created by Елена Русских on 14.10.2022.
//

import UIKit

class CreatAccountViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

 
    @IBAction func registratiomBtnPressed(_ sender: Any) {
        service.regNewUser(email.text!, password.text!) { isReg in
            if isReg {
                self.dismiss(animated: true)
            }
        }
    }
    
}
