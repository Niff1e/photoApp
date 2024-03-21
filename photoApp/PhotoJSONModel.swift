//
//  PhotoJSONModel.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation

struct SuccessResponse: Decodable {
    let photoInfo: [PhotoInfo]
}

struct PhotoInfo: Decodable {
    let urls: URLs
}

struct URLs: Decodable {
    let regular: String
}

struct ErrorResponse: Decodable, Error {
    let errors: String
}
