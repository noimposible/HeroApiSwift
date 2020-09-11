//
//  HeroDetailView.swift
//  HeroApp
//
//  Created by Noimposible on 10/09/20.
//  Copyright © 2020 Noimposible. All rights reserved.
//

import UIKit

class HeroDetailView: UIViewController {
    var hero: Hero?
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nreal: UILabel!
    @IBOutlet weak var alter: UILabel!
    @IBOutlet weak var alias: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grupo: UITextView!
    @IBOutlet weak var pariente: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar.imagenCircular()
        name.text = (hero?.name)
        nreal.text = (hero?.full_name)
        alter.text = (hero?.alter_egos)
        alias.text = (hero?.aliases)
        grupo.text = (hero?.group_affiliation)
        pariente.text = (hero?.relatives)
       
        avatar.sd_setImage(with: URL(string: hero!.image ?? "" ), placeholderImage: UIImage(named: "placeholder.png"))

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
