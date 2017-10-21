//
//  MovieTableViewCell.swift
//  Movie List
//
//  Created by Jacob Kim on 10/21/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    /*
         Example API
         {"vote_count":2193,"id":346364,"video":false,"vote_average":7.4,"title":"It","popularity":735.101701,"poster_path":"\/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg","original_language":"en","original_title":"It","genre_ids":[12,18,27],"backdrop_path":"\/tcheoA2nPATCm2vvXw2hVQoaEFD.jpg","adult":false,"overview":"In a small town in Maine, seven children known as The Losers Club come face to face with life problems, bullies and a monster that takes the shape of a clown called Pennywise.","release_date":"2017-09-05"},
     
     */
    
    var movie: NSDictionary? {
        didSet {
            // Go to poster image URL
            let image_base_url = "https://image.tmdb.org/t/p/w342"
            if let url = URL(string: (self.movie?["poster_path"] as? String) ?? "") {
                if let imageData = try? Data(contentsOf: url) {
                    self.coverImageView.image = UIImage(data: imageData)
                }
            }
            // Get movie titles
            self.titleLabel.text = self.movie?["original_title"] as? String
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
