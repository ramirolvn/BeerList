//
//  DefaultAlertController.swift
//  CommonPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import UIKit

public struct DefaultAlertController {
    
    public static func showAlert(parent: UIViewController, title: String?, message: String? = nil, style: UIAlertController.Style, defaultActions: [String]?, destructiveActions: [String]? = nil, cancelAction: String? = nil, completion: @escaping (Int) -> Void) {
        
        let defaultAlert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        // MARK: - Add DefaultActions
        if let defaultActions = defaultActions {
            for (defaultActionIndex, action) in defaultActions.enumerated() {
                defaultAlert.addAction(UIAlertAction(title: action, style: .default, handler: { (_) in
                    completion(defaultActionIndex)
                }))
            }
        }
        
        // MARK: - Add DestructiveActions
        if let destructiveActions = destructiveActions {
            for (destructiveActionIndex, destructiveAction) in destructiveActions.enumerated() {
                let defaultActionsMaxIndex = (defaultActions?.count ?? 0)
                let indexToCompletion = defaultActionsMaxIndex + destructiveActionIndex
                defaultAlert.addAction(UIAlertAction(title: destructiveAction, style: .destructive, handler: { (_) in
                    completion(indexToCompletion)
                }))
            }
        }
        
        // MARK: - Add CancelActionAction
        if let cancelAction = cancelAction {
            let defaultActionsMaxIndex = (defaultActions?.count ?? 0)
            let destructiveActionsMaxIndex = (destructiveActions?.count ?? 0)
            let indexToCompletion = defaultActionsMaxIndex + destructiveActionsMaxIndex
            defaultAlert.addAction(UIAlertAction(title: cancelAction, style: .cancel, handler: { (_) in
                completion(indexToCompletion)
            }))
        }
        
        parent.present(defaultAlert, animated: true, completion: nil)
    }
    
}
