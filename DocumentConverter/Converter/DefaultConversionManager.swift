//
//  DefaultConversionManager.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine
import Foundation

final class DefaultConversionManager {
    let storeManager: StorageManager
    private var conversionTasks: [String: Task<Void, Never>] = [:]
    let conversionSubject = PassthroughSubject<ConversionEvent, Never>()
    var conversionEventPublisher: AnyPublisher<ConversionEvent, Never> {
        conversionSubject.eraseToAnyPublisher()
    }


    init(storeManager: StorageManager) {
        self.storeManager = storeManager
    }
}

extension DefaultConversionManager: ConversionManager {
    func convert(file: ShaprFile, into type: FileType) async {

        conversionSubject.send(.init(fileName: file.descriptor.name, state: .queued))
         let sharprURL = file.descriptor.url
        guard let sharprData = try? Data(contentsOf: sharprURL) else {
            conversionSubject.send(.init(fileName: file.descriptor.name, state: .failed(error: ConversionError.corruptedSource)))
            return
        }
        conversionTasks[file.descriptor.name] = Task.detached(priority: .background) { [weak self] in
            guard let self else {
                self?.conversionSubject.send(
                    .init(
                        fileName: file.descriptor.name,
                        state: .failed(error: ConversionError.illegalState)
                    )
                )
                return
            }
            let conversionTime = Double.random(in: 2...5)
            for i in 0...100 {
                try? await Task.sleep(nanoseconds: UInt64(conversionTime * 10_000_000))
                let progress = Double(i) / 100.0
                self.conversionSubject.send(
                        .init(
                            fileName: file.descriptor.name,
                            state: .progress(
                                        progress: progress,
                                        type: type
                                        )
                            )
                    )
                if Task.isCancelled {
                    break
                }
            }

            guard let conversionResult =  try? storeManager.save(file, with: sharprData, type: type),
                  let descriptorForType = conversionResult.descriptor(for: type)
            else {
                self.conversionSubject.send(
                    .init(
                        fileName: file.descriptor.name,
                        state: .failed(error: ConversionError.failedToPersist)
                    )
                )
                return
            }
            self.conversionSubject.send(
                .init(
                    fileName: file.descriptor.name,
                    state: .finished(
                        result: descriptorForType
                      )
                )
            )

        }       
    }

    func cancelConversion(name: String) {
        conversionTasks[name]?.cancel()
    }


}
