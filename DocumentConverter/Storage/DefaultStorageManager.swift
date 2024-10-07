//
//  DefaultFileM.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Foundation
final class DefaultStorageManager {
    enum Constants: String {
        case defaultImageExtension = "png"
        case files = "files.json"
        case imagePath = "images"
        case rootPath = "storageManager"
    }

    struct ImageDescriptor {
        let image: Data
        let imageExtension: String?
        let name: String

        init(image: Data,
             imageExtension: String? = Constants.defaultImageExtension.rawValue,
             name: String) {
            self.image = image
            self.imageExtension = imageExtension
            self.name = name
        }

    }

    var files: Set<ShaprFile> = [] {
        didSet {
            saveFiles()
        }
    }
    let fileManager: FileManager = .default

    init() {
    }


}

extension DefaultStorageManager: StorageManager {
}
