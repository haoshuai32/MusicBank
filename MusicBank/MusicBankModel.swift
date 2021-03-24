//
//  MusicBankModel.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListDiffKit

class SongModel: Mappable, ListDiffable {
    var id: Int = 0
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}


class AlbumModel: Mappable, ListDiffable {
    var id: Int = 0
    /// 名称
    var name: String?
    /// 封面
    var image: URL?
    /// 介绍
    var introduction: String?
    /// 播放次数
    var playCount: Int = 0
    /// 收藏次数
    var favoritesCount: Int = 0
    /// 评论次数
    var commentCount: Int = 0
    /// 分享次数
    var shareCount: Int = 0
    /// 用户头像
    var userAvatar: URL?
    /// 用户昵称
    var userName: String?
    /// 用户id
    var userID: UID?
    /// 歌曲数量
    var songCount = 0
    /// 歌曲列表
    var songList: [SongModel] = []
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}

class UserModel: Mappable, ListDiffable {
    var id: UID = 0
    /// 用户头像
    var avatar: URL?
    /// 用户昵称
    var name: String?
    /// 关注
    var followersCount: Int = 0
    /// 粉丝
    var fansCount: Int = 0
    /// 城市
    var city: String?
    /// 介绍
    var introduction: String?
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

class CreateAlbumModel: Mappable, ListDiffable {
    
    var id: Int = 0
    /// 名称
    var name: String?
    /// 封面
    var image: URL?
    /// 介绍
    var introduction: String?
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}


class UpdateUserModel: Mappable, ListDiffable {
    
    var id: UID = 0
    /// 用户头像
    var avatar: URL?
    /// 用户昵称
    var name: String?
    /// 关注
    var followersCount: Int = 0
    /// 粉丝
    var fansCount: Int = 0
    /// 城市
    var city: String?
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}

struct AssetItemModel: Mappable {
    
    init() {
        
    }
    
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
