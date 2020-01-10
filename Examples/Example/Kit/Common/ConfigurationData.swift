//
//  ConfigurationData.swift
//  Example
//
//  Created by Goncharov Anton on 10/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation

protocol ConfigurationDataType {
    associatedtype T
    var cell: T { get }
}

struct ConfigurationData<T: ConfigurableCell>: ConfigurationDataType {
    let cell: T
    let item: T.ViewModel
}
