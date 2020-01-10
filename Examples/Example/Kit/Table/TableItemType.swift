//
//  ItemType.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxDataSources

enum NestedType {
    case none
    case collection(sections: [CollectionSectionModel])
}

protocol TableItemType {
    
    var id: String { get }
    var tableReuseIdentifier: String { get }
    var rowHeight: CGFloat { get }
    var nestedType: NestedType { get }

    func configure(_ cell: UITableViewCell)
    
    func isEqualTo(_ other: TableItemType) -> Bool
}

extension TableItemType where Self: Equatable {
    func isEqualTo(_ other: TableItemType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}
