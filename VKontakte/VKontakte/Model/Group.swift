//
//  GroupR.swift
//  VKontakte
//
//  Created by Елена Русских on 09.08.2022.
//

import Foundation

class GroupResponse: Decodable {
    let response: Groups
}

class Groups: Decodable{
    let items: [Group]
}

class Group: Decodable{
    var name: String = ""
    var photoGroup: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case photoGroup = "photo_50"
    }
}
