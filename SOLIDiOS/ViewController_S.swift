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
    
    @IBAction override func loginPressed() {
        presentLoginScreen {
            self.user.logIn()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        //'O' let's switch these funcs out for classes that we get from a Factory
        //'L' notice that we'd get Liskov for free if we did that
        switch paymentMethods()[indexPath.row] {
        case .visa:
            betterPaymentTakingService.takeVisaPayment(paymentInfo)
        case .mastercard:
            betterPaymentTakingService.takeMasterCardPayment(paymentInfo)
        case .giftcard:
            qrScanner.presenter = self
            //'O' this one is a problem, because its signature is different from the other payments
            //One thing we can do here is wrap takePayment() in takePayment(withQrScanner:) 
            self.betterPaymentTakingService.takeGiftcardPayment(paymentInfo, qrScanner:qrScanner)
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
    var presenter:ViewController? = nil
    func activateQRScanner(onDone: @escaping ()->()) {
        presenter?.presentQRScreen{ onDone() }
    }
}

class BetterPaymentTakingService {
    func takeVisaPayment(_ paymentInfo:PaymentInfo) {}
    func takeMasterCardPayment(_ paymentInfo:PaymentInfo) {}
    func takeGiftcardPayment(_ paymentInfo:PaymentInfo, qrScanner:QRScanner) {
        qrScanner.activateQRScanner {
            print("S is for Single Responsibility Principle")
        }
    }
}
