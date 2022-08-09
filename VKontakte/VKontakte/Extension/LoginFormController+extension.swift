//
//  LoginFormController+extension.swift
//  VKontakte
//
//  Created by Елена Русских on 19.06.2022.
//

import Foundation
import UIKit

extension LoginFormController{
    
    func alert(message: String){
        let alertVC = UIAlertController(title: "Error",
                                        message: message,
                                        preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default){ _ in
            self.loginInput.text = ""
            self.passwordInput.text = ""
        }
            alertVC.addAction(okAction)
        present(alertVC, animated: true)
        
    }
    
}
