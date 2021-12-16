//
//  WeatherNetworking.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 16.12.2021.
//

import Foundation
import CoreLocation

class WeatherNetworking {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }

    var onCompletion: ((WeatherModel) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
  fileprivate func performRequest(withURLString urlString: String) {
        guard  let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if  let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
            }
        }
    }
        task.resume()
    }
    
   fileprivate func parseJSON(withData data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {

       let currentWeatherData = try decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = WeatherModel(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
  }
}





