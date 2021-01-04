//
//  UITableView+RegisterCells.swift
//  CommonPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(nibName: String, cellType: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: nibName)
    }

    public func dequeueReusableCell<T: UITableViewCell>(nibName: String, with type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? T
    }
}
