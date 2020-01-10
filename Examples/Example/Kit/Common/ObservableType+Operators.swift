//
//  ObservableType+Rx.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func filterCast<T>(_ type: T.Type) -> Observable<T> {
        filter { $0 is T }
            .map { $0 as! T }
    }
}

extension ObservableType where E: DisposableCell {
    //Guarantee that any Observable from cell will be disposed by cell's disposeBag
    func flatMapAndDisposeInCell<U, O: ObservableType>(_ selector: @escaping (E) -> O) -> Observable<U> where O.E == U {
        flatMap { cell -> Observable<U> in
            let newObservable = selector(cell)
            let relay = PublishRelay<U>()
            newObservable.asObservable()
                .bind(to: relay)
                .disposed(by: cell.disposeBag)
            return relay.asObservable()
        }
    }
}


extension ObservableType where E: CollectionContainableCell {
    //Guarantee that any Observable from cell will be disposed by cell's disposeBag
    func flatMapAndDisposeInCell<U, O: ObservableType>(_ selector: @escaping (E) -> O) -> Observable<U> where O.E == U {
        flatMap { cell -> Observable<U> in
            let newObservable = selector(cell)
            let relay = PublishRelay<U>()
            newObservable.asObservable()
                .bind(to: relay)
                .disposed(by: cell.disposeBag)
            return relay.asObservable()
        }
    }
}
