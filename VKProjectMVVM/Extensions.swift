//
//  Extensions.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 14.04.2022.
//

import Foundation

//MARK: - Extension for Encodable

extension Encodable {
    var asJson: Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return jsonData
        } catch {
            return nil
        }
    }
}
