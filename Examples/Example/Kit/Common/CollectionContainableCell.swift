//
//  CollectionContainableCell.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit

protocol CollectionContainableCell: DisposableCell {
    var collectionView: UICollectionView { get }
}
