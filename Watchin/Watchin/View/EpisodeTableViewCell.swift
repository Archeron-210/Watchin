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

    // MARK: - Configure

    func configure(for episode: EpisodeInfo) {
        episodeTitleLabel.text = episode.name
        episodeNumberLabel.text = "Episode \(episode.episode)"
    }

    

}
