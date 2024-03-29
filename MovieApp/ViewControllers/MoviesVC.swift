//
//  ViewController.swift
//  MovieApp
//
//  Created by koineks teknoloji on 7.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SVProgressHUD
import FontAwesome_swift

class MoviesVC: UIViewController,UICollectionViewDelegate,UIScrollViewDelegate , UICollectionViewDelegateFlowLayout {
    var pageNumber = 1
    var disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies(page: pageNumber)
        if UserDefaults.standard.array(forKey: "favMovieArray") != nil{
            favIDs = UserDefaults.standard.array(forKey: "favMovieArray") as! [Int]
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
  
    
    func getMovies(page:Int){
        let langcodeStr = Locale.preferredLanguages[0]
        
        ApiClient.shared.listMovie(language: langcodeStr, page: page).observe(onStart: {
            SVProgressHUD.show()
        }, onEnd: {
            SVProgressHUD.dismiss()
        }, onSuccess: { (movies) in

            total_pages = movies.total_pages
            movies.results.forEach { (result) in
                MovieArray.append((id: result.id,
                                   name: result.name,
                                   poster_path: result.poster_path,
                                   vote_average: result.vote_average))
               
                
            }
            self.collectionView.delegate = nil
            self.collectionView.dataSource = nil
            self.CollectionViewSource()
        }) { (error) in
            self.alert(message: error.localizedDescription)
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
            let detailMovie = segue.destination as? DetailMovieVC{
            
                let cell = sender as! listCell
                let indexPath = collectionView.indexPath(for: cell)
               
            detailMovie.movieID = MovieArray[indexPath!.row].id
            detailMovie.title = MovieArray[indexPath!.row].name

        }
    }

    func CollectionViewSource(){
    
        let items = Observable.just(
            (0..<MovieArray.count).map { "\($0)" }
        )
        
        items.asObservable().bind(to: self.collectionView.rx.items(cellIdentifier: "listCell", cellType: listCell.self)) { row, data, cell in
                
                   cell.movieDesc.text = MovieArray[row].name
                   cell.movieRate.text = String(MovieArray[row].vote_average)
                   cell.movieImage.sd_setImage(with: URL(string: imageURL + MovieArray[row].poster_path))
            
            //favs
            if favIDs.contains(MovieArray[row].id) {
                cell.favIcon.image = UIImage.fontAwesomeIcon(name: .star, style: .solid, textColor: .yellow, size: CGSize(width: 40, height: 40), backgroundColor: .clear, borderWidth: 0, borderColor: .clear)
                
            }else{
                cell.favIcon.image = UIImage.fontAwesomeIcon(name: .star, style: .light, textColor: .yellow, size: CGSize(width: 40, height: 40), backgroundColor: .clear, borderWidth: 0, borderColor: .clear)
            }
            
           
           //pagging
            if row == MovieArray.count - 4  && self.pageNumber != total_pages{
                self.pageNumber += 1
                self.getMovies(page: self.pageNumber)
                }
            }.disposed(by: disposeBag)
       
            
            collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }


}

