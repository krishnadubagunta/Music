//
//  Playlist.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/9/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import RealmSwift

class Playlist: Object {
    dynamic var name = ""
    let songs = List<Song>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
