//
//  Filemanager+.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//
import Foundation

enum FileManagerError: Error {
    case invalidPath(String)
    case enumerationError(Error?)
    case other(String)
}

extension FileManager {
    
    func path(for appRootPath: String) throws -> URL {
        let libraryDirectory = try url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return libraryDirectory.appendingPathComponent(appRootPath)
    }

    func safePath(_ path: String) -> String {
        path.components(separatedBy: .symbols).joined()
    }

    func getSizeOnDisk(for path: String, isDirectory: Bool = true) throws -> UInt64 {
        // check if file/path exists in file system
        guard fileExists(atPath: path) else {
            throw FileManagerError.invalidPath("File not exists at \(path).")
        }

        // create path url from path string
        let pathURL = URL(fileURLWithPath: path, isDirectory: isDirectory)

        // file size resource keys
        let fileSizeResourceKeys: Set<URLResourceKey> = [.fileAllocatedSizeKey, .totalFileAllocatedSizeKey]

        // Calculate size for a file if give path is not directory
        if !isDirectory {
            return try pathURL.fileSize(using: fileSizeResourceKeys)
        }

        // enumerate all directory and subdirectories content
        var fileEnumeratorError: Error?
        enumerator(atPath: path)
        guard let fileEnumerator = enumerator(
            at: pathURL,
            includingPropertiesForKeys: Array(fileSizeResourceKeys),
            options: [],
            errorHandler: { _, error in
                fileEnumeratorError = error
                return false
            }
        ) else {
            throw FileManagerError.enumerationError(fileEnumeratorError)
        }

        // variable to sum up all file size available in directory and subdirectories
        var accumulatedSize: UInt64 = 0

        // enumerate all directories
        for file in fileEnumerator {
            // break enumeration on error
            if fileEnumeratorError != nil {
                break
            }

            // calculate and sum up individual file size
            if let fileURL = file as? URL {
                accumulatedSize += try fileURL.fileSize(using: fileSizeResourceKeys)
            }
        }

        // throw error if file enumerator was failed
        if let fileEnumeratorError = fileEnumeratorError {
            throw FileManagerError.enumerationError(fileEnumeratorError)
        }

        // return size
        return accumulatedSize
    }

}
