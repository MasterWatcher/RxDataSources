//
//  ButtonCollectionViewCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct ButtomCellViewModel: CollectionCellViewModel {

    typealias CollectionCellType = ButtonCollectionViewCell

    let id: String = UUID().uuidString
    let title: String
    let itemSize = CGSize(width: 75, height: 75)
}

class ButtonCollectionViewCell: UICollectionViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var button: UIButton!

    var disposeBag = DisposeBag()

    func configure(with viewModel: ButtomCellViewModel) {
        button.setTitle(viewModel.title, for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

