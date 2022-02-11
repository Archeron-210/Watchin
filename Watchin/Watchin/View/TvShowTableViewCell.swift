//
//  TvShowTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit
import AlamofireImage

class TvShowTableViewCell: UITableViewCell {

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var watchedEpisodesLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(for tvShow: TvShowPreview) {
        if let imageUrl = tvShow.imageUrl {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        }
        tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        showTitleLabel.text = tvShow.name
        watchedEpisodesLabel.text = tvShow.watchedEpisodes
        platformLabel.text = tvShow.platformAssociated
    }

}
