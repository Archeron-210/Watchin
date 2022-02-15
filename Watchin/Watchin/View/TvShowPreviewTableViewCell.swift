//
//  TvShowPreviewTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 15/02/2022.
//

import UIKit

class TvShowPreviewTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    // MARK: - Configure

    func configure(for tvShow: TvShowPreview) {
        setImage(for: tvShow)
        showTitleLabel.text = tvShow.name
        countryLabel.text = "Country : \(tvShow.country)"
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
