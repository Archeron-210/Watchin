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

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }



    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
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

    // MARK: - Keyboard Management

extension EditProfileViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        userNameTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

    // MARK: - Image and Navigation management

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func choosePictureButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
        picker.dismiss(animated: true)
    }
}

