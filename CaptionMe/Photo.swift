//
//  Photo.swift
//  CaptionMe
//
//  Created by Yuga Samuel on 15/09/23.
//

import Foundation

class Photo: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
