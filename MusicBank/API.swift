//
//  API.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

typealias UID = Int
typealias AID = Int
typealias SID = Int




enum API {
    case login(String,String)
    
    case getUserInfo(UID)
    
    case updateUserInfo(UpdateUserModel)
    
    /// 获取首页信息 发现信息
    case getFind(UID?)
    /// 获取用户信息
    case getMine(UID)
    /// 获取专辑列表
    case getAlbumList(AID)
    /// 单独获取播放
    case getSong(SID)
    /// 创建专辑
    case createAlbum(CreateAlbumModel)
    /// 更新专辑 基本数据
    case updateAlbum(CreateAlbumModel)
    /// 移除专辑
    case removeAlbum(AID)
    /// 添加歌曲到专辑
    case addSongToAlbum(SID,AID)
    /// 移除歌曲
    case removeSongFromAlbum(SID,AID)
    /// 搜索歌曲
    case search(UID?,AID?,String)
}
