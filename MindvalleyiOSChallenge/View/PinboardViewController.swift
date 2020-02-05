//
//  ViewController.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

class PinboardViewController: UIViewController {

    @IBOutlet weak var pinboardCollectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    var pinboardItemViewModel = PinboardItemViewModel()
    var isLoading:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = pinboardCollectionView?.collectionViewLayout as? PinboardCustomLayout {
            layout.delegate = self
            layout.invalidateLayout()
        }
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action:#selector(self.handleRefresh), for: UIControl.Event.valueChanged)
        self.pinboardCollectionView?.addSubview(refreshControl)
        
        loadPinboardItem()
        
    }
    
    func loadPinboardItem(){
        
        pinboardItemViewModel.populateSources { (pinData) in

            DispatchQueue.main.async {
                if (self.refreshControl.isRefreshing)
                {
                    self.refreshControl.endRefreshing()
                }
                
                self.isLoading = false
                self.pinboardCollectionView.reloadData()
            }
            
        }
    }
    
    @objc func handleRefresh(sender:AnyObject) {
        pinboardItemViewModel.pinItemDataSource.removeAll()
        loadPinboardItem()
    }


}

extension PinboardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pinboardItemViewModel.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinboardCell", for: indexPath) as? PinboardCell
            else {
                   return UICollectionViewCell()
            }
        
        cell.pinboardItem = pinboardItemViewModel.pinItemDataSource[indexPath.item]
        
        
        return cell
    }
    
    
}

extension PinboardViewController: PinboardLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return getReducedHeightForItem(at: indexPath.row) + 80
    }
    
    func getReducedHeightForItem(at index: Int) -> CGFloat {
        
        let cellWidth = pinboardCollectionView.contentSize.width / 2
        let width: CGFloat =  CGFloat(integerLiteral: pinboardItemViewModel.pinItemDataSource[index].width ?? 0)
        let height: CGFloat = CGFloat(integerLiteral: pinboardItemViewModel.pinItemDataSource[index].height ?? 0)
        
        let factor = width / cellWidth
        let reducedHeight = height / factor
        
        return reducedHeight
    }
}

extension PinboardViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            
            //< 50 = testing purpose for pagination
            if(isLoading == false && pinboardItemViewModel.getNumberOfRows() < 50){
                isLoading = true
                loadPinboardItem()
            }
        }
        
    }
}

