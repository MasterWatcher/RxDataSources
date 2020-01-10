//
//  UITableView+Rx.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

extension Reactive where Base: UITableView {
    func viewModelSelected<T>(_ modelType: T.Type) -> ControlEvent<T> {
         let source: Observable<T> = self.itemSelected.flatMap { [weak view = self.base as UITableView] indexPath -> Observable<T> in
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
        return (viewModel as? AnyTableItem)
            .flatMap { $0.item as? T }
    }

    func items<O: ObservableType>(director: TableDirector) -> (_ source: O) -> Disposable
        where O.E == [TableSectionModel] {
            items(dataSource: director.dataSource)
    }

    var updateSize: Binder<Void> {
        return Binder(self.base) { tableView, _ in
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            tableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: false)
        }
    }

    func configureKeyboard() -> Disposable {
        return NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillChangeFrame)
            .subscribe(onNext: { note in
                if let newFrame = (note.userInfo?[ UIKeyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
                    let insets = UIEdgeInsetsMake( 0, 0, newFrame.height, 0 )
                    self.base.contentInset = insets
                    self.base.scrollIndicatorInsets = insets
                }
            })
    }
}
