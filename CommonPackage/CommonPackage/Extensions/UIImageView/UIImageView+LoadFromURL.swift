//
//  UIImageView+LoadFromURL.swift
//  CommonPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import Kingfisher


public extension UIImageView {
    func loadImageFromURLString(urlStr: String){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: urlStr))
    }
}
