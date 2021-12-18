//
//  ViewController.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 11.12.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var currentBackground: UIImageView!
    @IBOutlet weak var currentData: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelText: UILabel!
    @IBOutlet weak var searchButtonOut: UIButton!
    @IBOutlet weak var dataDetailButtonOut: UIButton!
    
    var networkWeatherManager = WeatherNetworking()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBAction func searchButtonAct(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
            }
    }
    
    private var currentDataBG = CurrentDateAndBG()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.interfaceUpdate(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
      // Отдельный интерфейс апдейт
        currentDataBG.switchBG()
        currentDataBG.formatData()
        currentData.text = String(describing: currentDataBG.Currentdata!)
        currentBackground.image = currentDataBG.currentBackGround
        
    }

    func interfaceUpdate(weather: WeatherModel) {
        
        let randomColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        DispatchQueue.main.async {
        self.cityNameLabel.text = weather.cityName
        self.temperatureLabel.text = weather.temperatureString
        self.feelTempLabel.text = weather.feelsLikeTemperatureString
        self.weatherIcon.image = UIImage(named: weather.systemIconNameString)
            self.weatherIcon.tintColor = randomColor
            self.temperatureLabel.textColor = randomColor
            self.feelTempLabel.textColor = randomColor
            self.cityNameLabel.textColor = randomColor
            self.currentData.textColor = randomColor
            self.feelText.textColor = randomColor
            self.searchButtonOut.backgroundColor = randomColor
            self.dataDetailButtonOut.tintColor = randomColor
        }
    }
}

//MARK: CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }


}









//Экран с описанием дня (либо праздники либо мотивационные рандомные фразочки)
//Интерфейс второго экрана (через сегвай или класс?)
//Интерфейс третьего экрана
//Создание массива несливающихся цветов
//Прогноз на 4 дня (по нажатию на кнопку) - добавить (alamofire)
//Праздники (детали при нажатии на дату) - добавить (datetime api network manager)
//AC на разрешение доступа к геолокации - добавить +++
//Иконки и лаунчскрин - добавить
//Рефакторинг по архитектуре
//Локализация вводимого названия города
