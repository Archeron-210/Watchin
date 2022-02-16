//
//  ShowResultDetailsViewController.swift
//  Watchin
//
//  Created by Archeron on 11/02/2022.
//

import UIKit

class ShowResultDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var seasonCountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addToYourShowsButton: UIButton!
    @IBOutlet weak var addToWatchinLaterButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!

    // MARK: - Properties

    var tvShow: TvShowInfo?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonAspect(for: addToYourShowsButton)
        setButtonAspect(for: addToWatchinLaterButton)
        setButtonAspect(for: seeMoreButton)

        displayShowDetails()
    }

    // MARK: - Actions
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        goToWebsite()
    }

    // MARK: - Private

    private func displayShowDetails() {
        guard let tvShow = tvShow else {
            return
        }

        setImage()
        showTitleLabel.text = tvShow.name
        yearLabel.text = "(\(formattedDate(tvShow.startDate)))"
        genresLabel.text = formattedGenres(from: tvShow.genres)
        countryLabel.text = "Country : \(tvShow.country)"
        seasonCountLabel.text = "\(getNumberOfSeasons(of: tvShow.episodes)) Seasons"
        statusLabel.text = "Status : \(tvShow.status)"
        descriptionLabel.text = formattedDescription(tvShow.description)
    }

    private func setImage() {
        guard let tvShow = tvShow else {
            return
        }
        if let imageUrl = URL(string: tvShow.imageStringUrl) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

    private func goToWebsite() {
        guard let tvShow = tvShow else {
            return
        }
        guard let url = URL(string: tvShow.descriptionSource ?? "") else {
            searchOnGoogle()
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func searchOnGoogle() {
        guard let tvShow = tvShow else {
            return
        }
        let formattedTvShowName = replaceWhitespacesWithPlus(for: tvShow.name)
        let defaultStringUrl = "https://www.google.com/search?q=\(formattedTvShowName)"
        guard let defaultUrl = URL(string: defaultStringUrl) else {
            return
        }
        UIApplication.shared.open(defaultUrl, options: [:], completionHandler: nil)
    }

    // MARK: - Formatting functions

    private func formattedDescription(_ description: String) -> String {
        return description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    private func formattedDate(_ date: String) -> String {
        return String(date.prefix(4))
    }

    private func formattedGenres(from genresArray: [String]) -> String {
        return genresArray.joined(separator: ", ")
    }

    private func getNumberOfSeasons(of array: [EpisodeInfo]) -> String {
        let seasonNumber = array.map{$0.season}.max() ?? 0
        let formattedSeasonNumber = String(seasonNumber)
        return formattedSeasonNumber
    }

    private func replaceWhitespacesWithPlus(for text: String) -> String {
        return text.replacingOccurrences(of: " ", with: "+")
    }

    // MARK: - UI Aspect

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

}
