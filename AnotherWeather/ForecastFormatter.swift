//
//  ForecastFormatter.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 16.01.2022.
//

import Foundation
import UIKit

class ForecastFormatter {
    
    func format(cell: ForecastCell, forecast: CurrentConditions) {
        
        //ICON FORMATING +
        formatIcon(cell: cell, forecast: forecast)
        
        //DATA FORMATING +
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = cell.datetimeLabel.text

        let date = dateFormatter.date(from: formattedDate!)
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateInFormat = dateFormatter.string(from: date!)
        cell.datetimeLabel.text = dateInFormat
        
        //SUNRISE AND SUNSET TIME FORMATTING
        
        
        
        
        //TEMP FORMATING
        
    }
    
    private func formatIcon(cell: ForecastCell, forecast: CurrentConditions) {
        
        var iconName: String {
            switch forecast.icon {
            case .clearDay:
                return "солнце"
            case .clearNight:
                return "солнце"
            case .cloudy:
                return "облачно"
            case .fog:
                return "туман"
            case .partlyCloudyDay:
                return "облако и солнце"
            case .partlyCloudyNight:
                return "облако и солнце"
            case .rain:
                return "дождь"
            case .snow:
                return "снег"
            case .wind:
                return "ветренно"
            case .unknown:
                return "гроза"
            }
        }
        cell.iconImageView.image = UIImage(named: iconName)
    }
}
