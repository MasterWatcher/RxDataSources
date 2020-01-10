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
            return base.cell
                .filterCast(T.self)
                .flatMapAndDisposeInCell(closure)
    }
}
