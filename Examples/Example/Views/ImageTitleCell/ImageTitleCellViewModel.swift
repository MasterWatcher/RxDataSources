//
//  ImageTitleCellViewModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit

struct ImageTitleCellViewModel {
    let image: UIImage?
    let title: String?
}

extension ImageTitleCellViewModel: TableCellViewModel {
     typealias TableCellType = ImageTitleTableViewCell
}

extension ImageTitleCellViewModel: CollectionCellViewModel {

    typealias CollectionCellType = ImageTitleCollectionViewCell

    var itemSize: CGSize {
        CGSize(width: 100, height: 100)
    }
}
