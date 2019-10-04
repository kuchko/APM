//
//  MenuCollectionViewCell.swift
//  APM
//
//  Created by Oleksii KUCHKO on 6/27/19.
//  Copyright © 2019 Oleksii KUCHKO. All rights reserved.
//

import UIKit




class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var alarmstring : String = ""
    
    
    var menu: Menu? {
        didSet {
            
            //sync load
//            if let image = menu?.imageName {
//
//                let url = URL(string: image)
//                let data = try? Data(contentsOf: url!)
//                imageView.image = UIImage(data: data!)
//
//            }
      
            // Async
//                if let image = menu?.imageName {

                    
//                let url = URL(string: image)
//                DispatchQueue.global().async {
//                    if let data = try? Data(contentsOf: url!) {
//                        DispatchQueue.main.async {
//                            self.imageView.image = UIImage(data: data)
//                            self.activityIndicator.stopAnimating()
//                            netActivity -= 1
//                        }
//                    }
//                    else {
//                        self.alarmstring = image
//                        DispatchQueue.main.async {
//                            if self.activityIndicator.isAnimating {
//                                self.activityIndicator.stopAnimating()
//                                netActivity -= 1
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        if netActivity < 1 {
//                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                        }
//                    }
//                }
//            }
//
        }
        
    }
}


