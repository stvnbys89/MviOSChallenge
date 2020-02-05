//
//  WebServices.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 29/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import Foundation
import UIKit

class WebServices {
    
    private let pinURL = URL(string: "http://pastebin.com/raw/wgkJgazE")!
    typealias completionBlock = ([PinboardItem]) -> ()
    private let cache = Cache<PinboardItem.ID, [PinboardItem]>()
    
    func loadPinItem(completionBlock: @escaping completionBlock) {
        
        if let cacheValue = self.cache.cacheValue(forKey:"pinItemCacheKey"){
            
            let pinboardArray = cacheValue
            completionBlock(pinboardArray)
            
        }else{
            URLSession.shared.dataTask(with: self.pinURL) { (data, response
                , error) in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    do {
                        
                        let decoder = JSONDecoder()
                        let pinboardArray = try decoder.decode([PinboardItem].self, from: data)
                        self.cache.insertCache(pinboardArray, forKey: "pinItemCacheKey")
                        completionBlock(pinboardArray)
                        
                    } catch let err {
                        print("Error :", err)
                    }
                }
            }.resume()
        }
        
        
//        URLSession.shared.dataTask(with: pinURL) { (data, response
//            , error) in
//            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//
//                    let decoder = JSONDecoder()
//                    let pinboardArray = try decoder.decode([PinboardItem].self, from: data)
//                    completionBlock(pinboardArray)
//
//                } catch let err {
//                    print("Error :", err)
//                }
//            }
//        }.resume()
        
    }

}
