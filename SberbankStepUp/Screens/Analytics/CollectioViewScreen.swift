//
//  CollectioViewScreen.swift
//  SberbankStepUp
//
//  Created by Oleg Azhel on 17.11.2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public class CollectionViewScreen: UIViewController {
	public var value: Int!
	private let data: [AnalyticStruct]
	
	init(with data:[AnalyticStruct]) {
		self.data = data
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 40
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
		collectionView.isPagingEnabled = true
		return collectionView
	}()
	
	private let arButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(arSelector), for: .touchUpInside)
		button.titleLabel?.textAlignment = .center
		button.setTitle("AR", for: .normal)
		button.backgroundColor = .lightGray
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
		button.clipsToBounds = true
		button.layer.cornerRadius = 30
        
        let gradient = GradientView()
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = button.bounds
        let backView = UIView(frame: button.bounds)
        backView.layer.addSublayer(backgroundLayer)
        button.addSubview(backView)
		return button
	}()
	
	private let valueLabel: UILabel = {
		let label = UILabel()
		label.clipsToBounds = true
		label.translatesAutoresizingMaskIntoConstraints = false
		label.layer.cornerRadius = 10
		label.numberOfLines = 0
		label.backgroundColor = .lightGray
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 32)
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	private let topStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 10
		stack.axis = .vertical
		stack.distribution = .fillEqually
		return stack
	}()
}

extension CollectionViewScreen {
	override public func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        view.backgroundColor = .clear
        let gradient = GradientView()
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = view.bounds
        let backView = UIView(frame: view.bounds)
        backView.layer.addSublayer(backgroundLayer)
        view.addSubview(backView)
        
		valueLabel.text = "You bought " + "\(value!)" + " \(data.last!.currency)\n" + " for " + "\(Int(data.last!.money))" + " RUB"
		collectionLayout()
		stackLayout()
	}
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let curIndexPath = IndexPath(row: self.data.count - 1, section: 0)
		collectionView.scrollToItem(at: curIndexPath, at: .centeredHorizontally, animated: true)
	}

}

extension CollectionViewScreen {
	private func collectionLayout() {
		collectionView.dataSource = self
		collectionView.delegate = self
		view.addSubview(collectionView)
		let margins = view.safeAreaLayoutGuide
		collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 250).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
	}
	
	private func stackLayout() {
		topStack.addArrangedSubview(arButton)
		topStack.addArrangedSubview(valueLabel)
		view.addSubview(topStack)
		let margins = view.safeAreaLayoutGuide
		topStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
		topStack.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
		topStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
		topStack.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 10).isActive = true
	}
}

extension CollectionViewScreen: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.data.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
		let data = self.data[indexPath.row]
		cell.populate(data: data, value: value)
		return cell
	}
}

extension CollectionViewScreen: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        let height = collectionView.bounds.height - 40
        return CGSize(width: width, height: height)
    }
}

extension CollectionViewScreen {
	@objc
	private func arSelector() {
//        present(ARViewController(data: data), animated: true, completion: nil)
        navigationController?.pushViewController(ARViewController(data: data), animated: true)
	}
}
