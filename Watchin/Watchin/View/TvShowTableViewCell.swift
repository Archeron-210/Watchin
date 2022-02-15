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

    func configure(for tvShow: TvShowPreview) {
        setImage(for: tvShow)
        showTitleLabel.text = tvShow.name
        watchedEpisodesLabel.text = tvShow.watchedEpisodes
        platformLabel.text = tvShow.platformAssociated
    }

    // MARK: - Private

    private func setImage(for tvShow: TvShowPreview) {
        if let imageUrl = tvShow.imageUrl {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }
}
