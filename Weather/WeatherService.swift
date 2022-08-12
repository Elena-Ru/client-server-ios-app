//
//  WeatherService.swift
//  Weather
//
//  Created by Елена Русских on 11.08.2022.
//

import Foundation
import Alamofire

class WeatherService{
    
    let baseUrl = "https://api.openweathermap.org"
    
    func loadWeatherData(city: String){
        
        let path = "/data/2.5/onecall"
        let apiKey = "dcdbe7e9d50c31d96f2ed2b783dcae49"
        
        let parameters: Parameters = [
        
            "lat" : "33.44",
            "lon" : "-94.04",
            "exclude" : "hourly, daily",
            "appid" : apiKey
        ]
        
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return}
            
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data)
            print(weather.current?.temp)
            print(weather.current?.dt)
            print(weather.minutely![2].dt)
        }
        
    }
}
