//
//  ScrollViewController.swift
//  APM
//
//  Created by Oleksii KUCHKO on 6/28/19.
//  Copyright © 2019 Oleksii KUCHKO. All rights reserved.
//

import Foundation

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView : UIImageView?
    var image : UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        image = UIImage(named: "cosmonat")
        imageView = UIImageView(image: image)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = (imageView?.frame.size)!
        scrollView.maximumZoomScale = 100
//        scrollView.minimumZoomScale = 0.1
        scrollView.delegate = self
    }
    
    func setZoomScale() {
        var minZoom = min(self.view.bounds.size.width / imageView!.bounds.size.width, self.view.bounds.size.height / imageView!.bounds.size.height)
        if (minZoom > 1.0) {
            minZoom = 1.0
        }
        scrollView.minimumZoomScale = minZoom
        scrollView.zoomScale = minZoom
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

