//
//  UICollectionView+Rx.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

extension Reactive where Base: UICollectionView {
    func viewModelSelected<T>(_ modelType: T.Type) -> ControlEvent<T> {
         let source: Observable<T> = self.itemSelected.flatMap { [weak view = self.base as UICollectionView] indexPath -> Observable<T> in
            guard let view = view, let viewModel: T = view.rx.viewModel(at: indexPath) else {
                 return Observable.empty()
             }

             return Observable.just(viewModel)
         }

         return ControlEvent(events: source)
     }

    func viewModel<T>(at indexPath: IndexPath) -> T? {
        guard let dataSource = self.dataSource.forwardToDelegate() as? SectionedViewDataSourceType else { return nil }
        guard let viewModel = try? dataSource.model(at: indexPath) else { return nil }
        return (viewModel as? AnyCollectionItem)
            .flatMap { $0.item as? T }
    }

    func items<O: ObservableType>(director: CollectionDirector) -> (_ source: O) -> Disposable
        where O.E == [CollectionSectionModel] {
            items(dataSource: director.dataSource)
    }
}
