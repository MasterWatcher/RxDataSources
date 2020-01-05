//
//  TableDirector+Rx.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import RxSwift

extension Reactive where Base: TableDirector {
    func cellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return base.cell
                .filterCast(T.self)
                .flatMapAndDisposeInCell(closure)
    }

    func cellSizeChanged<T: DisposableCell & SizeChangeableCell>(_ cellType: T.Type) -> Observable<Void> {
        return base.cell
            .filterCast(T.self)
            .flatMapAndDisposeInCell { $0.didChangeSize }
    }

    func nestedCellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            base.collectionDirector.cellCreated(T.self, closure: closure)
    }
}