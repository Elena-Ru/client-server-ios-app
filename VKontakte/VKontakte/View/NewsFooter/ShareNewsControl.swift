//
//  ShareNewsControl.swift
//  VKontakte
//
//  Created by Елена Русских on 03.07.2022.
//

import UIKit

class ShareNewsControl: UIControl {
    

    var newsItem: News!
    
    let shareCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 30, height: 30))
    let shareButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    
    func setShareNewsControl(news : News, cellIndex: Int) {
        newsItem = news
        shareCount.text = String(news.commentCount)
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.tintColor = .lightGray
        shareCount.textColor = .lightGray
        addSubview(shareButton)
        addSubview(shareCount)
    }
}
