//
//  CollectionDirector+Rx.swift
//  Example
//
//  Created by Goncharov Anton on 10/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import RxSwift

extension Reactive where Base: CollectionDirector {
    func cellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .map { $0.cell }
                .filterCast(T.self)
                .flatMapAndDisposeInCell(closure)
    }

    func cellCreated<T: ConfigurableCell,
        U,
        O: ObservableType>(_ cellType: T.Type, closure: @escaping (T, T.ViewModel) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(T.self)
                .flatMapAndDisposeInCell { closure($0.cell, $0.item) }
    }
}
