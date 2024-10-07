//
//  DefaultFilelistViewModel.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine

final class DefaultFilelistViewModel {
    let storeManager: StorageManager
    let conversionManager: ConversionManager
    var files: [ShaprFile] = []

    init(storeManager: StorageManager,
         conversionManager: ConversionManager) {
        self.storeManager = storeManager
        self.conversionManager = conversionManager
    }
}

extension DefaultFilelistViewModel: FileListViewModel {

    var conversionPublisher: AnyPublisher<ConversionEvent, Never> {
        conversionManager.conversionEventPublisher
    }
    
    func convert(file: ShaprFile, into type: FileType) async {
        await conversionManager.convert(file: file, into: type)
    }
    
    func fetchFiles()  async throws -> [ShaprFile] {
        files = try await storeManager.files().sorted(by: {
            $0.createdAt < $1.createdAt
        })
        return files
    }
    
    func cancelConversion(for file: ShaprFile) {
        conversionManager.cancelConversion(name: file.name)
    }
    

}
