//
//  CountriesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountries()
    }
    
    private func fetchCountries() {
        JDBCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCellId")!
        
        cell.textLabel?.text = countries[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let statesVC = segue.destination as? StatesTableViewController else { return }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            
            let country = countries[selectedIndexPath.row]
            
            statesVC.country = country
        }
    }
}
