//
//  FilelistViewModel.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine
import Foundation

protocol FileListViewModel {
    var imageFetcher: ImageFetcher { get }
    var files: [ShaprFile] { get }
    var  conversionPublisher: AnyPublisher<ConversionEvent, Never> { get }
    func convert(file: ShaprFile, into type: FileType) async
    func fetchFiles()  async throws -> [ShaprFile]
    func cancelConversion(for file: ShaprFile)
}
