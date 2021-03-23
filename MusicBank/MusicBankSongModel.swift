//
//  MusicBankSongModel.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/23.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import ObjectMapper

struct AssetItemModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        assetURL <- (map["assetURL"],URLTransform())
        title <- map["title"]
        artist <- map["artist"]
        artworkURL <- (map["artwork"],URLTransform())
        albumArtist <- map["albumArtist"]
        albumTitle <- map["albumTitle"]
    }
    
    
    var metadata: MusicBankPlayableStaticMetadata {
        
        guard let url = assetURL,let title = title else {
            fatalError()
        }
        
        return MusicBankPlayableStaticMetadata(assetURL: url, mediaType: .audio, isLiveStream: isLiveStream, title: title, artist: artist, artwork: nil, artworkURL: artworkURL, albumArtist: albumArtist, albumTitle: albumTitle)
    }
    
    var assetURL: URL?
    
    var isLiveStream: Bool = false
    
    var title: String?
    var artist: String?
    
    var artworkURL: URL?
    
    var albumTitle: String?
    var albumArtist: String?
    
    
}
