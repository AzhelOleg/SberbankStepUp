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
    
    let loginInput = UITextField(frame: CGRect(x: 0, y: 0, width: 160, height: 30))
    let passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 160, height: 30))
    
    var button: UIButton!
    
    let gradient = GradientView()
    
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
//            UIView.animate(withDuration: 0.7,
//                           delay: 0.0,
//                           options: [.curveEaseInOut, .repeat, .autoreverse],
//                           animations: {
//                                self.button.transform = CGAffineTransform(scaleX: 2.0, y: 0)
//            },
//                           completion: { _ in
//
//            })

            AppDelegate.shared.rootViewController.showMainScreen()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .clear
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
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
        
        loginInput.center.y += 120
        passInput.center.y += 170
        

        loginInput.borderStyle = .roundedRect
        passInput.borderStyle = .roundedRect
        
        loginInput.tintColor = .black
        passInput.tintColor = .black
        
        loginInput.textAlignment = .center
        passInput.textAlignment = .center
        
        loginInput.placeholder = "Enter login"
        passInput.placeholder = "Enter password"
        
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


final class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as? CAGradientLayer ?? CAGradientLayer()
    }
    
    func update() {
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 213.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        let colorTop = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
        gradientLayer.colors = [colorBottom, colorTop].compactMap{ $0.cgColor }
        gradientLayer.locations = [0.0, 1.0]
        
    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
}
