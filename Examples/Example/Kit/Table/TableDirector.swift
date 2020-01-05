//
//  MyTableDirector.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class TableDirector: NSObject {

    typealias DataSource = RxTableViewSectionedReloadDataSource<TableSectionModel>

    lazy var collectionDirector = CollectionDirector()
    let cell = PublishRelay<UITableViewCell>()

    lazy var dataSource: DataSource = {

        let configureCell: DataSource.ConfigureCell = {(_, tableView, _, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.tableReuseIdentifier)!
            item.configure(cell)
            switch item.nestedType {
            case .none: break
            case let .collection(sections): self.configureNestedCollection(with: cell, sections: sections)
            }
            self.cell.accept(cell)
            return cell
        }

        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { dataSource, index in
            let section = dataSource[index]
            return section.title
        }

        let dataSource = DataSource(configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
        return dataSource
    }()

    private func configureNestedCollection(with cell: UITableViewCell, sections: [CollectionSectionModel]) {
        guard let cell = cell as? CollectionContainableCell else { return }
        Observable.just(sections)
            .bind(to: cell.collectionView.rx.items(director: collectionDirector))
            .disposed(by: cell.disposeBag)
        cell.collectionView.rx.setDelegate(collectionDirector)
            .disposed(by: cell.disposeBag)
    }
}

extension TableDirector : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource[indexPath].rowHeight
    }
}
