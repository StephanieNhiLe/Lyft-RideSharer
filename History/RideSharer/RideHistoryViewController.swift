//
//  RideHistoryViewController.swift
//  RideSharer
//
//

import UIKit


class RideHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    DataSource
    let rideHistory = [("Driver: Joe, 12/29/2021", "$26.50"),
                       ("Driver: Sandra, 01/03/2022", "$13.10"),
                       ("Driver: Hank, 01/11/2022", "$16.20"),
                       ("Driver: Michelle, 01/19/2022", "$8.50")]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RideHistoryCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideHistoryCell", for: indexPath)
        
//        Error: rideHistory is a tuple containing two strings, which couldn't be applied directly to the textLabel property for a single String
//        cell.textLabel?.text = self.rideHistory[indexPath.row]
        
        let rideInfo = rideHistory[indexPath.row]
        cell.textLabel?.text = rideInfo.0 // Access first element (driver and date)
        cell.detailTextLabel?.text = rideInfo.1 // Access second element (price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // Get the price for the selected ride
            let selectedRide = rideHistory[indexPath.row]
            let price = selectedRide.1 // Access the second element (price)

            // Create and configure an alert box
            let alert = UIAlertController(title: "Price", message: price, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)) //one button
            present(alert, animated: true, completion: nil)
    }
}



    

