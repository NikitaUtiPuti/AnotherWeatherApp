//
//  ForecastViewController.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 28.12.2021.
//

import UIKit

class ForecastViewController: UITableViewController {

    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    var networkForecastManager = ForecastNetworking()
    private var forecasts = [CurrentConditions]()
    var city = ""
    var formatter = ForecastFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDayForecasts()
        
    }
    
    func fetchDayForecasts() {
        
        networkForecastManager.fetchForecast(city: city)
        
        delay(5) {
            if self.forecasts.count == 0 {
                self.navigationItem.title = "Ошибка получения данных"
                return
            }
        }
    
        networkForecastManager.onCompletion = { [weak self] currentForecast in
            guard let self = self else { return }
        
            self.forecasts = currentForecast.days
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                }
        }
    }
    
    private func configureCell(cell: ForecastCell, for indexpath: IndexPath) {
        
        let forecast = forecasts[indexpath.row]
        
        cell.datetimeLabel.text = forecast.datetime
        cell.tempLabel.text = "\(forecast.temp)"
        cell.iconImageView.image = UIImage(named: "")
        
        formatter.format(cell: cell,forecast: forecast)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
}

fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
        closure()
    }

}
