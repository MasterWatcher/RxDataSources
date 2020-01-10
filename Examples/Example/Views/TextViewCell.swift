//
//  TextViewCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct TextViewCellViewModel: TableCellViewModel {
    typealias TableCellType = TextViewCell

    let id = UUID().uuidString
    let title: String
    let rowHeight = UITableViewAutomaticDimension
}

class TextViewCell: UITableViewCell, ConfigurableCell, DisposableCell {

    @IBOutlet weak var textView: UITextView!

    var disposeBag = DisposeBag()

    func configure(with viewModel: TextViewCellViewModel) {
        textView.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension TextViewCell: SizeChangeableCell {
    var didChangeSize: Observable<Void> {
        textView.rx.didChange.asObservable()
    }
}

