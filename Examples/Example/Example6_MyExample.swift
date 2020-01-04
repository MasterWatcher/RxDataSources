//
//  Example6_MyExample.swift
//  Example
//
//  Created by Goncharov Anton on 31/12/2019.
//  Copyright © 2019 kzaher. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator

class MyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


        let imageItem = ImageTitleCellViewModel(image: UIImage(named: "settings")!, title: "General")
        let switchItem = TitleSwitchCellViewModel(title: "Switch", isOn: true)
        let labelItem = LabelCellViewModel(title: "Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet")
        let switchItem2 = TitleSwitchCellViewModel(title: "Switch2", isOn: false)
        let textViewItem = TextViewCellViewModel(title: "Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet")
        let sections: [TableSectionModel] = [
            TableSectionModel(title: "Test", items: [imageItem, switchItem, labelItem, switchItem2, textViewItem])
        ]

        let director = TableDirector()

        Observable.just(sections)
            .bind(to: tableView.rx.items(director: director))
            .disposed(by: disposeBag)
        tableView.rx.setDelegate(director)
            .disposed(by: disposeBag)

        tableView.rx.viewModelSelected(ImageTitleCellViewModel.self)
            .subscribe(onNext: { value in
                print(value.title)
            })
            .disposed(by: disposeBag)

        tableView.rx.viewModelSelected(TitleSwitchCellViewModel.self)
            .subscribe(onNext: { value in
                print(value.title)
            })
            .disposed(by: disposeBag)

        director.cellCreated(TitleSwitchTableViewCell.self) { $0.switchControl.rx.isOn }
            .subscribe(onNext: { value in
                print("is on: \(value)")
            })
            .disposed(by: disposeBag)

        director.cellSizeChanged(TextViewCell.self)
            .bind(to: tableView.rx.updateSize)
            .disposed(by: disposeBag)
    }
}
