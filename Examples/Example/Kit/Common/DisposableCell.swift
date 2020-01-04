//
//  DisposableCell.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxSwift

//You also need to override prepareForReuse and recreate disposeBag:
//override func prepareForReuse() {
//      super.prepareForReuse()
//      disposeBag = DisposeBag()
//  }
protocol DisposableCell {
    var disposeBag: DisposeBag { get }
}
