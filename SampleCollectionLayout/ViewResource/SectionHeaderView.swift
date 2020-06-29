//
//  SectionHeaderView.swift
//  SampleCollectionLayout
//
//  Created by 高橋翼 on 2020/06/27.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: String) {
        self.label.text = data
        backgroundColor = .systemBackground
    }
    
}
