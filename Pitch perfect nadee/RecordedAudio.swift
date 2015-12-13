//
//  RecordedAudio.swift
//  Pitch perfect nadee
//
//  Created by Nadee Anuththara on 11/27/15.
//  Copyright © 2015 Nadee Anuththara. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init?(filePathUrl: NSURL, title: String) {
        super.init()
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
