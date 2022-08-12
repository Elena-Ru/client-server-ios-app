//
//  Weather.swift
//  Weather
//
//  Created by Елена Русских on 11.08.2022.
//

import Foundation


// MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    
    
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var current: Current?
    var minutely: [Minutely]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely
    }
}

// MARK: - Current
struct Current: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //Преобразовать даты из формата Timestamp в Date.
        let timeStamp = try values.decode(Int.self, forKey: .dt)
        self.dt = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        
        self.sunrise = try values.decode(Int.self, forKey: .sunrise)
        self.sunset = try values.decode(Int.self, forKey: .sunset)
        
        //Перевести градусы в систему изменения Цельсия.
        let tempK = try values.decode(Double.self, forKey: .temp)
        self.temp = tempK - 273.15
        
        self.feelsLike = try values.decode(Double.self, forKey: .feelsLike)
        self.pressure = try values.decode(Int.self, forKey: .pressure)
        self.humidity = try values.decode(Int.self, forKey: .humidity)
        self.dewPoint = try values.decode(Double.self, forKey: .dewPoint)
        self.uvi = try values.decode(Double.self, forKey: .uvi)
        self.clouds = try values.decode(Int.self, forKey: .clouds)
        self.visibility = try values.decode(Int.self, forKey: .visibility)
        self.windSpeed = try values.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try values.decode(Int.self, forKey: .windDeg)
        self.windGust = try values.decode(Double.self, forKey: .windGust)
        self.weather = try values.decode([Weather].self, forKey: .weather)
    }
    
    
    var dt: Date?
    var sunrise, sunset: Int?
    var temp, feelsLike: Double?
    var pressure, humidity: Int?
    var dewPoint, uvi: Double?
    var clouds, visibility: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var windGust: Double?
    var weather: [Weather]?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
}

// MARK: - Weather
struct Weather: Decodable {
    var id: Int?
    var main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Minutely
struct Minutely: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //Преобразовать даты из формата Timestamp в Date.
        let timeStamp = try values.decode(Int.self, forKey: .dt)
        self.dt = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        
        self.precipitation = try values.decode(Int.self, forKey: .precipitation)
        
    }
    var dt: Date?
    var precipitation: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt, precipitation
    }
    
}
