//
//  Storyboarded.swift
//  CommonPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instantiate(storyboardName: String, bundle: Bundle?) -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String, bundle: Bundle?) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        // swiftlint:disable force_cast
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
        // swiftlint:enable force_cast
    }
}
