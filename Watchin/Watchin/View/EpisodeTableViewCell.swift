//
//  EpisodeTableViewCell.swift
//  Watchin
//
//  Created by Archeron on 25/02/2022.
//

import UIKit

protocol EpisodeTableViewCellActionDelegate: AnyObject {
    func sawItButtonTapped(in cell: EpisodeTableViewCell)
}

class EpisodeTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var sawItButton: UIButton!

    // MARK: - Property

    weak var delegate: EpisodeTableViewCellActionDelegate?

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setButtonBaseAspect()
    }

    // MARK: - Configure

    func configure(for episode: EpisodeFormatted) {

        episodeNumberLabel.text = "Episode \(episode.episodeNumberFormatted)"
        episodeTitleLabel.text = "'\(episode.episodeNameFormatted)'"
        updateSawItButtonAspect(of: episode)

    }

    @IBAction func sawItButtonTapped(_ sender: UIButton) {
        delegate?.sawItButtonTapped(in: self)
    }

    // MARK: - Private

    private func setButtonBaseAspect() {
        sawItButton.layer.borderWidth = 1
        sawItButton.layer.borderColor = UIColor.white.cgColor
        sawItButton.layer.cornerRadius = 10
        sawItButton.titleLabel?.numberOfLines = 1
    }

    private func updateSawItButtonAspect(of episode: EpisodeFormatted) {
        let hasBeenWatched = episode.hasBeenWatchedFormatted

        let title =  hasBeenWatched ? "Seen ✓" : "Saw it !"
        let color = hasBeenWatched ? UIColor.lightBlue : UIColor.white
        let backgroundColor = hasBeenWatched ? UIColor.white : UIColor.clear

        sawItButton.setTitle(title, for: .normal)
        sawItButton.setTitleColor(color, for: .normal)
        sawItButton.tintColor = color
        sawItButton.backgroundColor = backgroundColor
    }


}
