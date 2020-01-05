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
    func cellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return cell
                .filterCast(T.self)
                .flatMapAndDisposeInCell(closure)
    }
}
