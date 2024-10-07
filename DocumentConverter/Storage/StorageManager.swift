//
//  Filemanager.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//


import Foundation
protocol StorageManager {
    func files() async throws -> Set<ShaprFile>
    @discardableResult
    func save(_ fileMeta: ShaprFile, with fileData: Data, type: FileType) throws -> ShaprFile
    func save(_ fileMeta: ShaprFile) throws
    func saveFiles()  throws
}
