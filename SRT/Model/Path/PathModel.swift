//
//  PathModel.swift
//  SRT
//
//  Created by 박성민 on 9/21/24.
//

import Foundation

class PathModel : ObservableObject {
    @Published var paths: [String]
    init(paths: [String] = []) {
        self.paths = paths
    }
}
