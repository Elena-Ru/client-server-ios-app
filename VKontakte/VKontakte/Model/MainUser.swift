//
//  MainUser.swift
//  VKontakte
//
//  Created by Елена Русских on 06.08.2022.
//

import Foundation

class UserResponse: Decodable {
    let response: [MainUser]
}

class MainUser: Decodable {
    var lastName: String = ""
    var firstName: String = ""

    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
