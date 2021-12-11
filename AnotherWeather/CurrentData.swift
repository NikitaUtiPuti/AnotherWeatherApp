//
//  CurrentData.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 11.12.2021.
//

import Foundation


var Currentdata: String!
private let dateFormatter = DateFormatter()

func formatData() {
dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
dateFormatter.dateStyle = .long
dateFormatter.locale = Locale(identifier: "ru_RU")
let dateInFormat = dateFormatter.string(from: Date())
Currentdata = dateInFormat
}
