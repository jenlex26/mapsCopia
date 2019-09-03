//
//  LoginVC.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit
import SVProgressHUD
import Parse

class LoginVC: BaseViewController {
    
    @IBOutlet weak var mailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    var loginPresenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter = LoginPresenter(view: self)
        setUI()
        
        loginPresenter?.getCongigurations()
    }
    
    func setUI() {
        for obj in self.view.subviews {
            if obj is UITextField {
                let texf = obj as! UITextField
                var imageName = "ic-user.png"
                if texf.tag == 1 {
                    imageName = "ic-contraseña"
                }
                texf.rightViewMode = .always
                texf.leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
                let image = UIImage(named: imageName)
                imageView.image = image
                imageView.contentMode = .center
                texf.rightView = imageView
                let view =  UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
                texf.leftView = view
            }
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
//        if mailTxt.text != "" && passwordTxt.text != "" {
//            mailTxt.resignFirstResponder()
//            passwordTxt.resignFirstResponder()
//            SVProgressHUD.show(withStatus: "Validando Por favor Espere.")
//            loginPresenter?.performLogin(mail: mailTxt.text ?? "", password: passwordTxt.text ?? "")
//        } else {
//            showError(title: "Atención", message: "Ingresa tu usario y contraseña")
//        }
        
        SVProgressHUD.show(withStatus: "Validando Por favor Espere.")
        if mailTxt.text == "" {
            SVProgressHUD.dismiss()
            self.showError(title: "Alerta", message: "Porfavor rellena todos los campos")
            return
        }
        PFUser.logInWithUsername(inBackground: mailTxt.text!, password: passwordTxt.text!) { (user, error) in
            if user != nil {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "login", sender: nil)
            }else{
                if let descrip = error?.localizedDescription{
                    SVProgressHUD.dismiss()
                    self.showError(title: "Atención", message: descrip)
                    
                }
            }
        }
    }
}

extension LoginVC: LoginView {
    func showLoginSuccess() {
        SVProgressHUD.dismiss()
        guard let welcome = getViewController(for: .login, with: "welcome") else {
            return
        }
        
        modalNavigation = UINavigationController(rootViewController: welcome)
        modalNavigation?.preferredContentSize = Globals.modalPreferredContentSize()
        modalNavigation?.modalPresentationStyle = .formSheet
        self.navigationController?.present(modalNavigation!, animated: true)
    }
    
    func showForgotPasswordSuccess() {
        SVProgressHUD.dismiss()
        showError(title: "Exito", message: "Se envio un link a tu cuenta de correo para restablecer tu contraseña.")
    }
    
    func showForgotPasswordSuccessError(message: String) {
        SVProgressHUD.dismiss()
        showError(title: "Error", message: message)
    }
    
    func showGetconfigSuccess(isValid: Bool, message: String) {
//
//        if !isValid {
//            DispatchQueue.main.async {
//                let viewPay = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//                viewPay.backgroundColor = .red
//                self.view.addSubview(viewPay)
//
//                let labelPay = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width - 40, height: self.view.frame.height))
//                labelPay.numberOfLines = 6
//                labelPay.text = message
//                labelPay.textColor = .white
//                labelPay.textAlignment = .center
//                labelPay.font = UIFont(name: "Helvica-Bold", size: 40)
//                viewPay.addSubview(labelPay)
//            }
//        }

    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    
    
}
