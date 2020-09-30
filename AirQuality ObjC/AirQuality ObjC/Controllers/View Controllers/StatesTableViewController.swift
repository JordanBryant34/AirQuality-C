//
//  StatesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {
    
    var states: [String] = []
    
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStates()
    }
    
    private func fetchStates() {
        guard let country = country else { return }
        
        JDBCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            guard let states = states else { return }
            
            self.states = states
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCellId")!
        
        cell.textLabel?.text = states[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let citiesVC = segue.destination as? CitiesTableViewController else { return }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            guard let country = country else { return }
            
            let state = states[selectedIndexPath.row]
            print("State Here: \(state)")
            citiesVC.state = state
            citiesVC.country = country
        }
    }
}
