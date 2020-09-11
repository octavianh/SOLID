//
//  ViewController_SO.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-11.
//

import Foundation
import UIKit

class ViewController_SO: ViewController_S {

    override func paymentMethods() -> [PaymentMethod] { [.visa, .mastercard, .giftcard, .paypal] }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        switch method {
        case .giftcard:
            qrScanner.activateQRScanner(hostViewController: self) {
                self.betterPaymentTakingService.takeGiftcardPayment(self.paymentInfo)
            }
        default:
            PaymentServiceFactory.paymentService(method: method)?.takePayment(paymentInfo: paymentInfo)
        }
    }
}

/*
//we're still here, don't forget
class User {}
class QRScanner {}
*/

protocol CanTakePayment {
    func takePayment(paymentInfo:PaymentInfo)
}

class PaymentServiceFactory {
    static func paymentService(method:PaymentMethod) -> CanTakePayment? {
        switch method {
        case .visa:
            return VisaPaymentTakingService()
        case .mastercard:
            return MastercardPaymentTakingService()
        case .giftcard:
            return GiftcardPaymentTakingService()
        case .paypal:
            return PayPalPaymentTakingService()
        default:
            print("unsupported")
            return nil
        }
    }
}

class VisaPaymentTakingService: CanTakePayment {
    func takePayment(paymentInfo:PaymentInfo) { }
}

class MastercardPaymentTakingService: CanTakePayment {
    func takePayment(paymentInfo:PaymentInfo) { }
}

class GiftcardPaymentTakingService: CanTakePayment {
    func takePayment(paymentInfo:PaymentInfo) { }
}

class PayPalPaymentTakingService: CanTakePayment {
    func takePayment(paymentInfo:PaymentInfo) { }
}
