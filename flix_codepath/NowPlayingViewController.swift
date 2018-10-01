//
//  NowPlayingViewController.swift
//  flix_codepath
//
//  Created by SiuChun Kung on 8/31/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController,
    UITableViewDataSource,
    UITableViewDelegate
    {


    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
      var movies: [Movie]? = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 220
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        MovieApiManager().getNowPlayingMovies { (returned_movies: [Movie]?, error: Error?) in
            if let movies = returned_movies {
                self.movies = movies
                self.tableView.reloadData()

                // tell the activity indicator to stop
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        MovieApiManager().getNowPlayingMovies { (returned_movies: [Movie]?, error: Error?) in
            if let movies = returned_movies {
                self.movies = movies
                self.tableView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
            }
        }
    }
    
    func displayAlert() {
        let alertController = UIAlertController(title: "Cannot Get Movie", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
                // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                // add the cancel action to the alertController
        alertController.addAction(cancelAction)
                // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.tableView.reloadData()
                }
                // add the OK action to the alert controller
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let movies = self.movies {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
         cell.movie = self.movies![indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: cell)!
        detailViewController.movie = self.movies![indexPath.row]
    }
}
