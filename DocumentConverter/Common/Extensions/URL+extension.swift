//
//  URL+extension.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//
import Foundation

extension URL {
    func fileSize(using fileSizeResourceKeys: Set<URLResourceKey>) throws -> UInt64 {
        let resourceValues = try self.resourceValues(forKeys: fileSizeResourceKeys)
        return UInt64(resourceValues.totalFileAllocatedSize ?? resourceValues.fileAllocatedSize ?? 0)
    }
}

