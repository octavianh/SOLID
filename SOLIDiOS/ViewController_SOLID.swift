//
//  ViewController_SOLID.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-11.
//

import Foundation
import UIKit

protocol PaymentProcessor {
    func takePayment(method:PaymentMethod,
                     paymentInfo:PaymentInfo)
}

class ViewController_SOLID: ViewController_SOLI {

    var paymentProcessor: PaymentProcessor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentProcessor = SOLIDPaymentProcessor(qrScanner: self.qrScanner, presenter: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !user.isLoggedIn() {
            showError("not logged in")
            return
        }
        let method = paymentMethods()[indexPath.row]
        paymentProcessor?.takePayment(method: method, paymentInfo: paymentInfo)
    }
}

class SOLIDPaymentProcessor: PaymentProcessor {
    var qrScanner: QRScanner
    var presenter: ViewController
    
    init(qrScanner:QRScanner, presenter: ViewController){
        self.qrScanner = qrScanner
        self.presenter = presenter
    }
    
    func takePayment(method:PaymentMethod,
                     paymentInfo:PaymentInfo){
        
        let service = BetterPaymentServiceFactory.paymentService(method: method)
        
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
