//
//  SizeChangeableCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxSwift

protocol SizeChangeableCell {
    var didChangeSize: Observable<Void> { get }
}
