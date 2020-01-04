//
//  CollectionViewItemT`ype.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit

protocol CollectionItemType {
    var collectionReuseIdentifier: String { get }
    var itemSize: CGSize { get }
    func configure(_ cell: UICollectionViewCell)
}
