//
//  TextFieldCell.swift
//  Example
//
//  Created by Goncharov Anton on 06/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct TextFieldCellViewModel: TableCellViewModel {
    typealias TableCellType = TextFieldCell

    let id = UUID().uuidString
    let title: String
    let rowHeight: CGFloat = 57
}

class TextFieldCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var textField: UITextField!

    var disposeBag = DisposeBag()

    func configure(with viewModel: TextFieldCellViewModel) {
        textField.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

