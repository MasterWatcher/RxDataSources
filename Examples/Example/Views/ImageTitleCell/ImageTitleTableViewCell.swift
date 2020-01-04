//
//  ImageTitleTableViewCell.swift
//  RxDataSources
//
//  Created by Segii Shulga on 4/26/16.
//  Copyright © 2016 kzaher. All rights reserved.
//

import UIKit
import RxSwift

class ImageTitleTableViewCell: UITableViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var disposeBag = DisposeBag()

    func configure(with viewModel: ImageTitleCellViewModel) {
        cellImageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
