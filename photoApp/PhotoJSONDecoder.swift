//
//  PhotoJSONDecoder.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

final class PhotoJSONDecoder: JSONDecoder {

    func decodeNewsJSON(from jsonData: Data,
                        completionHandler: @escaping (Result<SuccessResponse, ErrorResponse>) -> Void) {
        do {
            let result = try self.decode([PhotoInfo].self, from: jsonData)
            completionHandler(.success(SuccessResponse(photoInfo: result)))
        } catch {
            completionHandler(.failure(ErrorResponse(errors: "DataDecodingError!")))
        }
    }
}
