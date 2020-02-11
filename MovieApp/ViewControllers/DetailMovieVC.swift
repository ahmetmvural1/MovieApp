//
//  DetailMovie.swift
//  MovieApp
//
//  Created by koineks teknoloji on 10.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift
import SVProgressHUD

class DetailMovieVC: UIViewController {
    
    var movieID = Int()
    var createdArray : [(name: String, gender:Int, profile_path: String)] = []
    var seasonsArray : [(air_date: String, episode_count:Int, name: String, poster_path: String)] = []
    var productionArray : [(logo_path: String,  name: String)] = []
    var section = [String]()
    var items = [[Any]]()
    var disposeBag = DisposeBag()
    
    
    @IBOutlet weak var favOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var detailPhoto: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getMovieDetail(movieID: movieID)
        //fav Button
        if UserDefaults.standard.array(forKey: "favMovieArray") != nil{
            favIDs = UserDefaults.standard.array(forKey: "favMovieArray") as! [Int]
        }
        if favIDs.contains(movieID) {
            favOutlet.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
            favOutlet.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        }else{
            favOutlet.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .light)
            favOutlet.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        }
        
    }
    

    func getMovieDetail(movieID:Int){
         let langcodeStr = Locale.preferredLanguages[0]
        ApiClient.shared.movieDetail(language: langcodeStr, movieID: movieID).observe(onStart: {
            SVProgressHUD.show()
        }, onEnd: {
            SVProgressHUD.dismiss()
        }, onSuccess: { (Result) in
            self.detailPhoto.sd_setImage(with: URL(string: imageURL + Result.backdrop_path))
            
            let desc =  Result.overview ==  "" ?   "Not Found" :   Result.overview
            self.movieDescription.text = desc
            
            Result.created_by.forEach { (created) in
                self.createdArray.append((name: created.name, gender: created.gender, profile_path: created.profile_path ?? ""))
            }
            
            Result.production_companies.forEach { (product) in
                self.productionArray.append((logo_path: product.logo_path ?? "", name: product.name))
            }
            
            Result.seasons.forEach { (season) in
                self.seasonsArray.append((air_date: season.air_date, episode_count: season.episode_count, name: season.name, poster_path: season.poster_path ?? ""))
            }
            
            if self.seasonsArray.count != 0 {
                self.section.append("Seasons")
                self.items.append(self.seasonsArray)
            }
            
            if self.productionArray.count != 0 {
                self.section.append("Productions")
                self.items.append(self.productionArray)
            }
            
            if self.createdArray.count != 0 {
                self.section.append("Createds")
                self.items.append(self.createdArray)
            }
            
            self.tableView.reloadData()
        }) { (error) in
            self.alert(message: error.localizedDescription)
        }
    }
    
    @IBAction func favButton(_ sender: Any) {
        if UserDefaults.standard.array(forKey: "favMovieArray") != nil{
            favIDs = UserDefaults.standard.array(forKey: "favMovieArray") as! [Int]
        }
        
        if favIDs.contains(movieID) {
            favIDs.remove(element: movieID)
            favOutlet.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .light)
            favOutlet.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        }else{
            favIDs.append(movieID)
            favOutlet.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
            favOutlet.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        }
        UserDefaults.standard.set(favIDs, forKey: "favMovieArray")
    }
    

}
extension DetailMovieVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailCell
        cell.backgroundColor = UIColor.white
        switch (indexPath.section) {
            case 0:
                
                cell.detailImage?.sd_setImage(with: URL(string: imageURL + seasonsArray[indexPath.row].poster_path), placeholderImage: UIImage(named:"notfound"))
                cell.detailTitle.text = seasonsArray[indexPath.row].name
                cell.dateTitle.text = "Date: " + seasonsArray[indexPath.row].air_date
                cell.episodeTitle.text = "Number of Episodes: \(seasonsArray[indexPath.row].episode_count)"
            case 1:
                cell.detailImage?.sd_setImage(with: URL(string: imageURL + productionArray[indexPath.row].logo_path), placeholderImage: UIImage(named:"notfound"))
                cell.detailTitle.text = productionArray[indexPath.row].name
                cell.dateTitle.text = ""
                cell.episodeTitle.text = ""
               
            case 2:
                cell.detailImage?.sd_setImage(with: URL(string: imageURL + createdArray[indexPath.row].profile_path), placeholderImage: UIImage(named:"notfound"))
                cell.detailTitle.text = createdArray[indexPath.row].name
                cell.dateTitle.text = ""
                cell.episodeTitle.text = ""
                if createdArray[indexPath.row].gender == 1{
                    cell.backgroundColor = #colorLiteral(red: 1, green: 0.6597603749, blue: 0.8200548699, alpha: 1)
                }else{
                    cell.backgroundColor = #colorLiteral(red: 0.5864896863, green: 0.7905249644, blue: 1, alpha: 1)
                }
            default:
                cell.detailImage?.sd_setImage(with: URL(string: imageURL + createdArray[indexPath.row].profile_path), placeholderImage: UIImage(named:"notfound"))
                cell.detailTitle.text = createdArray[indexPath.row].name
                cell.dateTitle.text = ""
                cell.episodeTitle.text = ""
         }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.94)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor =  UIColor(red: 0.52, green: 0.38, blue: 0.79, alpha: 1)
        header.textLabel?.font = UIFont(name: "Futura-Medium", size: 13)
    
    }
}
