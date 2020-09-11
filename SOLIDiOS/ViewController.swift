//
//  ViewController.swift
//  SOLIDiOS
//
//  Created by O on 2020-09-10.
//

import UIKit

enum PaymentMethod: String{
    case visa = "visa"
    case mastercard = "mastercard"
    case giftcard = "giftcard"
    case paypal = "paypal"
    //case mercadolibre = "mercadolibre"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //MARK: - DON'T WORRY ABOUT ME
    @IBOutlet weak var tableView: UITableView!
    var paymentInfo: PaymentInfo = PaymentInfo()
    func paymentMethods() -> [PaymentMethod] { [.visa, .mastercard, .giftcard] }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId(),
                     for: indexPath)
        cell.textLabel?.text = paymentMethods()[indexPath.row].rawValue
        return cell
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - LOOK AT THIS FIRST
    //
    var paymentTakingService: PaymentTakingService = PaymentTakingService()
    
    @IBAction func loginToPaymentTakingService(){
        presentLoginScreen {
            //'S' 2) replace w/ User.login() - this doesn't belong in PaymentTakingService
            self.paymentTakingService.logIn()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //'S' 1) replace w/ User.isLoggedIn() - this doesn't belong in PaymentTakingService
        
        if !paymentTakingService.isLoggedIn() {
            showError("not logged in")
            return
        }
        
        let paymentMethod: PaymentMethod = paymentMethods()[indexPath.row]
        
        switch paymentMethod {
        case .visa:
            paymentTakingService.takeVisaPayment(self.paymentInfo)
        case .mastercard:
            paymentTakingService.takeMasterCardPayment(self.paymentInfo)
        case .giftcard:
            //'S' 3) replace w/ QRScanner.activateScanner() - this doesn't belong in PaymentTakingService
            paymentTakingService.takeGiftcardPayment(self.paymentInfo, parent: self)
        default:
            print("unsupported")
        }
    }
}











//MARK: - LOOK AT THIS SECOND

class PaymentTakingService {
    func isLoggedIn() -> Bool { ComplicatedLogic.shared.figureOutIfWeAreLoggedIn() }
    func logIn() { ComplicatedLogic.shared.loginUser() }
    func takeVisaPayment(_ paymentInfo: PaymentInfo)
        { print("visa:" + paymentInfo.amount) }
    func takeMasterCardPayment(_ paymentInfo: PaymentInfo)
        { print("mc:" + paymentInfo.amount) }
    func takeGiftcardPayment(_ paymentInfo: PaymentInfo, parent: ViewController)
        { self.activateQRScanner(paymentInfo, hostViewController: parent) }
    
    //MARK: - private funcs
    private func activateQRScanner(_ paymentInfo:PaymentInfo, hostViewController: ViewController) {
        hostViewController.presentQRScreen{ self.takeGiftcardPayment(paymentInfo) }
    }
    private func takeGiftcardPayment(_ paymentInfo:PaymentInfo) {
        print("giftcard:" + paymentInfo.amount)
    }
}
