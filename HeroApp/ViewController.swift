//
//  ViewController.swift
//  HeroApp
//
//  Created by Noimposible on 10/09/20.
//  Copyright © 2020 Noimposible. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class ViewController: UIViewController {
    
    
    var heroesList = [Hero]()
    var heroesTop = [Hero]()

    
    @IBOutlet weak var datoBusqueda: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBuscar: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        LoadData(dato:datoBusqueda.text)
        
        tableView.dataSource = self
        tableView.delegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TopViewCell", bundle: nil), forCellWithReuseIdentifier: "topCell")
                
    }
    
    

    func LoadData(dato:String!){
        heroesList = []
        DispatchQueue.main.async {
            var DatoBusqueda :String
            if (dato!.isEmpty){
                self.heroesTop = []
                debugPrint("INICIO CONSULTA API")
                DatoBusqueda =  self.randomString()
                debugPrint(DatoBusqueda)
            }else{
                DatoBusqueda = dato ?? self.randomString()
            }
            AF.request("https://www.superheroapi.com/api.php/10156112965520834/search/\(DatoBusqueda)").responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    var i :Int = 0
                    let json = JSON(value)
                    for item in json["results"] {
                        
                        i = i+1
                        let name = item.1["name"].string ?? ""
                        let image = item.1["image"]["url"].string ?? ""
                        let full_name = item.1["biography"]["full-name"].string ?? ""
                        let alter_egos = item.1["biography"]["alter-egos"].string ?? ""
                        let aliases = item.1["biography"]["aliases"][0].string ?? ""
                        let group_affiliation = item.1["connections"]["group-affiliation"].string ?? ""
                        let relatives = item.1["connections"]["relatives"].string ?? ""
                        
                        if i < 5{
                            self.heroesTop.append(Hero(numero: i, name: name, image: image, full_name: full_name, alter_egos: alter_egos, aliases: aliases, group_affiliation: group_affiliation, relatives: relatives))
                        }
                        debugPrint(name)
                        self.heroesList.append(Hero(numero: i, name: name, image: image, full_name: full_name, alter_egos: alter_egos, aliases: aliases, group_affiliation: group_affiliation, relatives: relatives))
                                            
                    }
                    self.tableView?.reloadData()
                    self.collectionView?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
    }
    
    @IBAction func buscarHeroeApi(_ sender: Any) {
        LoadData(dato:datoBusqueda.text)
        self.hideKeyboard()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<1).map{ _ in letters.randomElement()! })
    }
    
}

// MARK: Tabla
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellHero")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellHero")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 28)
            cell?.accessoryType = .disclosureIndicator
        }
        let heroes = heroesList[indexPath.row]
        
        cell!.textLabel?.text = heroes.name
        return cell!
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section) -> \(indexPath.row) \(heroesList[indexPath.row]) ")
        let heroTop = self.heroesList[indexPath.row]
        let heroDetailView = HeroDetailView()
        heroDetailView.hero = heroTop
        self.present(heroDetailView, animated: true)
        
        
    }
}



// MARK: ControllerView
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroesTop.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as? TopViewCell
        
        let heroTop = heroesTop[indexPath.row]
        cell!.name?.text = heroTop.name
        cell!.avatar.sd_setImage(with: URL(string: heroTop.image ?? "" ), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell!
        
    }
    
}


extension ViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let heroTop = heroesTop[indexPath.row]
        debugPrint("\(indexPath.section) -> \(indexPath.row) \(heroesTop[indexPath.row]) ")
        debugPrint("-------------")
        debugPrint(heroTop.name!)
        debugPrint("-------------")
        let heroDetailView = HeroDetailView()
        heroDetailView.hero = heroTop
        self.present(heroDetailView, animated: true)
    }
}

