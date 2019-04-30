//
//  CurrentWeather.swift
//  WeatherJSON
//
//  Created by Nikita Gura on 26.11.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import Foundation
final class CurrentWeather
{
    public let temp: Double?
    public let pressuer: Double?
    public let humidity: Double?
//    private let tem_min: Int?
//    private let temp_max: Int?
    
    private struct MainKey{
        static let temp = "temp"
        static let pressure = "pressure"
        static let humidity = "humidity"
        static let temp_min = "temp_min"
        static let temp_max = "temp_max"
    }
    
    init(weatherDictionary: [String: Any]){
       
        if let t = weatherDictionary[MainKey.temp] as? Double {
            self.temp = t - 273.15
        }else {
            self.temp = nil
        }
        pressuer = weatherDictionary[MainKey.pressure] as? Double
        humidity = weatherDictionary[MainKey.humidity] as? Double
    }
    
}


//"main": {
//    "temp": 273.15,
//    "pressure": 1013,
//    "humidity": 91,
//    "temp_min": 273.15,
//    "temp_max": 273.15
//}
