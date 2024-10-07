//
//  FileDetailViewModel.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//

import Combine
import Foundation

protocol FileDetailViewModel {
    var conversionEventPublisher: AnyPublisher<ConversionEvent, Never> { get }
    var file: ShaprFile { get }
    func convert(file: ShaprFile, into type: FileType) async
    func cancelConversion(name: String)
}
