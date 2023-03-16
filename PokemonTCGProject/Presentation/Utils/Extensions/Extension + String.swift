//
//  Extension + String.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func formattedDateFromString(inputFormat: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    func formatStringToCurrency() -> String? {
        if let costInteger = Int(self) {
            let costNum = NSNumber(value:costInteger)
           return  NumberFormatter.localizedString(
                from: costNum, number: .currency
            )
        }
        return ""
    }
    
    func search(_ term: String) -> Bool {
        let lowercasedSelf = self.lowercased()
        let lowercasedTerm = term.lowercased()
        return lowercasedSelf.localizedCaseInsensitiveContains(lowercasedTerm)
    }
}
