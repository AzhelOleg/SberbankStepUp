//
//  LoginViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public final class LoginViewController: UIViewController {

    private let logo = UIImageView(image: UIImage(named: "sberlogo"))
    //
    private let loginInput = UITextField.logIn(with: "Enter login")
    private let passInput = UITextField.logIn(with: "Enter password")
    //
    private var button: UIButton!
    //
    private let gradient = GradientView()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        button = UIButton()
        button.frame.size = CGSize(width: 200, height: 40)
        button.center = view.center
        button.center.y += 300
        button.layer.cornerRadius = 20
		button.backgroundColor = .sberColor
        button.alpha = 0
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        logo.contentMode = .scaleAspectFill
        logo.frame.size = CGSize(width: 100, height: 100)
        logo.center = view.center
        logo.center.y -= 300
        
        loginInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        loginInput.center = view.center
        loginInput.center.y += 120
        
        passInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passInput.center = view.center
        passInput.center.y += 170
        
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
            UIView.animate(withDuration: 0.5) {
                self.button.alpha = 1
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.button.alpha = 0
        }
    }
    
    @objc
    func login() {
        UIView.animate(withDuration: 0.4,
                       animations: {
                        self.button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.4) {
                            self.button.transform = CGAffineTransform.identity
                        }
        })
        // login verification goes here
        let login = loginInput.text!
        let password = passInput.text!
        let users = Server.shared.userList()
        for user in users where user.login == login && user.password == password {
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
            AppDelegate.shared.rootViewController.showMainScreen()
        }
    }
    
}
