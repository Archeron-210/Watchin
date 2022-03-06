//
//  WatchinLaterTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 06/03/2022.
//

import UIKit

class WatchinLaterTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var platformNameLabel: UILabel!

    // MARK : - Configure

    func configure(for show: ShowDetailFormatted) {
        setImage(for: show)
        showTitleLabel.text = show.nameFormatted
        platformNameLabel.text = show.platformFormatted
    }

    // MARK: - Private

    private func setImage(for show: ShowDetailFormatted) {
        if let imageUrl = URL(string: show.imageStringUrlFormatted) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }
}
