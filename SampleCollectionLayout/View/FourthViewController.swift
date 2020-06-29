//
//  FIfthViewController.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/29.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var sampleCollectionView: UICollectionView! {
        didSet {
            self.sampleCollectionView.dataSource = self
            self.sampleCollectionView.collectionViewLayout = createLayout()
            self.sampleCollectionView.register(UINib(nibName: "DesignCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            sampleCollectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension FourthViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DesignCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
        header.setData(data: "Section\(indexPath.section)")
        return header
    }
    
}

extension FourthViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            //最小単位のアイテムのサイズ
            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            //グループ内でのアイテムのレイアウト
            let itemGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitem: leadingItem, count: 3)
            //グループそのもののレイアウト
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .fractionalHeight(0.3)),
                subitems: [itemGroup])
            //セクションにグループのレイアウトを適応
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            
            //セクションごとのヘッダーのレイアウト
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.05)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            //スクロールした時に上にヘッダーが張り付くかどうか
            sectionHeader.pinToVisibleBounds = false
            sectionHeader.zIndex = 2
            //セクションにヘッダーのレイアウトを適応
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
            
        }
        return layout
    }
    
}
