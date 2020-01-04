//
//  ImageTitleCollectionViewCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

class ImageTitleCollectionViewCell: UICollectionViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var disposeBag = DisposeBag()

    func configure(with viewModel: ImageTitleCellViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
