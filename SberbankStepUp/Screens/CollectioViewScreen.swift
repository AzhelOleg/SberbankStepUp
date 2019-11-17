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
	private let model: [AnalyticStruct]
	
	init(with data:[AnalyticStruct]) {
		self.model = data
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
		collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
		collectionView.isPagingEnabled = true
		return collectionView
	}()
}

extension CollectionViewScreen {
	override public func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		collectionLayout()
	}
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let curIndexPath = IndexPath(row: self.model.count - 1, section: 0)
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
}

extension CollectionViewScreen: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.model.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
		let data = self.model[indexPath.row]
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
