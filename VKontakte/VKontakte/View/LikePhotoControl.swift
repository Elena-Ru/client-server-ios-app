//
//  LikePhotoControl.swift
//  VKontakte
//
//  Created by Елена Русских on 27.06.2022.
//





import UIKit

class LikePhotoControl: UIControl {

    var photoUser: PhotoUser!
    let likeCount  = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let likeButton = UIButton(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
    let likePhoto: UIImage? = nil




    @objc func  likeButtonPressed(sender:UIButton){

        if photoUser.isLike {

           photoUser.likeCount -= 1
            likeCount.textColor = .systemBlue
            animateLikeCountAppear()
            } else {

                photoUser.likeCount += 1
                likeCount.textColor = .systemRed
                animateLikeCountAppear()
                rotateLikeCount()
                gruopanimation()
               }
        photoUser.isLike.toggle()
        setLikeButton(isLike: photoUser.isLike)
    }



    func animateLikeCountAppear(){
        UIView.transition(with: likeCount,
                          duration: 0.5,
                          options: .transitionFlipFromRight) { [self] in
            likeCount.text = String(photoUser.likeCount)
    }
    }

    func rotateLikeCount() {
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = 1
            likeCount.layer.add(rotation, forKey: "rotationAnimation")
        }

    func gruopanimation(){
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.duration = 0.5

        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1.0
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = .pi/10.0
        rotate.toValue = 0.0
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.0
        fade.toValue = 1.0

        groupAnimation.animations = [scaleDown, rotate,fade]
        likeButton.layer.add(groupAnimation, forKey: nil)
    }

    func setPhotoUser(photo : PhotoUser, cellIndex: Int) {
        photoUser = photo
        likeCount.text = String(photo.likeCount)
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        //self.isUserInteractionEnabled = false
        likeButton.isUserInteractionEnabled = true
        likeCount.isUserInteractionEnabled = false
        setLikeButton(isLike: photo.isLike)

        likeCount.textColor = photo.isLike ? .systemRed : .systemBlue

       // photoUser.photo.isUserInteractionEnabled
        //photoUser.photo.isUserInteractionEnabled =
        addSubview(likeButton)
        addSubview(likeCount)
    }

    func setLikeButton(isLike: Bool) {
        if isLike{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        }else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .lightGray
        }
    }
}
