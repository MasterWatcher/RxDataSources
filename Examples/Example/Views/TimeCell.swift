//
//  TimeCell.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

struct TimeCellViewModel: CollectionCellViewModel {

    typealias CollectionCellType = TimeCell

    let title: String
    let image: UIImage
    let itemSize = CGSize(width: 72, height: 72)
}

class TimeCell: UICollectionViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!

    var disposeBag = DisposeBag()

    func configure(with viewModel: TimeCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = viewModel.image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

