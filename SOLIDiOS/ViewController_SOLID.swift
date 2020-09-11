//
//  ViewController_SOLID.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-11.
//

import Foundation
import UIKit

class ViewController_SOLID: ViewController_SOLI {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        PaymentProcessor.takePayment(method: method, paymentInfo: paymentInfo, presenter: self)
    }
}

class PaymentProcessor {
    static func takePayment(method:PaymentMethod, paymentInfo:PaymentInfo, presenter:ViewController){
        
        let service = BetterPaymentServiceFactory.paymentService(method: method)
        let qrScanner:QRScanner = QRScanner()
        qrScanner.presenter = presenter
        
        switch method {
        case .giftcard:
            qrScanner.activateQRScanner {
                service?.takePayment(paymentInfo: paymentInfo)
            }
        default:
            service?.takePayment(paymentInfo: paymentInfo)
        }
    }
}
