//
//  Example7_CollectionView.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MyCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageItem1 = ImageTitleCellViewModel(image: UIImage(named: "settings")!, title: "ONE")
        let imageItem2 = ImageTitleCellViewModel(image: UIImage(named: "settings")!, title: "TWO")
        let imageItem3 = ImageTitleCellViewModel(image: UIImage(named: "settings")!, title: "THREE")
        let buttonItem = ButtomCellViewModel(title: "Test")
        let sections: [CollectionSectionModel] = [
            CollectionSectionModel(items: [imageItem1, imageItem2, imageItem3, buttonItem])
        ]

        let director = CollectionDirector()

        Observable.just(sections)
            .bind(to: collectionView.rx.items(director: director))
            .disposed(by: disposeBag)
        collectionView.rx.setDelegate(director)
            .disposed(by: disposeBag)

        collectionView.rx.viewModelSelected(ImageTitleCellViewModel.self)
            .subscribe(onNext: { value in
                print(value.title)
            })
            .disposed(by: disposeBag)
        
        director.rx.cellCreated(ButtonCollectionViewCell.self) { $0.button.rx.tap }
            .subscribe(onNext: { _ in
                print("tap!")
            })
            .disposed(by: disposeBag)

    }

}
