//
//  ViewController.swift
//  APM
//
//  Created by Oleksii KUCHKO on 6/27/19.
//  Copyright © 2019 Oleksii KUCHKO. All rights reserved.
//

import UIKit

var netActivity : Int = 0

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var img_number : Int = 0

    var itemMenuArray: [Menu] = {
        var blankMenu = Menu()
        blankMenu.name = "one"
        blankMenu.imageName = "https://images-assets.nasa.gov/image/NHQ201906250100/NHQ201906250100~orig.tif"
        
        var blankMenu2 = Menu()
        blankMenu2.name = "two"
        blankMenu2.imageName = "https://iimages-assets.nasa.gov/image/NHQ201906250031/NHQ201906250031~orig.tif"

        var blankMenu3 = Menu()
        blankMenu3.name = "three"
        blankMenu3.imageName = "https://images-assets.nasa.gov/image/iss054e009777/iss054e009777~orig.jpg"

        var blankMenu4 = Menu()
        blankMenu4.name = "four"
        blankMenu4.imageName = "https://images-assets.nasa.gov/image/PIA09178/PIA09178~orig.jpg"

       
        
        return [blankMenu, blankMenu2, blankMenu3, blankMenu4]
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
   
    

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let qos = DispatchQoS.userInitiated.qosClass
        let queue = DispatchQueue.global(qos: qos)
        
        
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            itemCell.activityIndicator.startAnimating()
            netActivity += 1
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            itemCell.activityIndicator.hidesWhenStopped = true
            //itemCell.menu = itemMenuArray[indexPath.row]
            if let image = itemMenuArray[indexPath.row].imageName {
                let url = URL(string: image)
                queue.async {
                    if let data = try? Data(contentsOf: url!) {
                        DispatchQueue.main.async {
                            itemCell.imageView.image = UIImage(data: data)
                            itemCell.activityIndicator.stopAnimating()
                            netActivity -= 1
                        }
                    } else {
                        self.alertHandler(alarmMassage: image)
                        DispatchQueue.main.async {
                            if itemCell.activityIndicator.isAnimating {
                                itemCell.activityIndicator.stopAnimating()
                                netActivity -= 1
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        if netActivity < 1 {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                }
            }
            return itemCell
            
        }
        return UICollectionViewCell()
    }
    
    func alertHandler(alarmMassage: String) {
        let alert = UIAlertController.init(title: "Error", message: "Cannot access to \(String(describing: alarmMassage))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is ScrollViewController {
//            var example : ScrollViewController?
//            itemMenuArray[img_number].imageName
//            if let data = try? Data(contentsOf: url!)
//                image = UIImage(data: data)
//            example?.image =
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ScrollViewController {
            if let vc = segue.destination as? ScrollViewController {
                if let collectionView = self.collectionView,
                    let indexPath = collectionView.indexPathsForSelectedItems?.first,
                    let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell,
                    let data = cell.imageView.image {
                    vc.image = data
                }
            }
        }
    }
    
    
}


