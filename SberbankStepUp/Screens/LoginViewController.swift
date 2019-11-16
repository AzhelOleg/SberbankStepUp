//
//  LoginViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Login"
        // Do any additional setup after loading the view.
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label.center = view.center
        label.center.y -= 200
        label.text = "Log in screen"
        
        view.addSubview(label)
        view.addSubview(button)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension LoginViewController {
    var button: UIButton! {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.center = view.center
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }
    @objc
    func login() {
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.showMainScreen()
    }
}
