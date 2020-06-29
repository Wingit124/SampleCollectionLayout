//
//  SecondViewController.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/25.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet private weak var sampleCollectionView: UICollectionView! {
        didSet {
            self.sampleCollectionView.dataSource = self
            self.sampleCollectionView.collectionViewLayout = createLayout()
            self.sampleCollectionView.register(UINib(nibName: "SampleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    private let data: [[String]] = {
        var d = [[String]]()
        for n in 0...2 {
            var d2 = [String]()
            for n2 in 0...11 {
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

extension SecondViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCell
        cell.setData(data: data[indexPath.section][indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

enum SectionLayoutKind: Int, CaseIterable {
    case list, grid2, grid3
    var columnCount: Int {
        switch self {
        case .grid2:
            return 2

        case .grid3:
            return 3

        case .list:
            return 1
        }
    }
}

extension SecondViewController {
    //セクションごとにレイアウトが異なるレイアウトを生成
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let columns = sectionLayoutKind.columnCount

            // The group auto-calculates the actual item width to make
            // the requested number of columns fit, so this widthDimension is ignored.
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.absolute(44) :
                NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section

        }
        return layout
    }
}
