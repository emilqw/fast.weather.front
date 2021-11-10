//
//  ProfileViewController.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let token = ModelToken {
            ServiceUser.get(token: token) { modelUser in
                if let modelUser = modelUser {
                    if modelUser.error == nil {
                        DispatchQueue.main.async {
                            self.switchProfile(state: true)
                            self.navigationItem.title = "@" + modelUser.login
                            self.fullName.text = modelUser.name + " " + modelUser.surname
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.switchProfile(state: false)
                    }
                }
            }
        } else {
            switchProfile(state: false)
        }
    }
    func switchProfile(state:Bool){
        fullName.isHidden = !state
        logoutButton.isHidden = !state
        button.isHidden = state
        if !state {
            navigationItem.title = "Профиль"
        }
    }
    @IBAction func onLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "Да", style: .destructive) { sender in
            ModelToken = nil
            self.switchProfile(state: false)
        }
        let cancelButton = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
