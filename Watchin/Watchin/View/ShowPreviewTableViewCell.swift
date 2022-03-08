//
//  ShowPreviewTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 15/02/2022.
//

import UIKit

class ShowPreviewTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    

    // MARK: - Configure

    func configure(for show: ShowSearchDetail) {
        setImage(for: show)
        showTitleLabel.text = show.name
        countryLabel.text = "Country : \(show.country)"
    }

    // MARK: - Private

    private func setImage(for show: ShowSearchDetail) {
        let formattedImage = URL(string: show.imageStringUrl)
        if let imageUrl = formattedImage {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

}
