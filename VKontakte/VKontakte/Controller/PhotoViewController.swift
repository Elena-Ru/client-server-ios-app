//
//  PhotoViewController.swift
//  VKontakte
//
//  Created by Елена Русских on 20.06.2022.
//

import UIKit

class PhotoViewController: UICollectionViewController {
    
    var friend: User? // из FriendsResponse
    var friendID: Int? // для запроса фоток друга
    var friendPhotos: [Photo] = [Photo]() // массив фоток
    let session = Session.shared
    let apiManager = APIManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
  
       collectionView.dataSource = self
        collectionView.delegate = self

        apiManager.getUserPhotos(token: session.token, idFriend: friendID!){ [weak self] items  in
            self?.friendPhotos = items
            
            self?.collectionView.reloadData()

        }
     
        collectionView.backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 36/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
       
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoViewCell
      
        //индекс ячейки
            cell.photoIndex = indexPath.item
        
        //фото из запроса
        let url = URL(string: friendPhotos[indexPath.row].url)
        if let data = try? Data(contentsOf: url!) {
            cell.FriendPhoto.image = UIImage(data: data)
        }
        cell.FriendPhoto.contentMode = .scaleAspectFill
        
        //сюда передать количество лайков и поставил ли лайк текущий пользователь
        cell.ILikeControl.setPhotoUser(isUserLike: friendPhotos[indexPath.item].userLikes,
                                       likesCount:  friendPhotos[indexPath.item].count,
                                       cellIndex:  cell.photoIndex)
     
        
        //Анимация
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime()
        groupAnimation.duration = 1.5

        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 0.2
        scaleDown.toValue = 1.0
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.0
        fade.toValue = 1.0

        groupAnimation.animations = [scaleDown,fade]
        cell.FriendPhoto.layer.add(groupAnimation, forKey: nil)
        
            return cell
        }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newController = PhotoGalleryViewController()
        newController.modalPresentationStyle = .currentContext
        newController.friendPhotos = friendPhotos
        newController.photoIndex = indexPath.item
        newController.view.backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 36/255, alpha: 1)
        self.navigationController?.pushViewController(newController, animated: true)

    }
    
}

