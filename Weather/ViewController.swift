//
//  ViewController.swift
//  Weather
//
//  Created by Елена Русских on 11.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.loadWeatherData(city: "America/Chicago")
        
    }
    


}

