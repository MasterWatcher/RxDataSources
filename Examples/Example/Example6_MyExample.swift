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


        let image = UIImage(named: "settings")!

        let imageItem = ImageTitleCellViewModel(image: image, title: "General")
        let switchItem = TitleSwitchCellViewModel(title: "Switch", isOn: true)
        let labelItem = LabelCellViewModel(title: "Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet")
        let switchItem2 = TitleSwitchCellViewModel(title: "Switch2", isOn: false)
        let textViewItem = TextViewCellViewModel(title: "Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet, Lorem Ipsum Dolor sit amet")

        let nestedSections: [CollectionSectionModel] = [ CollectionSectionModel(items: [
            TimeCellViewModel(title: "09:00", image: image),
            TimeCellViewModel(title: "14:30", image: image),
            TimeCellViewModel(title: "22:00", image: image),
            TimeCellViewModel(title: "09:00", image: image),
            TimeCellViewModel(title: "14:30", image: image),
            TimeCellViewModel(title: "22:00", image: image),
            TimeCellViewModel(title: "09:00", image: image),
            TimeCellViewModel(title: "14:30", image: image),
            TimeCellViewModel(title: "22:00", image: image)
        ])]

        let collectionItem = EmbedCollectionCellViewModel(nestedSections: nestedSections)
        let sections: [TableSectionModel] = [
            TableSectionModel(title: "Test", items: [imageItem, switchItem, labelItem, switchItem2, textViewItem, collectionItem])
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

        director.rx.cellCreated(TitleSwitchTableViewCell.self) { $0.switchControl.rx.isOn }
            .subscribe(onNext: { value in
                print("is on: \(value)")
            })
            .disposed(by: disposeBag)

        director.rx.cellSizeChanged(TextViewCell.self)
            .bind(to: tableView.rx.updateSize)
            .disposed(by: disposeBag)

        director.rx.nestedCellCreated(TimeCell.self) { $0.closeButton.rx.tap }
            .subscribe(onNext: { value in
                print("close tap")
            })
            .disposed(by: disposeBag)
    }
}
