//
//  Hero.swift
//  HeroApp
//
//  Created by Noimposible on 10/09/20.
//  Copyright © 2020 Noimposible. All rights reserved.
//

import Foundation

class Hero {
   
    var numero : Int?
    var name : String?
    var image : String?
    var full_name : String?
    var alter_egos : String?
    var aliases : String?
    var group_affiliation : String?
    var relatives : String?
   
   
    init (numero: Int,name: String?,image: String?,full_name: String?,alter_egos: String?, aliases:String? ,group_affiliation: String?,relatives: String?){
        self.numero = numero
        self.name = name
        self.image = image
        self.full_name = full_name
        self.alter_egos = alter_egos
        self.aliases = aliases
        self.group_affiliation = group_affiliation
        self.relatives = relatives
    }
}
