//
//  DefaultFileDetailViewModel.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//

import Combine

final class DefaultFileDetailViewModel {
    let conversionManager: ConversionManager
    let file: ShaprFile
    let storeManager: StorageManager

    init(conversionManager: ConversionManager,
         file: ShaprFile,
         storeManager: StorageManager) {
        self.conversionManager = conversionManager
        self.file = file
        self.storeManager = storeManager
    }

}

extension DefaultFileDetailViewModel: FileDetailViewModel {
    var conversionEventPublisher: AnyPublisher<ConversionEvent, Never> {
        conversionManager.conversionEventPublisher
    }

    func convert(file: ShaprFile, into type: FileType) async {
        await conversionManager.convert(file: file, into: type)
    }

    func cancelConversion(name: String) {
        conversionManager.cancelConversion(name: name)
    }


}

