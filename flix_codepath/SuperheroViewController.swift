//
//  SuperheroViewController.swift
//  flix_codepath
//
//  Created by SiuChun Kung on 9/6/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController,
    UICollectionViewDataSource{
    
      var movies: [Movie]? = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Superhero"
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        MovieApiManager().getSuperheroMovies{ (returned_movies: [Movie]?, error: Error?) in
            if let movies = returned_movies {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.movie = self.movies?[indexPath.row]
        return cell
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView.indexPath(for: cell)!
        detailViewController.movie = self.movies![indexPath.row]
    }

}
