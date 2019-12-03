//
//  ViewController.swift
//  HolidayApiCall
//
//  Created by Himanshu Chaurasiya on 30/11/19.
//  Copyright © 2019 HPC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var listOfHoliday = [HolidayDetails](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHoliday.count) Holidays found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfHoliday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayTableCell", for: indexPath)
        cell.textLabel?.text = listOfHoliday[indexPath.row].name
        cell.detailTextLabel?.text = listOfHoliday[indexPath.row].date.iso
        return cell
    }
    
    
}

extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search for -> \(searchBar.text ?? "NO DATA")")
        
        guard let text = searchBar.text else {
            return
        }
        
        let request = HolidayRequest(countryCode: text)
        
        request.getHolidays { [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHoliday = holidays
            }
        }
    }
}

