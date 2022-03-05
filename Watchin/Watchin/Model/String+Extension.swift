//
//  String+Extension.swift
//  Watchin
//
//  Created by Archeron on 05/03/2022.
//

import Foundation

extension String {
    func hasAlphabeticalCharacters() -> Bool {
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }
}
