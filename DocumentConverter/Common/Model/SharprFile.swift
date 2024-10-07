//
//  SharprFile.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//
import Foundation
import UIKit

public struct FileDescriptor: Codable, Equatable {
    let createdAt: Date
    let name: String
    let size: Double
    let type: FileType
    let url: URL

    public init(createdAt: Date, name: String, size: Double, type: FileType, url: URL) {
        self.createdAt = createdAt
        self.name = name
        self.size = size
        self.type = type
        self.url = url
    }


}

public enum FileType: String, Codable {
    case obj = "OBJ"
    case sharpr = "SHARPR"
    case step = "STEP"
    case stl = "STL"

    public static var allCases: [FileType] = [.obj, .sharpr, .step, .stl]
    public static var allConversionCases: [FileType] = [.obj, .step, .stl]
}

public struct ShaprFile: Codable, Hashable {
    let descriptor: FileDescriptor
    let conversions: [FileType: FileDescriptor]

    init(descriptor: FileDescriptor,
         conversions: [FileType: FileDescriptor]
         ) {
        self.descriptor = descriptor
        self.conversions = conversions
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(descriptor.name)
    }

    func file(with url: URL, size: Double, type: FileType) -> ShaprFile {
        var updatedConversion = conversions
        updatedConversion[type] = .init(createdAt: Date(),
                                        name: descriptor.name+type.rawValue,
                                        size: size,
                                        type: type,
                                        url: url)
        return .init(
            descriptor: descriptor,
            conversions: updatedConversion
        )
    }

    func url(for type: FileType) -> URL? {
        if case .sharpr = type {
            return descriptor.url
        } else {
            return conversions[type]?.url
        }
    }

    func descriptor(for type: FileType) -> FileDescriptor? {
        if case .sharpr = type {
            return descriptor
        } else {
            return conversions[type]
        }
    }
}
