//
//  DayDetailsVC.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 20.12.2021.
//

import UIKit

class DayDetailsVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    let calendar = Calendar.current
    let interfaceChanger = DayOrNight()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateDayDetails), userInfo: nil, repeats: true)
        
        updateDayDetails()
    }

    @objc func updateDayDetails() {
        
        let dateFormatter = DateFormatter()
        let date = Date()
        
        interfaceChange()
    
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let monthStr = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "EEEE"
        
        let weekdayStr = dateFormatter.string(from: date)
        
        var second: String
        var minute: String
        var hour: String
        
        if calendar.component(.second, from: date) <= 9 {
            second = "0\(String(calendar.component(.second, from: date)))"
        } else {
            second = "\(String(calendar.component(.second, from: date)))"
        }
        
        if calendar.component(.minute, from: date) <= 9 {
            minute = "0\(String(calendar.component(.minute, from: date)))"
        } else {
            minute = "\(String(calendar.component(.minute, from: date)))"
        }
        
        if calendar.component(.hour, from: date) <= 9 {
            hour = "0\(String(calendar.component(.hour, from: date)))"
        } else {
            hour = "\(String(calendar.component(.hour, from: date)))"
        }
    
        let time = "\(hour) : \(minute) : \(second)"
        
        let day = Day(day: String(calendar.component(.day, from: date)),
                      month: monthStr,
                      weekday: weekdayStr.capitalized,
                      time: time,
                      year: String(calendar.component(.year, from: date)))
        
            self.dayLabel.text = day.day
            self.monthLabel.text = day.month
            self.weekDayLabel.text = day.weekday
            self.timeLabel.text = day.time
            self.yearLabel.text = day.year
    }
    
    func interfaceChange() {
        
        var color = UIColor.white
        
        func textColorChange() {
        dayLabel.textColor = color
        monthLabel.textColor = color
        weekDayLabel.textColor = color
        timeLabel.textColor = color
        yearLabel.textColor = color
        }
        
        interfaceChanger.backgroundSwitch(image: backgroundImage, title: navigationController?.navigationBar)
        if backgroundImage == UIImage(named: "night") {
            color = .white
        } else {
            color = .black
        }
        
        textColorChange()
        
        
//        if calendar.component(.hour, from: Date()) <= 6 {
//            backgroundImage.image = UIImage(named: "night")
//            color = UIColor.white
//            textColorChange()
//        } else if calendar.component(.hour, from: Date()) >= 19 {
//            backgroundImage.image = UIImage(named: "night")
//            color = UIColor.white
//            textColorChange()
//        } else {
//            backgroundImage.image = UIImage(named: "day")
//            color = UIColor.black
//            textColorChange()
//        }
    }
}
