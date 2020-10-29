//
//  HistoryCell.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    //MARK: Properties
   @IBOutlet weak var searchedString: UILabel!
    
    //MARK: Configure cell
    func configureCell(text: String?) {
        searchedString.text = text
    }

}
