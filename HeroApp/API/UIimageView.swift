//
//  imagen.swift
//  HeroApp
//
//  Created by Noimposible on 11/09/20.
//  Copyright © 2020 Noimposible. All rights reserved.
//

import UIKit

extension UIImageView {
    func imagenCircular() {
        //self.layer.cornerRadius = self.bounds.width / 2
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
