//
//  EmbedCollectionCell.swift
//  Example
//
//  Created by Goncharov Anton on 05/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit
import RxSwift

struct EmbedCollectionCellViewModel: NestedCollectionTableCellViewModel {

    typealias TableCellType = EmbedCollectionCell

    let id: String
    let nestedSections: [CollectionSectionModel]
    let rowHeight: CGFloat = 72
}

class EmbedCollectionCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var embedCollectionView: UICollectionView!

    var disposeBag = DisposeBag()

    func configure(with viewModel: EmbedCollectionCellViewModel) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 72, height: 72)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
    }

    override func prepareForReuse() {
           super.prepareForReuse()
           disposeBag = DisposeBag()
       }
}

extension EmbedCollectionCell: CollectionContainableCell {
    var collectionView: UICollectionView {
        embedCollectionView
    }
}
