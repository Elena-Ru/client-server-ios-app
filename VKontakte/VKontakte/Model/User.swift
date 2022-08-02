//
//  User.swift
//  VKontakte
//
//  Created by Елена Русских on 20.06.2022.
//

import Foundation
import UIKit

class User {
    
    let name: String
    var image = [PhotoUser]()
    
    init(name: String, image : [PhotoUser]) {
        self.image = image
        self.name = name
    }
   
}
