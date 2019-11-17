//
//  MainViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public final class MainViewController: UIViewController {
	// MARK: - UI
	private let picker: UIPickerView = {
		let picker = UIPickerView()
		picker.translatesAutoresizingMaskIntoConstraints = false
		return picker
	}()
	private let imageButton: UIButton = {
		let imageButton = UIButton()
		imageButton.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(named: "sberlogo")!
		imageButton.setImage(image, for: .normal)
		return imageButton
	}()
	private let currencyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "  Choose currency to buy:"
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16)
		return label
	}()
	private let valueTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = UIFont.boldSystemFont(ofSize: 40)
        textField.tintColor = .black
		textField.placeholder = "Amount"
		textField.textAlignment = .center
		textField.keyboardType = .numberPad
		return textField
	}()
	private lazy var valueLabel:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "  Enter amount to buy:"
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16)
		return label
	}()
	
	private let calculateButton:UIButton =  {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Calculate", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .medium)
		button.addTarget(self, action: #selector(calculateSelector), for: .touchUpInside)
		button.backgroundColor = UIColor.sberColor
		button.layer.cornerRadius = 50
		return button
	}()
	
	private lazy var indicator:UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		indicator.center = view.center
		indicator.layer.cornerRadius = 10
		indicator.style = .whiteLarge
		indicator.color = .white
		indicator.backgroundColor = UIColor.sberColor
		indicator.startAnimating()
		return indicator
	}()
	
}

// MARK: - Layout
extension MainViewController {
	private func pickerLayout() {
		view.addSubview(picker)
		picker.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 40).isActive = true
		picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0).isActive = true
		picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500).isActive = true
	}
	private func imageLayout() {
		view.addSubview(imageButton)
		imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
		imageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		imageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
		imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	private func currencyLabelLayout() {
		view.addSubview(currencyLabel)
		currencyLabel.bottomAnchor.constraint(equalTo: picker.topAnchor, constant: 0).isActive = true
		currencyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		currencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		currencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
	}
	private func valueTextFieldLayout() {
		view.addSubview(valueTextField)
		valueTextField.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 50).isActive = true
		valueTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
		valueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
		valueTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
	}
	
	private func valueLabelLayout() {
		view.addSubview(valueLabel)
		valueLabel.bottomAnchor.constraint(equalTo: valueTextField.topAnchor, constant: 0).isActive = true
		valueLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
	}
	
	private func calculateButtonlayout() {
		view.addSubview(calculateButton)
		calculateButton.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: 100).isActive = true
		calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
		calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
		calculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
	}
}


// MARK: - Lifecycle
extension MainViewController {
	override public func viewDidLoad() {
		super.viewDidLoad()
		picker.delegate = self
		picker.dataSource = self
		valueTextField.delegate = self
		//
        
        //
        
        view.backgroundColor = .clear
        let gradient = GradientView()
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = view.bounds
        let backView = UIView(frame: view.bounds)
        backView.layer.addSublayer(backgroundLayer)
        view.addSubview(backView)
        
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutSelector))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
		//
		imageLayout()
		pickerLayout()
		currencyLabelLayout()
		valueTextFieldLayout()
		valueLabelLayout()
		calculateButtonlayout()
	}
}

// MARK: - Selectors
extension MainViewController {
	@objc
	private func logoutSelector() {
        
        let alert = UIAlertController(title: "Logging out", message: "Are you sure you'd like to log out?", preferredStyle: .alert)
        
        let logout = UIAlertAction(title: "Yes", style: .destructive) { (action:UIAlertAction) in
            AppDelegate.shared.rootViewController.switchToTouchIdAuthScreen()
        }

        let stay = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in }
        stay.setValue(UIColor.black, forKey: "titleTextColor")
        
        alert.addAction(stay)
        alert.addAction(logout)
        
        self.present(alert, animated: true, completion: nil)
	}
	
	@objc
	private func calculateSelector() {
		if valueTextField.text!.count == 0 {
			return
		}
		view.addSubview(indicator)

		let values = CurrencyManager.shared.getAnalyticSegmentList(for: Float(valueTextField.text!)!,
                                                                   currency: Currency.allCases[picker.selectedRow(inComponent: 0)])
		let collection = CollectionViewScreen(with: values)
		collection.value = Int(valueTextField.text!)!
		collection.modalTransitionStyle = .coverVertical
		collection.modalPresentationStyle = .overCurrentContext
		self.navigationController?.pushViewController(collection, animated: true)
		indicator.removeFromSuperview()
	}
}

// MARK: - Picker dataSource
extension MainViewController:UIPickerViewDataSource {
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return Currency.allCases.count
	}
}

// MARK: - Picker delegate
extension MainViewController:UIPickerViewDelegate {
	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return Currency.allCases[row].rawValue
	}
}

// MARK: - Textfield delegate
extension MainViewController:UITextFieldDelegate {
	public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		
		return true
	}
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
	@objc func doneButtonTapped() { self.resignFirstResponder() }
	@objc func cancelButtonTapped() { self.resignFirstResponder() }
}
