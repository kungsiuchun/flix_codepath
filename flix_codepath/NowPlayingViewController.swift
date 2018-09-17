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
    
    
    
    var movies: [[String: Any]] = []
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
        
        
        
        fetchMovies()
        
    }
    
    
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        fetchMovies()
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
                    self.fetchMovies()
                }
                // add the OK action to the alert controller
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
   
    func fetchMovies() {
        activityIndicator.startAnimating()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request return
            if let error = error {
                self.displayAlert()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        tableView.deselectRow(at: indexPath, animated: true)
        
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
        let indexPath = self.tableView.indexPath(for: cell)
        let movie = movies[(indexPath?.row)!]
        
        detailViewController.myTitle = movie["title"] as! String
        detailViewController.overView = movie["overview"] as! String
        detailViewController.Date = movie["release_date"] as! String
        detailViewController.vote_average = movie["vote_average"] as? NSNumber
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        let backdrop_path = movie["backdrop_path"] as! String
        let backDropUrl = URL(string: baseURLString + backdrop_path)!
        detailViewController.posterUrl = posterURL
        detailViewController.backDropUrl = backDropUrl
    }
    
}
