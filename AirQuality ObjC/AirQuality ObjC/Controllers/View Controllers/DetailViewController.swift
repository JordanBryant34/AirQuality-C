//
//  DetailViewController.swift
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateCountryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    var city: String?
    var state: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCityDetails()
    }
    
    private func fetchCityDetails() {
        guard let city = city, let state = state, let country = country else { print("couldnt get all the stuff");return }
        JDBCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            guard let cityDetails = cityDetails else { return }
            
            self.updateViews(with: cityDetails)
        }
    }
    
    private func updateViews(with details: JDBCityAirQuality) {
        
        cityLabel.text = details.city
        stateCountryLabel.text = "\(details.state), \(details.country)"
        
        tempLabel.text = "\(details.weather.temperature) °C"
        humidityLabel.text = "\(details.weather.humidity)%"
        windSpeedLabel.text = "\(details.weather.windSpeed) m/s"
        aqiLabel.text = "\(details.pollution.airQualityIndex)"
        
        let labels = [cityLabel, stateCountryLabel, tempLabel, humidityLabel, windSpeedLabel, aqiLabel]
        
        for label in labels {
            label?.isHidden = false
        }
    }
}
