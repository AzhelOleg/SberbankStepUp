//
//  MainViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Main"
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label.center = view.center
        label.center.y -= 200
        label.text = "Main screen"
        view.addSubview(label)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
