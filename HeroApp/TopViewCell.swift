//
//  TopViewCell.swift
//  HeroApp
//
//  Created by Noimposible on 10/09/20.
//  Copyright © 2020 Noimposible. All rights reserved.
//

import UIKit

class TopViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        name.font = UIFont.boldSystemFont(ofSize: 10)
        

        avatar.imagenCircular()

    }

}
