//
//  Helpers.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-10.
//

import Foundation
import UIKit

extension ViewController {
    func cellId() -> String { "tableViewRowIdentifier" }
    func showError(_ errorString: String) {
        let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func presentLoginScreen(_ onDone: @escaping ()->()){
        let myAlert = UIAlertController(title:"Login", message:"logging in...", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            onDone()
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
    }
    func presentQRScreen(_ onDone: @escaping ()->()){
        let alertMessage = UIAlertController(title: "Scan the thing", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        action.setValue(UIImage(named: "qrscanner")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        alertMessage .addAction(action)
        let okAction = UIAlertAction(title: "Scanned the thing", style: .default) { action in
            onDone()
        }
        alertMessage.addAction(okAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
}

class ComplicatedLogic {
    var isLoggedIn = false
    static let shared: ComplicatedLogic = {
        return ComplicatedLogic()
    }()
    
    func figureOutIfWeAreLoggedIn() -> Bool { isLoggedIn }
    func loginUser(){
        isLoggedIn = true
    }
}

class PaymentInfo{
    var amount = " paid $5.00"
}
