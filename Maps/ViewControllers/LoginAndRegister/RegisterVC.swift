//
//  RegisterVC.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit
import SVProgressHUD
import Parse

class RegisterVC: BaseViewController {
    var registerPresenter: DR3RegisterPresenter?
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var mailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPresenter = DR3RegisterPresenter(view: self)
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
//        for obj in self.scrollContent.subviews {
//            if obj is UITextField {
//                let texf = obj as! UITextField
//                texf.delegate = self
//
//                texf.layer.borderColor = UIColor.blueDRD.cgColor
//                texf.layer.borderWidth = 1
//                texf.layer.cornerRadius = texf.frame.height/2
//
//                var imageName = "ic-user.png"
//                imageName = getImage(tag: texf.tag)
//                texf.rightViewMode = .always
//                texf.leftViewMode = .always
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
//                let image = UIImage(named: imageName)
//                imageView.image = image
//                imageView.contentMode = .center
//                texf.rightView = imageView
//                let view =  UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
//                texf.leftView = view
//            }
//        }
    }
    @IBAction func changeValue(_ sender: UITextField) {
        self.registerPresenter?.changeColorTextField(textF: sender)
    }
    
    func getImage(tag: Int) -> String {
        switch tag {
        case 0:return "ic-user.png"
        case 1:return "ic-correo.png"
        case 2:return "ic-telefono.png"
        case 3:return "ic-direccion.png"
        case 4:return "ic-contraseña"
        case 5:return "ic-contraseña"
            
        default:
            return ""
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        validateData()
    }
    
    private func validateData() {
//        for txt in self.scrollContent.subviews {
//            SVProgressHUD.show(withStatus: "Validando Por favor Espere.")
//            if txt is UITextField {
//                guard let texField = txt as? UITextField else {
//                    return
//                }
//                if texField.text == "" {
//                    SVProgressHUD.dismiss()
//                    self.showError(title: "Alerta", message: "Porfavor rellena todos los campos")
//                    return
//                }
//                if texField == passwordTxt {
//                    if texField.text != confirmPassword.text {
//                        SVProgressHUD.dismiss()
//                        self.showError(title: "Alerta", message: "Las contraseñas no coinciden")
//                        return
//                    }
//                }
//            }
//
//        }
        
//        let user = UserModel(name: nameTxt.text ?? "", firstName: "", lastName: "", mail: mailTxt.text ?? "")
//
//        registerPresenter?.perfomrRegister(user: user, password: passwordTxt.text ?? "")
        if mailTxt.text != "" && passwordTxt.text != "" {
            let user = PFUser()
            user.username = mailTxt.text
            user.password = passwordTxt.text
            SVProgressHUD.show(withStatus: "Validando Por favor Espere.")
            user.signUpInBackground { (success, error) in
                if success{
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "login", sender: nil)
                }else{
                    if let descrip = error?.localizedDescription{
                        SVProgressHUD.dismiss()
                        self.showError(title: "Atención", message: descrip)
                    }
                }
            }
        } else {
            showError(title: "Atención", message: "Ingresa tu usario y contraseña")
        }
    }
}


extension RegisterVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONÑPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz áéíóú").inverted
            return string.rangeOfCharacter(from: set) == nil
        case 1:
            return true
        case 2:
            let set = NSCharacterSet(charactersIn: "1234567890+").inverted
            return string.rangeOfCharacter(from: set) == nil
        case 3:
            return true
        case 4:
            return true
        case 5:
            return true
        default:
            return true
        }
    }
    
}
extension RegisterVC: DR3RegisteView {
    func showRegisterSuccess() {
        SVProgressHUD.dismiss()
        guard let welcome = getViewController(for: .login, with: "welcome") else {
            return
        }
        
        modalNavigation = UINavigationController(rootViewController: welcome)
        modalNavigation?.preferredContentSize = Globals.modalPreferredContentSize()
        modalNavigation?.modalPresentationStyle = .formSheet
        self.navigationController?.present(modalNavigation!, animated: true)
    }
    
    func showRegisterError(message: String) {
        SVProgressHUD.dismiss()
        showError(title: "Atención", message: message)
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    
    
}
protocol DR3RegisteView {
    func showProgress()
    func hideProgress()
    func showRegisterSuccess()
    func showRegisterError(message: String)
}

class DR3RegisterPresenter {
    
    var view: DR3RegisteView
    
    init(view: DR3RegisteView) {
        self.view = view
        
    }
    
    func changeColorTextField(textF: UITextField) {
        
        if textF.text!.isEmpty || textF.text == "" {
            textF.layer.borderColor = UIColor.blueDRD.cgColor
        } else {
            textF.layer.borderColor = UIColor.greenDRD.cgColor
        }
    }
    
    func perfomrRegister(user: UserModel, password: String) {
//        APIManager.performRegister(type: .register, user: user, password: password) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "Registro")
//                self.view.showRegisterError(message: Globals.genericError)
//            } else {
//                guard let data = response, let ok = data.success else {
//                    debugError(error: error, type: "Registro")
//                    self.view.showRegisterError(message: Globals.genericError)
//                    return
//                }
//                
//                if ok {
//                    UserCurrentSession.shared().name = user.name
//                    UserCurrentSession.shared().mail = user.mail
//                    UserCurrentSession.shared().password = password
//                    UserCurrentSession.shared().token = response?.result
//                    debug(info: "SE ALMACENO USUSARIO CON EXITO")
//                    _ = ok ? self.view.showRegisterSuccess() : self.view.showRegisterError(message: Globals.genericError)
//                } else {
//                    guard let errors = response?.errors, let firstError = errors.first else {
//                        self.view.showRegisterError(message: Globals.genericError)
//                        return
//                    }
//                    var message = Globals.genericError
//                    if  let messageError = firstError["value"]{
//                        message = messageError
//                    }
//                    self.view.showRegisterError(message: message)
//                }
//            }
//        }
    }
}
