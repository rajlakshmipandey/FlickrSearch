//
//  HistoryView.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

class HistoryView: UIViewController, AlertProtocol {
    
    //MARK: Properties
    var viewModel: HistoryViewModel?
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getDataFromDisk()
    }
    
}


// MARK: UITableView Delegates
extension HistoryView: UITableViewDelegate {
    
    // Method to set row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.getHeightForRow() ?? 0.0
    }
}


// MARK: UITableView DataSource
extension HistoryView: UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getNumberOfSections() ?? 0
    }
    
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection() ?? 0
    }
    
    
    // Configure Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.history) as? HistoryCell  else {    return UITableViewCell() }
        cell.configureCell(text: viewModel?.getSearchedString(row: indexPath.row))
        return cell
    }
}


//MARK: Update View
extension HistoryView : HistoryResultProtocol {
    
    // Method to show data
    func showResult() {
        self.tableView.reloadData()
    }
    
    // Method to show error
    func showError(error: NetworkError) {
        showPopup(title: ErrorMsg.errorTitle, message: error.errorDescription, okTitle: ErrorMsg.ok, cancelTitle: nil, response: nil)
    }
    
}
