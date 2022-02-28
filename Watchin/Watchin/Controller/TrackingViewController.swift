//
//  TrackingViewController.swift
//  Watchin
//
//  Created by Archeron on 23/02/2022.
//

import UIKit

class TrackingViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var startDateStatusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var episodesNumberLabel: UILabel!
    @IBOutlet weak var seasonsNumberLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var startAgainButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var platformsButton: UIButton!

    // MARK: - Properties

    var show: ShowDetailFormatted?
    var episodes: [[EpisodeFormatted]] = []
    private let episodeDetailRepository = EpisodeDetailRepository.shared

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let show = show else {
            return
        }
        episodes = episodeDetailRepository.getEpisodes(for: show)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonAspect(for: startAgainButton)
        setButtonAspect(for: deleteButton)
        setButtonAspect(for: platformsButton)

        displayShowInfos()
    }

    // MARK: - Private

    private func displayShowInfos() {
        guard let show = show else {
            return
        }
        setImage()
        showTitleLabel.text = show.nameFormatted
        startDateStatusLabel.text = "\(show.startDateFormatted) - \(show.statusFormatted)"
        genresLabel.text = show.genresFormatted
        countryLabel.text = show.countryFormatted
        episodesNumberLabel.text = "Episodes : 0/\(show.numberOfEpisodes)"
        seasonsNumberLabel.text = "Seasons: 0/\(show.numberOfSeasons)"
    }

    private func setImage() {
        guard let show = show else {
            return
        }
        if let imageUrl = URL(string: show.imageStringUrlFormatted) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

    // MARK: - UI Aspect

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

}

    // MARK: - TableView Management
extension TrackingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard episodes.count > section else {
            return 0
        }
        return episodes[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }

        let episode = episodes[indexPath.section][indexPath.row]
        cell.configure(for: episode)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard episodes.count > section else {
            return nil
        }
        return "Season \(episodes[section].first?.seasonNumberFormatted ?? 0)"
    }
}

