//
//  NestedCollectionTableCellViewModel.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import UIKit

protocol NestedCollectionTableCellViewModel: TableItemType, Equatable {

    associatedtype TableCellType: ConfigurableCell & CollectionContainableCell & UITableViewCell where TableCellType.ViewModel == Self

    var id: String { get }
    var nestedSections: [CollectionSectionModel] { get }
}

extension NestedCollectionTableCellViewModel {

    var identity: String { id }

    var tableReuseIdentifier: String { String(describing: TableCellType.self) }

    var rowHeight: CGFloat { UITableViewAutomaticDimension }

    var nestedType: NestedType { .collection(sections: nestedSections) }

    func configure(_ cell: UITableViewCell) { (cell as? TableCellType)?.configure(with: self) }
}
