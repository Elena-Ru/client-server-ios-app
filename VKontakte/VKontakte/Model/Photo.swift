//
//  Photo.swift
//  VKontakte
//
//  Created by Елена Русских on 08.08.2022.
//

import Foundation


class FriendPhotoResponse: Decodable {
    let response: FriendPhotos
}


class FriendPhotos: Decodable {
    let items: [Photo]
}

class Photo: Decodable {

    var id: Int = 0
    var url: String = ""
    var count: Int = 0
    var userLikes: Int = 0
    
    enum CodingKeys: String, CodingKey{
        case id
        case likes
        case sizes
    }
  
    enum SizeKeys: String, CodingKey{
        case url
    }
    
    enum LikesKeys: String, CodingKey{
        case count
        case userLikes = "user_likes"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        var sizeValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizeValue = try sizeValues.nestedContainer(keyedBy: SizeKeys.self)
        self.url = try firstSizeValue.decode(String.self, forKey: .url)
        let likeValues = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        self.count = try likeValues.decode(Int.self, forKey: .count)
        self.userLikes = try likeValues.decode(Int.self, forKey: .userLikes)
    }
}

