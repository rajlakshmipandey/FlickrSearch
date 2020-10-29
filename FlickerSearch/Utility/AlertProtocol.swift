//
//  AlertProtocol.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/29/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation
import UIKit

// MARK: Alert response enums - Ok/Cancel

enum response {
    case Ok
    case Cancel
}



// MARK: Alert Protocol

protocol AlertProtocol {
    func showPopup(title :String?, message :String?, okTitle :String?, cancelTitle :String?, response :((_ dismissedWithCancel: response) -> Void)?)
}

extension AlertProtocol where Self: UIViewController{
    
    // Protocol method to build popup
    // Parameter: title of the alert popup, message and button titles
    func showPopup(title :String?, message :String?, okTitle :String?, cancelTitle :String?, response :((_ dismissedWithButton: response) -> Void)?) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default, handler: {(action) in
            alertController.dismiss(animated: true, completion: nil)
            if let okResponse = response {
                okResponse(.Ok)
            }
        })
        alertController.addAction(ok)
        
        if let cancelButtonTitle = cancelTitle {
            let cancel = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: {(cancel) in
                alertController.dismiss(animated: true, completion: nil)
                if let cancelResponse = response {
                    cancelResponse(.Cancel)
                }
            })
            alertController.addAction(cancel)
        }
        
        // Show alert popup
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
