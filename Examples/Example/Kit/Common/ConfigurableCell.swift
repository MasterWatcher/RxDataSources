//
//  ConfigurableCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation

protocol ConfigurableCell: DisposableCell {

    associatedtype ViewModel

    func configure(with _: ViewModel)
}
