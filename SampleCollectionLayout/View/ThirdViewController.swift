//
//  ThirdViewController.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/27.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var sampleCollectionView: UICollectionView! {
        didSet {
            sampleCollectionView.dataSource = self
            sampleCollectionView.collectionViewLayout = createLayout()
            sampleCollectionView.register(UINib(nibName: "SampleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            sampleCollectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        }
    }
    
    private let data: [[String]] = {
        var d = [[String]]()
        for n in 0...5 {
            var d2 = [String]()
            for n2 in 0...10 {
                d2.append("S\(n):R\(n2)")
            }
            d.append(d2)
        }
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ThirdViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCell
        cell.setData(data: data[indexPath.section][indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
        header.setData(data: "Section\(indexPath.section)")
        return header
    }
    
}

extension ThirdViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        //セルのサイズをで指定(group内での比率)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        //セルのサイズを設定
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //グループのサイズを指定(viewController内での比率)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        //グループのサイズ設定//表示するセルの設定//一行に表示するセルの個数設定
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //セクションのレイアウト
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        //セクションごとのヘッダーのレイアウト
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalHeight(0.05)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top)
        //スクロールした時に上にヘッダーが張り付くかどうか
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        //セクションにヘッダーのレイアウトを適応
        section.boundarySupplementaryItems = [sectionHeader]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
