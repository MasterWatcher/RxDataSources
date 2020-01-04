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

    //TODO: rewrite to delegate
    private let cell = PublishRelay<UITableViewCell>()

    lazy var dataSource: DataSource = {

        let configureCell: DataSource.ConfigureCell = {(_, tableView, _, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.tableReuseIdentifier)!
            item.configure(cell)
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
}

extension TableDirector : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource[indexPath].rowHeight
    }
}

extension TableDirector {
    //inner PublishRelay is created to guarantee that any Observable from cell will be disposed by cell's disposeBag
       func cellCreated<T: DisposableCell,
           U,
           O: ObservableType>
           (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
           where O.E == U {
           return cell
               .filter { $0 is T }
               .map { $0 as! T }
               //TODO: move flatMap with PublishRelay to different operator
               .flatMap { cell -> Observable<U> in
                   let newObservable = closure(cell)
                   let relay = PublishRelay<U>()
                   newObservable.asObservable()
                       .bind(to: relay)
                       .disposed(by: cell.disposeBag)
                   return relay.asObservable()
           }
       }

        //TODO: remove parameter and call for every cell that implements DisposableCell & SizeChangeableCell
       //inner PublishRelay is created to guarantee that any Observable from cell will be disposed by cell's disposeBag
       func cellSizeChanged<T: DisposableCell & SizeChangeableCell>(_ cellType: T.Type) -> Observable<Void> {
           return cell
               .filter { $0 is T }
               .map { $0 as! T }
               .flatMap { cell -> Observable<Void> in
                   let newObservable = cell.didChangeSize
                   let relay = PublishRelay<Void>()
                   newObservable.asObservable()
                       .bind(to: relay)
                       .disposed(by: cell.disposeBag)
                   return relay.asObservable()
           }
       }
}
