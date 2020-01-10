//
//  LabelCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct LabelCellViewModel: TableCellViewModel {
    typealias TableCellType = LabelCell

    let id = UUID().uuidString
    let title: String
    let rowHeight = UITableViewAutomaticDimension
}

class LabelCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var titleLabel: UILabel!

    var disposeBag = DisposeBag()

    func configure(with viewModel: LabelCellViewModel) {
        titleLabel.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
