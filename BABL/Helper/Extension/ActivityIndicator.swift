//  File.swift
//
//  Created by Manisha  Sharma on 02/01/2019.
//  Copyright © 2019 Qualwebs. All rights reserved.
//

import UIKit

class ActivityIndicator {
    static var overlayView = UIView()
    static var activityIndicator = UIActivityIndicatorView()
    
    static func show(view: UIView, color: UIColor) {
        DispatchQueue.main.async {
            self.overlayView = view
            self.overlayView.isUserInteractionEnabled = false
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.style = UIActivityIndicatorView.Style.large
            activityIndicator.color = color
            view.addSubview(activityIndicator)
        }
    }
    
    static func hide() {
        overlayView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
}

