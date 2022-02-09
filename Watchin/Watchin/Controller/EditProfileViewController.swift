//
//  EditProfileViewController.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var choosePictureButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setProfilePictureAspect()
        setButtonAspect(for: choosePictureButton)
        setButtonAspect(for: saveChangesButton)
        setButtonAspect(for: exitButton)
        setTextFieldAspect()

    }

    // MARK: - Actions

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: - Private

    private func setProfilePictureAspect() {
        profilePictureImageView.layer.borderWidth = 3
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.clipsToBounds = true
    }

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

    private func setTextFieldAspect() {
        userNameTextField.setBottomBorderAndPlaceholderTextColor()
    }

}
