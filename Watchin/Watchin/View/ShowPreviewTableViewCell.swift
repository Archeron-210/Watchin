//
//  ShowPreviewTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 15/02/2022.
//

import UIKit

class ShowPreviewTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var showPosterImageView: UIImageView!
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
        if let imageUrl = URL(string: show.imageStringUrl) {
            showPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            showPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

}
