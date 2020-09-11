//
//  ViewController_SO.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-11.
//

import Foundation
import UIKit

class ViewController_SOL: ViewController_S {

    override func paymentMethods() -> [PaymentMethod] { [.visa, .mastercard, .giftcard, .paypal] }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        qrScanner.presenter = self
        PaymentServiceFactory.paymentService(method: method)?.takePayment(paymentInfo:paymentInfo, qrScanner:qrScanner)
    }
}

/*
//we're still here, don't forget
class User {}
class QRScanner {}
*/

class BasePaymentTakingService {
    //'I': Well this sucks
    func takePayment(paymentInfo:PaymentInfo, qrScanner:QRScanner) {}
    func takePayment(paymentInfo:PaymentInfo) {}
}

class PaymentServiceFactory {
    static func paymentService(method:PaymentMethod) -> BasePaymentTakingService? {
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

class VisaPaymentTakingService: BasePaymentTakingService {
    //'I': all of these funcs are useless
    override func takePayment(paymentInfo:PaymentInfo, qrScanner:QRScanner) { takePayment(paymentInfo:paymentInfo) }
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class MastercardPaymentTakingService: BasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo, qrScanner:QRScanner) { takePayment(paymentInfo:paymentInfo) }
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class PayPalPaymentTakingService: BasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo, qrScanner:QRScanner) { takePayment(paymentInfo:paymentInfo) }
    override func takePayment(paymentInfo:PaymentInfo) { }
}

class GiftcardPaymentTakingService: BasePaymentTakingService {
    override func takePayment(paymentInfo:PaymentInfo, qrScanner:QRScanner) {
        qrScanner.activateQRScanner {
            self.takePayment(paymentInfo: paymentInfo)
        }
    }
    override func takePayment(paymentInfo:PaymentInfo) {
        print("O is for Open/Close Principle")
    }
}
