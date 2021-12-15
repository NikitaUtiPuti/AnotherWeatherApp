//
//  ViewController.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 11.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentBackground: UIImageView!
    @IBOutlet weak var currentData: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelText: UILabel!
    @IBOutlet weak var searchButtonOut: UIButton!
    
    @IBAction func searchButtonAct(_ sender: UIButton) {
        
    }
    
    
    private var currentDataBG = CurrentDateAndBG()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        interfaceUpdate()
        currentDataBG.switchBG()
        currentDataBG.formatData()
        currentData.text = String(describing: currentDataBG.Currentdata!)
        currentBackground.image = currentDataBG.currentBackGround
        
    }

    func interfaceUpdate() {
        
        
        
//        let logo = UIImage(named: "солнце")
//        let imageView = UIImageView(image: logo)
//        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = UIColor.white
//        self.weatherIcon = imageView
//
//        weatherIcon.image = imageView.image!.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = UIColor.white
//        self.weatherIcon = imageView
        
        let randomColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        weatherIcon.tintColor = randomColor
        temperatureLabel.textColor = randomColor
        feelTempLabel.textColor = randomColor
        cityNameLabel.textColor = randomColor
        currentData.textColor = randomColor
        feelText.textColor = randomColor
        searchButtonOut.backgroundColor = randomColor
    }
    

}

