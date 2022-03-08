//
//  WatchinShowTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit
import AlamofireImage

class WatchinShowTableViewCell: UITableViewCell {

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var watchedEpisodesLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!

    // MARK: - Configure

    func configure(for tvShow: ShowDetailFormatted, with watchedEpisodes: Int) {
        setImage(for: tvShow)
        showTitleLabel.text = tvShow.nameFormatted
        watchedEpisodesLabel.text = "Watched episodes:\n\(watchedEpisodes)/\(tvShow.numberOfEpisodes)"
        platformLabel.text = "On: \(tvShow.platformFormatted)"
    }

    // MARK: - Private

    private func setImage(for tvShow: ShowDetailFormatted) {
        if let imageUrl = URL(string: tvShow.imageStringUrlFormatted) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }
}
