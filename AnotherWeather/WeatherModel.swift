//
//  WeatherModel.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 16.12.2021.
//

import Foundation

struct WeatherModel {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.1f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "дождь с грозой"
        case 300...321: return "дождь"
        case 500...504: return "зонт"
        case 511: return "снег"
        case 520...531: return "дождь"
        case 600...622: return "снег"
        case 701...781: return "туман"
        case 800: return "солнце"
        case 801...804: return "облачно"
        default: return "облако и солнце"
        }
    }
    
    init?(currentWeatherData: WeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}

