//
//  RootViewController.swift
//  SberbankStepUp
//
//  Created by Oleg Azhel on 16.11.2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public final class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    // Init
    init() {
        self.current = LoginViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
		//
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    public func showMainScreen() {
        let new = UINavigationController(rootViewController: MainViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        animateFadeTransition(to: new)
    }
    
    
    public func switchToTouchIdAuthScreen() {
        animateFadeTransition(to: TouchIdAuthViewController())
    }
    
    public func switchToLoginScreen() {
        animateFadeTransition(to: LoginViewController())
    }
    

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
}
