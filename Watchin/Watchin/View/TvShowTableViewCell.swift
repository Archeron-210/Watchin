//
//  TvShowTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit

class TvShowTableViewCell: UITableViewCell {

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var watchedEpisodesLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(poster: String, showTitle: String, watchedEpisodes: String, platform: String) {
        tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        showTitleLabel.text = showTitle
        watchedEpisodesLabel.text = watchedEpisodes
        platformLabel.text = platform
    }

}
