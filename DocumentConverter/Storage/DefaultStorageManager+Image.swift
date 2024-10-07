//
//  StorageManager+Image.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Foundation

extension DefaultStorageManager {


    func saveImage(_ imageDescriptor: ImageDescriptor) throws -> URL {
        let imageLocation = try imageLocation(
            for: imageDescriptor.name,
            fileExtension: imageDescriptor.imageExtension ?? Constants.defaultImageExtension.rawValue
        )
        try imageDescriptor.image.write(to: imageLocation, options: .atomic)
        return imageLocation
    }

    func image(for name: String, imageExtension: String? = Constants.defaultImageExtension.rawValue) throws -> Data {
        let imageLocation = try imageLocation(
            for: name,
            fileExtension: imageExtension ?? Constants.defaultImageExtension.rawValue
        )
        return try Data(contentsOf: imageLocation)
    }

    func removeArtwork(for name: String, imageExtension: String? = Constants.defaultImageExtension.rawValue) throws {
        let imageLocation = try imageLocation(
            for: name,
            fileExtension: imageExtension ?? Constants.defaultImageExtension.rawValue
        )
        try fileManager.removeItem(at: imageLocation)
    }

}
