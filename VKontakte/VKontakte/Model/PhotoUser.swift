//
//  PhotoUser.swift
//  VKontakte
//
//  Created by Елена Русских on 26.06.2022.
//

import Foundation
import UIKit

//Содержит инфо о фотографии
class PhotoUser {
    
    var likeCount: Int = 0
    var photo: UIImage
    var isLike: Bool = false
    
    init(image: UIImage){
        self.photo = image
    }
    
}
