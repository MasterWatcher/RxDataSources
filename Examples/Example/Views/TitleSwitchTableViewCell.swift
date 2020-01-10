//
//  TitleSwitchTableViewCell.swift
//  RxDataSources
//
//  Created by Segii Shulga on 4/26/16.
//  Copyright © 2016 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct TitleSwitchCellViewModel {
    let id = UUID().uuidString
    let title: String?
    let isOn: Bool
    let rowHeight: CGFloat = 55
}

extension TitleSwitchCellViewModel: TableCellViewModel {
    typealias TableCellType = TitleSwitchTableViewCell
}

class TitleSwitchTableViewCell: UITableViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!

    var disposeBag = DisposeBag()

    func configure(with viewModel: TitleSwitchCellViewModel) {
        titleLabel.text = viewModel.title
        switchControl.isOn = viewModel.isOn
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
