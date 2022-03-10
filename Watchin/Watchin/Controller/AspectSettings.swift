//
//  AspectSettings.swift
//  Watchin
//
//  Created by Archeron on 08/03/2022.
//

import Foundation
import UIKit

class AspectSettings {

    static let shared = AspectSettings()

    func setButtonBasicAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.numberOfLines = 1
    }

    func setButtonOnWhiteBackgroundAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightBlue.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.numberOfLines = 1
    }

    func setTextFieldAspect(for textField: UITextField) {
        textField.setBottomBorderAndPlaceholderTextColor()
    }

    func setProfilePictureAspect(for profilePictureImageView: UIImageView) {
        profilePictureImageView.layer.borderWidth = 3
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.clipsToBounds = true
    }

    func setContainerViewAspect(for containerView: UIView) {
        containerView.layer.cornerRadius = 10
    }

    func setImage(for show: ShowDetailFormatted, on imageView: UIImageView) {
        if let imageUrl = URL(string: show.imageStringUrlFormatted) {
            imageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            imageView.image = UIImage(named: "watchinIcon")
        }
    }

    func setLabelForPicker(for label: UILabel, with title: String) {
        label.text = title
        label.font = UIFont(name: "Kohinoor Telugu", size: 25)
        label.textColor = UIColor.lightBlue
        label.textAlignment = .center
    }

    func setAlertTitleAspect(for alert: UIAlertController) -> NSAttributedString {

        let attributedString = NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu Medium", size: 20) ?? UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.lightBlue])
        return attributedString
    }

    func setAlertMessageAspect(for alert: UIAlertController) -> NSAttributedString {

        let attributedString = NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 15) ?? UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.lightBlue])
        return attributedString
    }


}
