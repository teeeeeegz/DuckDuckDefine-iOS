//
//  SearchDefinition.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 13/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Gloss

/**
 Represents a Search Definition object
 */
struct SearchDefinition : Decodable {
    let heading: String?
    let abstractText: String?
    
    let type: ResultType?
    let imageUrl: URL?
    
    // MARK: - Deserialisation
    
    init?(json: JSON) {
        self.heading = "Heading" <~~ json
        self.abstractText = "AbstractText" <~~ json
        self.type = "Type" <~~ json
        self.imageUrl = "Image" <~~ json
    }
    
    enum ResultType: String {
        case Answer = "A"
        case Exclusive = "E" // Exclusive results include special cases like calculations
    }
}
