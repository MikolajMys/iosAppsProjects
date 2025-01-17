//
//  FileData.swift
//  DiscViewerApp
//
//  Created by Mikołaj Myśliński on 06/11/2024.
//

import Foundation

struct FileData: Codable {
    let results: [File]
    let page: Int
    let pageSize: Int
    let numPages: Int
    let count: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case pageSize = "page_size"
        case numPages = "num_pages"
        case count
    }
}

struct File: Codable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let extensionType: String?
    let type: String
    let createdAt: String
    let isDeleted: Bool
    let url: String?
    let thumbnailURL: String?
    let bigThumbnailURL: String?
    let documentUUID: String?
    let treeUUID: String?
    let treeGenusID: String?
    let treeSpeciesID: String?
    let treeGenus: String?
    let treeSpecies: String?
    let treeLacGenus: String?
    let treeLacSpecies: String?
    let treeHeight: String?
    let treePartsCount: Int?
    let treePartsThumbnailsCollection: [String]?
    let mapUUID: String?
    let filesCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name, description
        case extensionType = "extension"
        case type
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
        case url
        case thumbnailURL = "thumbnail_url"
        case bigThumbnailURL = "big_thumbnail_url"
        case documentUUID = "document_uuid"
        case treeUUID = "tree_uuid"
        case treeGenusID = "tree_genus_id"
        case treeSpeciesID = "tree_species_id"
        case treeGenus = "tree_genus"
        case treeSpecies = "tree_species"
        case treeLacGenus = "tree_lac_genus"
        case treeLacSpecies = "tree_lac_species"
        case treeHeight = "tree_height"
        case treePartsCount = "tree_parts_count"
        case treePartsThumbnailsCollection = "tree_parts_thumbnails_collection"
        case mapUUID = "map_uuid"
        case filesCount = "files_count"
    }
}

