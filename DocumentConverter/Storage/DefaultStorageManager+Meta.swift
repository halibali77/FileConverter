//
//  DefaultStorageManager+Meta.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//
import Foundation

extension DefaultStorageManager {
    func files() async throws -> Set<ShaprFile> {
        let filesLocation = try filesLocation()
        let files = try Data(contentsOf: filesLocation)
        return try JSONDecoder()
            .decode(Set<ShaprFile>.self, from: files)            
    }

    func saveFiles()  {
        do {            
            let filesEncoded = try JSONEncoder().encode(files)
            let filesLocation = try filesLocation()
            try filesEncoded.write(to: filesLocation, options: .atomic)
        } catch {
            debugPrint("[\(#fileID)] Unable to save file list \(error)")
        }
    }

    func remove(for name: String) {
        files
            .filter { $0.descriptor.name == name }
            .forEach { files.remove($0) }
    }

    @discardableResult
    func save(_ fileMeta: ShaprFile, with fileData: Data, type: FileType) throws -> ShaprFile {
        let imageUrl =  try saveImage(.init(image: fileData, name: fileMeta.descriptor.name+type.rawValue))
        let imageSize = try? FileManager.default.getSizeOnDisk(for: imageUrl.absoluteString)
        let updatedFile = fileMeta.file(with: imageUrl,
                                        size: Double(imageSize ?? 0),
                                        type: type)
        files.insert(updatedFile)
        return updatedFile
    }

    func save(_ fileMeta: ShaprFile) throws {
        files.insert(fileMeta)
    }
}
