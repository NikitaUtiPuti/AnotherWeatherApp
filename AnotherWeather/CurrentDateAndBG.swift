//
//  CurrentData.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 11.12.2021.
//

import Foundation
import UIKit

class CurrentDateAndBG {

var Currentdata: String!
private let dateFormatter = DateFormatter()
var currentBackGround : UIImage!

func formatData() {
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    dateFormatter.dateStyle = .long
    dateFormatter.locale = Locale(identifier: "ru_RU")
    let dateInFormat = dateFormatter.string(from: Date())
    Currentdata = dateInFormat
}

func switchBG() {
    
    let currentMonth = Calendar.current.component(.month, from: Date())
    var BGarray = [""]
    
    switch currentMonth {
    case 1:  BGarray = ["winter_01", "winter_02", "winter_03"]
    case 2:  BGarray = ["winter_04", "winter_05", "winter_06"]
    case 3:  BGarray = ["spring_01", "spring_02", "spring_03"]
    case 4:  BGarray = ["spring_04", "spring_05", "spring_06"]
    case 5:  BGarray = ["spring_07", "spring_08", "spring_09"]
    case 6:  BGarray = ["summer_01", "summer_02", "summer_03"]
    case 7:  BGarray = ["summer_04", "summer_05", "summer_06"]
    case 8:  BGarray = ["summer_07", "summer_08", "summer_09"]
    case 9:  BGarray = ["autumn_01", "autumn_02", "autumn_03"]
    case 10:  BGarray = ["autumn_04", "autumn_05", "autumn_06"]
    case 11:  BGarray = ["autumn_07", "autumn_08", "autumn_09"]
    case 12:  BGarray = ["winter_07", "winter_08", "winter_09"]
    default: return
        }
    let backGroundName = BGarray.randomElement()
    currentBackGround = UIImage(named: backGroundName!)
    }

}
