//
//  Singleton.swift
//  Agile Sports
//
//  Created by AM on 21/06/19.
//  Copyright © 2019 AM. All rights reserved.
//

import Foundation
import UIKit
import Toaster


class Singleton {
    static let shared = Singleton()
    
    private init() {
    }
    
    func showToast(text: String) {
        Toast(text: text).show()
        Toast(text: text).cancel()
    }
}

