//
//  DayOrNight.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 18.01.2022.
//

import UIKit
 
class DayOrNight {
    
    let calendar = Calendar.current
    
    func backgroundSwitch(image: UIImageView, title: UINavigationBar?) {
        
        if calendar.component(.hour, from: Date()) <= 6 {
            image.image = UIImage(named: "night")

        } else if calendar.component(.hour, from: Date()) >= 19 {
            image.image = UIImage(named: "night")

        } else {
                image.image = UIImage(named: "day")
            if title != nil {
                title!.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            }
        }
    }
    
    func cellSwitchTextColor(cell: ForecastCell, image: UIImageView) {
        if image.image == UIImage(named: "day") {
        cell.datetimeLabel.textColor = .black
        cell.iconImageView.tintColor = .black
        cell.tempLabel.textColor = .black
        } else {
            cell.datetimeLabel.textColor = .white
            cell.iconImageView.tintColor = .white
            cell.tempLabel.textColor = .white
        }
    }

}
