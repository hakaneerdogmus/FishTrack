//
//  RealmModel.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import RealmSwift
import SwiftUI

class RealmModel: Object {
    @objc dynamic var photo: Data?
    @objc dynamic var info: String = ""
    @objc dynamic var date: Date?
}
