//
//  EpisodeTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 25/02/2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var sawItButton: UIButton!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setButtonAspect()
    }

    // MARK: - Configure

    func configure(for episode: EpisodeFormatted) {

        episodeNumberLabel.text = "Episode \(episode.episodeNumberFormatted)"
        episodeTitleLabel.text = "'\(episode.episodeNameFormatted)'"
    }

    // MARK: - Private

    private func setButtonAspect() {
        sawItButton.layer.borderWidth = 1
        sawItButton.layer.borderColor = UIColor.white.cgColor
        sawItButton.layer.cornerRadius = 10
    }

}
