//
//  AnimationConfiguration+Extensions.swift
//  Example
//
//  Created by Goncharov Anton on 10/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import RxDataSources

extension AnimationConfiguration {

    static var none: AnimationConfiguration {
        AnimationConfiguration(insertAnimation: .none,
                               reloadAnimation: .none,
                               deleteAnimation: .none)
    }

    static var fade: AnimationConfiguration {
           AnimationConfiguration(insertAnimation: .fade,
                                  reloadAnimation: .fade,
                                  deleteAnimation: .fade)
       }

    static var shift: AnimationConfiguration {
        AnimationConfiguration(insertAnimation: .top,
                               reloadAnimation: .fade,
                               deleteAnimation: .top)
    }
}
