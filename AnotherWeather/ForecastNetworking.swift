//
//  ForecastNetworking.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 26.12.2021.
//

import Foundation

class ForecastNetworking {

    var onCompletion: ((ForecastData) -> Void)?

    func fetchForecast(city: String) {
        
        let sessionConfig = URLSessionConfiguration.default

        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        guard var URL = URL(string: "https://bestweather.p.rapidapi.com/weather/\(city)") else {return}
        let URLParams = [
            "unitGroup": "uk",
            "location": "\(city)",
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"

        request.addValue("bestweather.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("a50b876faamsha2c52685c5a1accp18008ajsn2bc5be87acf8", forHTTPHeaderField: "x-rapidapi-key")

        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(json)

                    let currentForecast = self.parseJSON(withData: data!)
                    if currentForecast == nil {
                        print("The error!")
                        return
                    }
//                    print(currentForecast as Any)
                    self.onCompletion?(currentForecast!)

                } catch {
                    print(error)
                }

                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")

        }
            else {

                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    fileprivate func parseJSON(withData data: Data) -> ForecastData? {
         let decoder = JSONDecoder()
         do {

        let currentWeatherForecast = try decoder.decode(ForecastData.self, from: data)
//             guard let currentForecast = ForecastModel(currentForecastData: currentWeatherForecast) else {
//                 return nil
//             }
             return currentWeatherForecast
             
         } catch let error as NSError {
             print(error.description)
         }
         return nil
   }

}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {

    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }

}

extension URL {

    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}













































//import Foundation
//
//class ForecastNetworking {
//
//    var onCompletion: ((ForecastModel) -> Void)?
//
//    func fetchForecast() {
//
//        let sessionConfig = URLSessionConfiguration.default
//
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//
//        guard var URL = URL(string: "https://bestweather.p.rapidapi.com/weather/Moscow") else {return}
//        let URLParams = [
//            "unitGroup": "uk",
//            "location": "Moscow",
//        ]
//        URL = URL.appendingQueryParameters(URLParams)
//        var request = URLRequest(url: URL)
//        request.httpMethod = "GET"
//
//        request.addValue("bestweather.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//        request.addValue("a50b876faamsha2c52685c5a1accp18008ajsn2bc5be87acf8", forHTTPHeaderField: "x-rapidapi-key")
//
//        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            if (error == nil) {
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(json)
//
//                    let currentForecast = self.parseJSON(withData: data!)
//                    self.onCompletion?(currentForecast!)
//
//                } catch {
//                    print(error)
//                }
//
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                print("URL Session Task Succeeded: HTTP \(statusCode)")
//
//        }
//            else {
//
//                print("URL Session Task Failed: %@", error!.localizedDescription);
//            }
//        })
//        task.resume()
//        session.finishTasksAndInvalidate()
//    }
//
//
//
//
//
//
//    fileprivate func parseJSON(withData data: Data) -> ForecastModel? {
//         let decoder = JSONDecoder()
//         do {
//
//        let currentWeatherForecast = try decoder.decode(ForecastData.self, from: data)
//             guard let currentForecast = ForecastModel(currentForecastData: currentWeatherForecast) else {
//                 return nil
//             }
//             return currentForecast
//         } catch let error as NSError {
//             print(error.localizedDescription)
//         }
//         return nil
//   }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//protocol URLQueryParameterStringConvertible {
//    var queryParameters: String {get}
//}
//
//extension Dictionary : URLQueryParameterStringConvertible {
//
//    var queryParameters: String {
//        var parts: [String] = []
//        for (key, value) in self {
//            let part = String(format: "%@=%@",
//                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
//                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            parts.append(part as String)
//        }
//        return parts.joined(separator: "&")
//    }
//
//}
//
//extension URL {
//
//    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
//        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
//        return URL(string: URLString)!
//    }
//}
//
//

//import Foundation
//
//class ForecastNetworking {
//
//    var onCompletion: ((ForecastModel) -> Void)?
//
//    func fetchForecast() {
//
//        let sessionConfig = URLSessionConfiguration.default
//
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//
//        guard var URL = URL(string: "https://bestweather.p.rapidapi.com/weather/Moscow") else {return}
//        let URLParams = [
//            "unitGroup": "uk",
//            "location": "Moscow",
//        ]
//        URL = URL.appendingQueryParameters(URLParams)
//        var request = URLRequest(url: URL)
//        request.httpMethod = "GET"
//
//        request.addValue("bestweather.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//        request.addValue("a50b876faamsha2c52685c5a1accp18008ajsn2bc5be87acf8", forHTTPHeaderField: "x-rapidapi-key")
//
//        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            if (error == nil) {
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(json)
//
//                    let currentForecast = self.parseJSON(withData: data!)
//                    self.onCompletion?(currentForecast!)
//
//                } catch {
//                    print(error)
//                }
//
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                print("URL Session Task Succeeded: HTTP \(statusCode)")
//
//        }
//            else {
//
//                print("URL Session Task Failed: %@", error!.localizedDescription);
//            }
//        })
//        task.resume()
//        session.finishTasksAndInvalidate()
//    }
//
//    fileprivate func parseJSON(withData data: Data) -> ForecastModel? {
//         let decoder = JSONDecoder()
//         do {
//
//        let currentWeatherForecast = try decoder.decode(ForecastData.self, from: data)
//             guard let currentForecast = ForecastModel(currentForecastData: currentWeatherForecast) else {
//                 return nil
//             }
//             return currentForecast
//         } catch let error as NSError {
//             print(error.localizedDescription)
//         }
//         return nil
//   }
//
//}
//
//protocol URLQueryParameterStringConvertible {
//    var queryParameters: String {get}
//}
//
//extension Dictionary : URLQueryParameterStringConvertible {
//
//    var queryParameters: String {
//        var parts: [String] = []
//        for (key, value) in self {
//            let part = String(format: "%@=%@",
//                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
//                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            parts.append(part as String)
//        }
//        return parts.joined(separator: "&")
//    }
//
//}
//
//extension URL {
//
//    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
//        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
//        return URL(string: URLString)!
//    }
//}
