//
//  ViewController_S.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-10.
//

import Foundation
import UIKit

class ViewController_S: ViewController {
    
    
    //MARK: - WORRY ABOUT ME
    //
    
    //'O': what if we add paypal here
    //override func paymentMethods() -> [PaymentMethod] { [.visa, .mastercard, .giftcard, .paypal] }
    
    var betterPaymentTakingService: BetterPaymentTakingService = BetterPaymentTakingService()
    var user:User = User()
    var qrScanner:QRScanner = QRScanner()
    
    @IBAction override func loginToPaymentTakingService(){
        presentLoginScreen {
            self.user.logIn()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        switch paymentMethods()[indexPath.row] {
        case .visa:
            betterPaymentTakingService.takeVisaPayment(paymentInfo)
        case .mastercard:
            betterPaymentTakingService.takeMasterCardPayment(paymentInfo)
        case .giftcard:
            qrScanner.activateQRScanner(hostViewController: self) {
                self.betterPaymentTakingService.takeGiftcardPayment(self.paymentInfo)
            }
        default:
            print("unsupported")
        }
    }
}

class User {
    func isLoggedIn() -> Bool { ComplicatedLogic.shared.figureOutIfWeAreLoggedIn() }
    func logIn() { ComplicatedLogic.shared.loginUser() }
}

class QRScanner {
    func activateQRScanner(hostViewController: ViewController, onDone: @escaping ()->()) {
        hostViewController.presentQRScreen{ onDone() }
    }
}

class BetterPaymentTakingService {
    func takeVisaPayment(_ paymentInfo:PaymentInfo) {}
    func takeMasterCardPayment(_ paymentInfo:PaymentInfo) {}
    func takeGiftcardPayment(_ paymentInfo:PaymentInfo) {
        print("S is for Single Responsibility Principle")
    }
}
