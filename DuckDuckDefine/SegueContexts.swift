//
//  SegueContexts.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 14/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation

// MARK: - Custom segue context classes

class SearchDefinitionSegueContext: NSObject {
    let definition: SearchDefinition
    
    init(definition: SearchDefinition) {
        self.definition = definition
        super.init()
    }
}
