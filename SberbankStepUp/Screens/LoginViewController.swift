//
//  LoginViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public final class LoginViewController: UIViewController {

    let logo = UIImageView(image: UIImage(named: "sberlogo"))
    
    let loginInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
    let passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
    
    var button: UIButton!
    
    @objc
    func login() {
        // login verification goes here
        let login = loginInput.text!
        let password = passInput.text!
        let users = Server.shared.userList()
        for user in users where user.login == login && user.password == password {
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
            AppDelegate.shared.rootViewController.showMainScreen()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.center = view.center
        button.center.y += 300
        button.layer.cornerRadius = 20
        button.backgroundColor = .green
        button.isHidden = true
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        logo.contentMode = .scaleAspectFill
        logo.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        logo.center = view.center
        logo.center.y -= 300
        logo.backgroundColor = .clear
        
        loginInput.center = view.center
        passInput.center = view.center
        
        loginInput.center.y -= 150
        passInput.center.y -= 90
        

        loginInput.borderStyle = .roundedRect
        passInput.borderStyle = .roundedRect
        
        loginInput.tintColor = .black
        passInput.tintColor = .black
        
        loginInput.textAlignment = .center
        passInput.textAlignment = .center
        
        loginInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        view.addSubview(loginInput)
        view.addSubview(passInput)
        view.addSubview(button)
        view.addSubview(logo)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if !loginInput.text!.isEmpty && !passInput.text!.isEmpty {
            button.isHidden = false
            return
        }
        button.isHidden = true
    }
}

