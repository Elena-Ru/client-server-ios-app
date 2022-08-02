//
//  News.swift
//  VKontakte
//
//  Created by Елена Русских on 02.07.2022.
//

import Foundation
import UIKit

class News {
    var newsPhoto: UIImage
    var newsText: String
    var likeCount: Int = 0
    var isLike: Bool = false
    var commentCount: Int = 0
    var shareCount: Int = 0
    var viewCount: Int = 0
    
    init( photo: UIImage, text: String){
        self .newsPhoto = photo
        self.newsText = text
    }
}
