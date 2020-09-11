//
//  ViewController_SOLI.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-11.
//

import Foundation
import UIKit

class ViewController_SOLI: ViewController_SOL {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        qrScanner.presenter = self
        let service = BetterPaymentServiceFactory.paymentService(method: method)
        switch method {
        case .giftcard:
            qrScanner.activateQRScanner {
                service?.takePayment(paymentInfo: self.paymentInfo)
            }
        default:
            service?.takePayment(paymentInfo: paymentInfo)
        }
    }
    
}

class BetterBasePaymentTakingService {
    func takePayment(paymentInfo:PaymentInfo) {}
}

class BetterPaymentServiceFactory {
    static func paymentService(method:PaymentMethod) -> BetterBasePaymentTakingService? {
        switch method {
        case .visa:
            return BetterVisaPaymentTakingService()
        case .mastercard:
            return BetterMastercardPaymentTakingService()
        case .giftcard:
            return BetterGiftcardPaymentTakingService()
        case .paypal:
            return BetterPayPalPaymentTakingService()
        default:
            print("unsupported")
            return nil
        }
    }
}

class BetterVisaPaymentTakingService: BetterBasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class BetterMastercardPaymentTakingService: BetterBasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class BetterPayPalPaymentTakingService: BetterBasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class BetterGiftcardPaymentTakingService: BetterBasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo) {
        print("I is for Interface Segregation Principle")
    }
}
