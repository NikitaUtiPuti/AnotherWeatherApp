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
    @IBOutlet weak var forecastButtonOut: UIButton!
    
    var networkWeatherManager = WeatherNetworking()
    var networkForecastManager = ForecastNetworking()
    
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
        
        let colorArray = ["#FF7700", "#FF0500", "#FF00EB", "#0238FF", "#00FDFF", "#48FF1D"]
        
        let randomColor = UIColor(hexString: colorArray.randomElement()!)
        
//        let randomColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
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
            self.forecastButtonOut.tintColor = randomColor
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ForecastVC" {
            let NavigationController = segue.destination as! UINavigationController
            let fvc = NavigationController.topViewController as! ForecastViewController
            if let city = self.cityNameLabel.text {
                fvc.city = city
            } else { return }
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

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let chars = Array(hexString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}








//Экран с деталями дня ++++++++++++++++++++
//будет две картинки дневная и ночная они будут меняться (на экране с инфой о дне) ++++++++++++++++++++
//Интерфейс второго экрана ++++++++++++++++++++
//Интерфейс третьего экрана 
//Создание массива несливающихся цветов ++++++++++++++++++++
//Прогноз на 15 дней (по нажатию на кнопку) - добавить ++++++++++++++++++++
//AC на разрешение доступа к геолокации - добавить ++++++++++++++++++++
//Иконки и лаунчскрин - добавить ++++++++++++++++
//Рефакторинг по архитектуре
//Локализация вводимого названия города
//Рефакторинг отображения дня на экарне с деталями 
//Интерфейс к общему виду (шрифты)
//Иконки в прогнозе и тип запроса в зависимости от города +++++++++++++++
//Проверка ошибок получения данных отедльным классом
//Менеджер принимающий значения из джсон, возвращающий названия иконок и форматированное время восхода, заката и даты
//Попробовать форматировать дату через дэйт форматтер ++++++++++++++
