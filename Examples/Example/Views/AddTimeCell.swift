//
//  AddTimeCell.swift
//  Example
//
//  Created by Goncharov Anton on 09/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

struct AddTimeCellViewModel: CollectionCellViewModel {

    typealias CollectionCellType = AddTimeCell
    let id: String = UUID().uuidString
    let itemSize = CGSize(width: 72, height: 72)
}

class AddTimeCell: UICollectionViewCell, ConfigurableCell {
    func configure(with viewModel: AddTimeCellViewModel) {}

    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
