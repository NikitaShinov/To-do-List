//
//  Data.swift
//  To-do List
//
//  Created by max on 30.01.2022.
//

import Foundation
import RealmSwift

class Data: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
}
