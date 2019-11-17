//
//  CollectionViewCell.swift
//  SberbankStepUp
//
//  Created by Oleg Azhel on 17.11.2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public class CollectionViewCell:UICollectionViewCell {
	public static let id = "CellID"
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .none
		contentView.layer.cornerRadius = 10
		yearLayout()
		descriptionCurrencyLabelLayout()
		valueLayout()
		currencyDynamicLabelLayout()
		exchangeLayout()
		signLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let yearAndMonthLabel:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 45)
		label.textAlignment = .center
		return label
	}()
	private let currencyDescriptionLabel:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textAlignment = .center
		return label
	}()
	
	private let valueLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 45)
		label.textAlignment = .center
		return label
	}()
	
	private let currencyDynamicLabel:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textAlignment = .center
		return label
	}()
	
	private let exchangeValueLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 45)
		label.textAlignment = .center
		return label
	}()
	
	private let signDynamicLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.layer.cornerRadius = 10
		label.font = UIFont.boldSystemFont(ofSize: 80)
		label.textAlignment = .center
		return label
	}()
}

extension CollectionViewCell {
	public func populate(data: AnalyticStruct, value: Int) {
		let sign:String
		switch data.conclusion {
		case .drop:
			sign = "-"
			contentView.backgroundColor = .green
		case .rise:
			sign = "+"
			contentView.backgroundColor = .red
		default:
			sign = ""
			contentView.backgroundColor = .darkGray
		}
		//
		yearAndMonthLabel.text = " " + data.year + " " + data.month
		//
		currencyDescriptionLabel.text = "Amount of:"
		//
		valueLabel.text = " " + "\(value)" + " " + data.currency
		//
		currencyDynamicLabel.text = "costs" + (sign == "-" ? " lower" : (sign == "+" ? " higher" : " same")) + " than previously:"
		//
		exchangeValueLabel.text = " \(Int(data.money)) " + "RUB"
		//
		signDynamicLabel.text = " " + sign + String(format: "%.2f", data.difference) + " %"
	}
}

extension CollectionViewCell {
	private func yearLayout() {
		contentView.addSubview(yearAndMonthLabel)
		yearAndMonthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		yearAndMonthLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		yearAndMonthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		yearAndMonthLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
	}
	private func descriptionCurrencyLabelLayout() {
		contentView.addSubview(currencyDescriptionLabel)
		currencyDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
		currencyDescriptionLabel.topAnchor.constraint(equalTo: yearAndMonthLabel.bottomAnchor, constant: 5).isActive = true
		currencyDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
		currencyDescriptionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	private func valueLayout() {
		contentView.addSubview(valueLabel)
		valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		valueLabel.topAnchor.constraint(equalTo: currencyDescriptionLabel.bottomAnchor, constant: 5).isActive = true
		valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		yearAndMonthLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
	}
	private func currencyDynamicLabelLayout() {
		contentView.addSubview(currencyDynamicLabel)
		currencyDynamicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
		currencyDynamicLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5).isActive = true
		currencyDynamicLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
		currencyDynamicLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	private func exchangeLayout() {
		contentView.addSubview(exchangeValueLabel)
		exchangeValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		exchangeValueLabel.topAnchor.constraint(equalTo: currencyDynamicLabel.bottomAnchor, constant: 5).isActive = true
		exchangeValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		exchangeValueLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
	}
	
	private func signLayout() {
		contentView.addSubview(signDynamicLabel)
		signDynamicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		signDynamicLabel.topAnchor.constraint(equalTo: exchangeValueLabel.bottomAnchor, constant: 5).isActive = true
		signDynamicLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		signDynamicLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
	}
}
