//
//  Object.swift
//  WeatherParser
//
//  Created by macbook on 26.01.2021.
//

import Foundation


// MARK: - Welcome
struct Welcome: Codable {
    
    let weather: [Weather]
   
    let main: Main
    
    let name: String
    
    
   
}



// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin: Double
    let tempMax, pressure, humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}





// MARK: - Weather
struct Weather: Codable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case  main
        case weatherDescription = "description"
    }
}




