//
//  ShowResultDetailsViewController.swift
//  Watchin
//
//  Created by Archeron on 11/02/2022.
//

import UIKit

class ShowResultDetailsViewController: UIViewController {

    // MARK: - Properties

    var tvShow: TvShowPreview?

    // MARK: - Outlets
    

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions

    // MARK: - Private

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

}
