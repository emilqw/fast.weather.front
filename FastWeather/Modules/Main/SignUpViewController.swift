//
//  SignUpViewController.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onSignUp(_ sender: Any) {
        switchView(state: false)
        ServiceAuth.signUp(login: login.text ?? "", password: password.text ?? "",name: name.text ?? "",surname: surname.text ?? "") { modelAuth in
            guard let modelAuth = modelAuth else {
                return
            }
            if modelAuth.error == nil {
                if let token = modelAuth.token {
                    DispatchQueue.main.async {
                        ModelToken = token
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorView(message: "Регистрация не выполнен, попробуйте позже!")
                        self.switchView(state: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("error")
                    self.errorView(message: modelAuth.error!.error_massage)
                    self.switchView(state: true)
                }
            }
        }
        
    }
    func switchView(state:Bool){
        indicator.isHidden = state
        login.isEnabled = state
        password.isEnabled = state
        name.isEnabled = state
        surname.isEnabled = state
        button.isEnabled = state
    }
    func errorView(message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
