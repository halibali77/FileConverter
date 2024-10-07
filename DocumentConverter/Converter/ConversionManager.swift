//
//  ConversionManager.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine
import Foundation

enum ConversionError: Error {
    case corruptedSource
    case failedToPersist
    case illegalState
    case missingSource
}


enum ConversionState {
    case queued
    case progress(progress: Double, type: FileType)
    case finished(result: FileDescriptor)
    case failed(error: Error)
}

struct ConversionEvent {
    let fileName: String
    let state: ConversionState

    public init(fileName: String, state: ConversionState) {
        self.fileName = fileName
        self.state = state
    }
}

protocol  ConversionManager {
    var  conversionEventPublisher: AnyPublisher<ConversionEvent, Never> { get }
    func convert(file: ShaprFile, into type: FileType) async
    func cancelConversion(name: String)
}
