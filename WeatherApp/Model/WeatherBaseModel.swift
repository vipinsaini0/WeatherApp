//
//  WeatherBaseModel.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//

import Foundation 

    // MARK: - WeatherBaseModel
struct WeatherBaseModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [WeatherList]?
    let city: WeatherCity?
}

    // MARK: - WeatherCity
struct WeatherCity: Codable {
    let id: Int?
    let name: String?
    let coord: WeatherCoord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

    // MARK: - WeatherCoord
struct WeatherCoord: Codable {
    let lat, lon: Double?
}

    // MARK: - WeatherList
struct WeatherList: Codable {
    let dt: Int
    let main: WeatherMain?
    let weather: [Weather]?
    let clouds: WeatherClouds?
    let wind: WeatherWind?
    let visibility: Int?
    let pop: Double?
    let sys: WeatherSys?
    let dtTxt: String?
    let rain: WeatherRain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

    // MARK: - WeatherClouds
struct WeatherClouds: Codable {
    let all: Int?
}

    // MARK: - WeatherMain
struct WeatherMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

    // MARK: - WeatherRain
struct WeatherRain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

    // MARK: - WeatherSys
struct WeatherSys: Codable {
    let pod: String?
}

    // MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

    // MARK: - WeatherWind
struct WeatherWind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
