//
//  Song.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/9/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import RealmSwift

class Song: Object {
    dynamic var imageData = ""
    dynamic var presistenID = ""
    dynamic var songName = ""
    dynamic var artistName = ""
}

