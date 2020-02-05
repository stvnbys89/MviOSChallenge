//
//  PinboardCell.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 29/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit
import Foundation

class PinboardCell: UICollectionViewCell {
    
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var pinTitle: UILabel!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    private let cache = Cache<PinboardItem.ID, UIImage>()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pinTitle.text = ""
        pinImage.image = UIImage(named: "img_placeholder.png")
    }
    
    var pinboardItem: PinboardItem? {
        
        didSet {
            if let pinboardItem = pinboardItem {
                pinTitle.text = pinboardItem.user?.name
                loadPinImage()
            }
        }
    }
    
    func loadPinImage() {
        
        if let pinItemURL = pinboardItem?.urls?.small! {
            
            if let cacheValue = self.cache.cacheValue(forKey:pinItemURL){
                
                self.pinImage.image = cacheValue
                self.loadIndicator.isHidden = true
                
            }else{
                
                self.loadIndicator.startAnimating()
                URLSession.shared.dataTask(with: URL(string: pinItemURL)!) { (data: Data?, response: URLResponse?, error: Error?) in
                    if let error = error {
                        
                        print("load image error \(error)")
                         return
                     }
                    if let image =  try? UIImage(data: Data(contentsOf: URL(string: pinItemURL)!)){
                        self.cache.insertCache(image, forKey: pinItemURL)
                        DispatchQueue.main.async {
                            self.pinImage.image = image
                            self.loadIndicator.isHidden = true
                        }
                    }
                    
                }.resume()
            }

        }
    }
    
    
}
