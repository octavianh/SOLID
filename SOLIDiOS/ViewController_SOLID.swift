//
//  ViewController_SOLID.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-22.
//

import Foundation
import UIKit


protocol CreatesPaymentsServices {
    func paymentServiceFor(method:PaymentMethod) -> BetterBasePaymentTakingService?
}

class ViewController_SOLID: ViewController_SOLI {
    
    let serviceCreator: CreatesPaymentsServices = SOLIDPaymentServiceFactory()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        qrScanner.presenter = self
        let service = serviceCreator.paymentServiceFor(method: method)
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

class SOLIDPaymentServiceFactory: CreatesPaymentsServices {
    func paymentServiceFor(method:PaymentMethod) -> BetterBasePaymentTakingService? {
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
