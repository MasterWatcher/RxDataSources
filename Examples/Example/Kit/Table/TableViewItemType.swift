//
//  ItemType.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit

protocol TableItemType {
    var tableReuseIdentifier: String { get }
    var rowHeight: CGFloat { get }
    func configure(_ cell: UITableViewCell)
}
