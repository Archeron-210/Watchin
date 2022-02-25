//
//  TrackingViewController.swift
//  Watchin
//
//  Created by Archeron on 23/02/2022.
//

import UIKit

class TrackingViewController: UIViewController {

    // MARK: - Outlet


    // MARK: - Properties

    var show: ShowDetailFormatted?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension TrackingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let show = show else {
            return 1
        }
        let numberOfSections = Int(show.numberOfSeasons) ?? 1
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let show = show, let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }

        // cell.configure(for: show.)


        return cell
    }


}

