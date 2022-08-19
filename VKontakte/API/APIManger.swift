//
//  APIManger.swift
//  VKontakte
//
//  Created by Елена Русских on 04.08.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import SDWebImage




class APIManager{
    
    let baseUrl = "https://api.vk.com"
    let clientId = "8233581" //id_приложения
 
    
    func getFriendsList(token: String, id: Int, completion: @escaping ([User]) -> Void){
        
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "order": "name",// сортировка по имени
           "fields": "photo_100",
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let users = try? JSONDecoder().decode( FriendsResponse.self, from: data).response.items
            self.saveData(users!)
            completion(users!)
        }
    }
    
    
    func getUserPhotos(token: String, idFriend: Int, completion: @escaping ([Photo]) -> Void){
        
        let path = "/method/photos.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "owner_id": idFriend,
            "album_id": "profile",
            "extended": "likes",
            "photo_sizes": "0",
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let photos = try? JSONDecoder().decode( FriendPhotoResponse.self, from: data).response.items
            
            self.saveData(photos!)
            
            completion(photos!)
        }
    }
    
    
    
    func getUserGroups(token: String, id: Int, completion: @escaping ([Group]) -> Void){
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "extended": "1",
            "fields": "name, photo_50",  // название и фото группы
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let groups = try? JSONDecoder().decode( GroupResponse.self, from: data).response.items
            
            self.saveData(groups!)
            completion(groups!)
        }
    }
    
    
    //Поиск группы по тексту
    func getUserGroupsSearch(token: String, text: String, completion: @escaping ([Group]) -> Void){
        
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "q": text,
            "type": "group",
            "count": "20",
            "sort": 6,
            "access_token" : token,
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let groups = try? JSONDecoder().decode( GroupResponse.self, from: data).response.items
            
            self.saveData(groups!)
            
            completion(groups!)
        }
    }
    
    
    
    func getGroupsAll(token: String, completion: @escaping ([Group]) -> Void){
        
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "q": "group",
            "type": "group",
            "count": "100",
            "sort": 6,
            "access_token" : token,
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let groups = try? JSONDecoder().decode( GroupResponse.self, from: data).response.items
            
            self.saveData(groups!)
            
            completion(groups!)
        }
    }
    
    
    func getUserInfo(token: String, id: Int, completion: @escaping ([MainUser]) -> Void){
        
        let path = "/method/users.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "v": "5.131"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}

            let user = try? JSONDecoder().decode( UserResponse.self, from: data).response
            completion(user!)
        }
    }
    
    
    
    func getNews(token: String, id: Int, completion: @escaping ([NewsItem]) -> Void){
        
        let path = "/method/newsfeed.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "filters": "photo, post",
            "source_ids": "friends",
            "v": "5.131"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value  else { return}
            let news = try? JSONDecoder().decode( NewsResponse.self, from: data).response.items
            
            self.saveData(news!)
            completion(news!)
        }
    }
    
    
    
    //_______________REALM

  private  func saveData  <T: Object>(_ sData: [T]){
            let realm = try! Realm()
      do{
      realm.beginWrite()
      realm.add(sData)
      try realm.commitWrite()
      } catch{
          print(error)
      }
    }
    
    
    func readRealm <T: Object> (_ sData: [T]){
        let realm = try! Realm()
        
        let data = realm.objects(T.self)
        
        print(data)
    }
    
}
