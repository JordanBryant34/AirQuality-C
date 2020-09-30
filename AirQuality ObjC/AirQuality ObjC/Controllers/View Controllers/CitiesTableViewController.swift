//
//  CitiesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    var cities: [String] = []
    
    var state: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCities()
    }
    
    private func fetchCities() {
        guard let state = state else { return }
        guard let country = country else { return }
        
        JDBCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            guard let cities = cities else { return }
            
            self.cities = cities
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCellId")!
        
        cell.textLabel?.text = cities[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            guard let country = country, let state = state else { return }
            
            let city = cities[selectedIndexPath.row]
            detailVC.city = city
            detailVC.state = state
            detailVC.country = country
        }
    }
}
