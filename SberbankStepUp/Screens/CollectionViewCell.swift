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
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CollectionViewCell {
	public func populate(data: AnalyticStruct) {
		print(data)
		switch data.conclusion {
		case .drop:
			contentView.backgroundColor = .green
		case .rise:
			contentView.backgroundColor = .red
		default:
			contentView.backgroundColor = .darkGray
		}
	}
}
