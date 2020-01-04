//
//  CollectionDirector.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class CollectionDirector: NSObject {

    typealias DataSource = RxCollectionViewSectionedReloadDataSource<CollectionSectionModel>

    //TODO: rewrite to delegate
    private let cell = PublishRelay<UICollectionViewCell>()

    lazy var dataSource: DataSource = {

        let configureCell: DataSource.ConfigureCell = {(_, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.collectionReuseIdentifier, for: indexPath)
            item.configure(cell)
            self.cell.accept(cell)
            return cell
        }
        let dataSource = DataSource(configureCell: configureCell)
        return dataSource
    }()
}

extension CollectionDirector: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource[indexPath].itemSize
    }
}

extension CollectionDirector {
    //inner PublishRelay is created to guarantee that any Observable from cell will be disposed by cell's disposeBag
    func cellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return cell
                .filter { $0 is T }
                .map { $0 as! T }
                .flatMap { cell -> Observable<U> in
                    let newObservable = closure(cell)
                    let relay = PublishRelay<U>()
                    newObservable.asObservable()
                        .bind(to: relay)
                        .disposed(by: cell.disposeBag)
                    return relay.asObservable()
            }
    }
}
