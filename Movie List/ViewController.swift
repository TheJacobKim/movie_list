//
//  ViewController.swift
//  Movie List
//
//  Created by Jacob Kim on 10/21/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies: [NSDictionary]?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self // tell the tableview this view controller is supposed to provide the data for the tableview
        
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // API Key
        let endpoint = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let url = URL(string: endpoint)!
        
        let urlRequest = URLRequest(url: url)
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            // parse the result as JSON
            
            if let data = data {
                
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let movies = dataDictionary["results"] as? [NSDictionary] {
                        self.movies = movies
                        print(movies)
                        // you are in the background queue
                        DispatchQueue.main.async {
                            // update the UI in the main queue
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.movie = self.movies?[indexPath.row]
        return cell
    }
    
}





