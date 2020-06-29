//
//  NestCell.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/28.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class DesignCell: UICollectionViewCell {

    @IBOutlet private weak var contentImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.layer.cornerRadius = 10
        contentImage.layer.cornerRadius = 10
    }
    
    func setData(image: UIImage, title: String, subTitle: String) {
        
    }

}
