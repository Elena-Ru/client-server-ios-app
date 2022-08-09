//
//  NewsTableViewCell.swift
//  VKontakte
//
//  Created by Елена Русских on 02.07.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var NewsViewController: UIViewController!
    
    @IBOutlet weak var newsText: UILabel!
        
    @IBOutlet weak var newsLike: LikeNewsControl!
    @IBOutlet weak var newsComment: CommentNewsControl!
    @IBOutlet weak var newsShare: ShareNewsControl!
    @IBOutlet weak var newsViewsCounter: ViewNewsCounter!
    @IBOutlet weak var newsStatistic: UIView!
    @IBOutlet weak var newsPhoto: UIImageView!
    
    var backgroudColorControlDeselect = UIColor(red: 57/255, green: 47/255, blue: 68/255, alpha: 1)
    var backgroudColorControlSelect = UIColor.systemRed.withAlphaComponent(0.3)
    var backgroundColorCell = UIColor(red: 24/255, green: 15/255, blue: 36/255, alpha: 1)
    var cornerRadius: CGFloat = 15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        newsLike.addGestureRecognizer(tap)
    }

    
    @objc func handleTap(_: UITapGestureRecognizer){
        
    if newsLike.newsItem.isLike {
        
        newsLike.newsItem.likeCount -= 1
        newsLike.likeCount.textColor = .lightGray
        animateLikeCountAppear()
        } else {
              
            newsLike.newsItem.likeCount += 1
            newsLike.likeCount.textColor = .systemRed
            animateLikeCountAppear()
            gruopanimation()
           }
        newsLike.newsItem.isLike.toggle()
        newsLike.setLikeButton(isLike: newsLike.newsItem.isLike)
}

func animateLikeCountAppear(){
    UIView.transition(with: newsLike.likeCount,
                      duration: 0.5,
                      options: .transitionFlipFromRight) { [self] in
        self.newsLike.likeCount.text = String(newsLike.newsItem.likeCount)
}
}

func gruopanimation(){
    let groupAnimation = CAAnimationGroup()
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.duration = 0.5

    let scaleDown = CABasicAnimation(keyPath: "transform.scale")
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1.0
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 0.0
    fade.toValue = 1.0

    groupAnimation.animations = [scaleDown,fade]
    newsLike.likeButton.layer.add(groupAnimation, forKey: nil)
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
  
    func configure(newsItem: News, cellIndex: Int) {
        self.backgroundColor = backgroundColorCell
        self.newsStatistic.backgroundColor = backgroundColorCell
        self.newsText.backgroundColor = backgroundColorCell
        self.newsText.textColor = .white
        setControl(control: newsLike)
        self.newsLike.setLikeNewsControl(news: newsItem, cellIndex: cellIndex)
        setControl(control: newsComment)
        self.newsComment.setCommentNewsControl(news: newsItem, cellIndex: cellIndex)
        setControl(control: newsShare)
        self.newsShare.setShareNewsControl(news: newsItem, cellIndex: cellIndex)
        self.newsViewsCounter.backgroundColor = backgroundColorCell
        self.newsViewsCounter.setViewNewsCounter(news: newsItem)
        self.newsText.text = newsItem.newsText
        self.newsPhoto.image = newsItem.newsPhoto
        
    }
    
    func setControl(control: UIControl){
        control.backgroundColor = backgroudColorControlDeselect
        control.layer.cornerRadius = cornerRadius
        control.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
    super.prepareForReuse()
    self.newsText.text = nil
    self.newsPhoto.image = nil
    }
    
    
}
