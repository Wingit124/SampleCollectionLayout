//
//  ViewController.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/24.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private weak var sampleCollectionView: UICollectionView! {
        didSet {
            self.sampleCollectionView.dataSource = self
            self.sampleCollectionView.collectionViewLayout = createLayout()
            self.sampleCollectionView.register(UINib(nibName: "SampleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    private let data: [String] = {
        var d = [String]()
        for n in 0...200 {
            d.append("\(n)")
        }
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension FirstViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCell
        cell.setData(data: data[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

extension FirstViewController {
    //レイアウトを生成する処理
    private func createLayout() -> UICollectionViewLayout {
        //セルのサイズをで指定(group内での比率)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        //セルのサイズを設定
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //グループのサイズを指定(viewController内での比率)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.3))
        //グループのサイズ設定//表示するセルの設定//一行に表示するセルの個数設定
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

