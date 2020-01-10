//
//  Example8_NestedCollectionView.swift
//  Example
//
//  Created by Goncharov Anton on 09/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator

class MyNestedCollectionController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    let image = UIImage(named: "settings")!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nestedSection = CollectionSectionModel(items: [
            AddTimeCellViewModel(),
            TimeCellViewModel(title: "09:00", image: image)
        ])

        let director = TableDirector()

        let addTime = director.rx.nestedViewModelSelected(AddTimeCellViewModel.self, in: EmbedCollectionCell.self)
            .map { _ in Event.addItem }

        let removeTime =  director.rx.nestedCellCreated(TimeCell.self) { cell, item in
            cell.closeButton.rx.tap
                .map { item.id }
            }
            .map(Event.deleteItem)

        let initState = State(section: nestedSection)

        Observable.of(addTime, removeTime)
            .merge()
            .scan(initState, accumulator: reduce)
            .startWith(initState)
            .map { [$0.section] }
            .map { EmbedCollectionCellViewModel(id: "time", nestedSections: $0) }
            .map { [TableSectionModel(id:"table", title: "Test", items: [$0])] }
            .share(replay: 1)
            .bind(to: tableView.rx.items(director: director))
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(director)
            .disposed(by: disposeBag)
        tableView.rx.configureKeyboard()
            .disposed(by: disposeBag)
    }

    enum Event {
        case addItem
        case deleteItem(id: String)
    }

    struct State {
        var section: CollectionSectionModel
    }

    func reduce(state: State, event: Event) -> State {
        switch event {
        case .addItem:
            var result = state
            let timeItem = TimeCellViewModel(title: "09:00", image: image)
            var items = state.section.items
            items.append(AnyCollectionItem(timeItem))
            result.section = CollectionSectionModel(original: state.section, items: items)
            return result
        case let .deleteItem(id):
            var result = state
            var items = state.section.items
            items.removeAll { $0.id == id }
            result.section = CollectionSectionModel(original: state.section, items: items)
            return result
        }
    }
}
