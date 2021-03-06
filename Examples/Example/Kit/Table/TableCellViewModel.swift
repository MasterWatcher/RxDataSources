//
//  CellViewModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import UIKit

protocol TableCellViewModel: TableItemType, Equatable {

    associatedtype TableCellType: ConfigurableCell & UITableViewCell where TableCellType.ViewModel == Self

    var id: String { get }
}

extension TableCellViewModel {

    var tableReuseIdentifier: String { String(describing: TableCellType.self) }

    var rowHeight: CGFloat { UITableViewAutomaticDimension }

    var nestedType: NestedType { .none }

    func configure(_ cell: UITableViewCell) { (cell as? TableCellType)?.configure(with: self) }
}
