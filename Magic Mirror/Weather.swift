//
//  Weather.swift
//  Magic Mirror
//
//  Created by Hiltunen on 31/10/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Weather {
    static let shared = Weather()
    
    let apiKey = "026305de7c21b8d0a42d6274bb5025b7"

    func getCurrentWeather(lat:Double , lon:Double) {
        // Get weather data from Open Weather Map API and display data in the view
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON {
            response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let weather = jsonResponse["weather"].array![0]
                let temp = jsonResponse["main"]
                let iconName = weather["icon"].stringValue
                
                // change image
                //self.weatherIcon.image = UIImage( named: iconName )
                //self.condition.text = jsonResponse["main"].stringValue
                //self.temperature.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
            }
        }
    }
    
    // Not actually used anywhere yet
    // Should get weather forecast for next 5 days
    func getWeatherForecast(lat:Double, lon:Double) {
        // Get weather data from Open Weather Map API and display data in the view
        //Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON {

        //}
    }
}
