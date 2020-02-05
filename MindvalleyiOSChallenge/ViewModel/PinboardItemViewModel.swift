//
//  PinboardItemViewModel.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 29/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import Foundation

class PinboardItemViewModel {
    
    var webservice = WebServices()
    var pinItemDataSource = [PinboardItem]()
    typealias completionHandler = ([PinboardItem]) -> ()

    
    func populateSources(completionHandler: @escaping completionHandler) {
        self.webservice.loadPinItem { [weak self]
            (pinResults) in

            self?.pinItemDataSource += pinResults
            
            completionHandler(pinResults)
        }
    }
    
    func getNumberOfRows() -> Int {
        
        return pinItemDataSource.count 
    }

    
}
