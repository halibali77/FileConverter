//
//  DefaultStorageManager+Directories.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//
import Foundation

extension DefaultStorageManager {

    func filesLocation() throws -> URL {
        let rootDirectory = try fileManager.path(for: Constants.rootPath.rawValue)
        if !fileManager.fileExists(atPath: rootDirectory.path) {
            try fileManager.createDirectory(at: rootDirectory, withIntermediateDirectories: true)
        }
        return rootDirectory.appendingPathComponent(Constants.files.rawValue)
    }

    func imageLocation(for name: String, fileExtension: String = Constants.defaultImageExtension.rawValue ) throws -> URL {
        let imageDirectory = try fileManager.path(for: Constants.rootPath.rawValue)
            .appendingPathComponent(Constants.imagePath.rawValue)

        if !fileManager.fileExists(atPath: imageDirectory.path()) {
            try fileManager.createDirectory(at: imageDirectory, withIntermediateDirectories: true)
        }

        return imageDirectory
            .appendingPathComponent(fileManager.safePath(name))
            .appendingPathExtension(fileExtension)
    }

}
