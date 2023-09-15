//
//  FileManager-DocumentsDirectory.swift
//  CaptionMe
//
//  Created by Yuga Samuel on 15/09/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
