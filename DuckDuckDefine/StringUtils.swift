//
//  StringUtils.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 13/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation

/**
 A utility class which provides common string manipulation tools
 */
class StringUtils {
    
    /**
     Return whether a string is null or empty
     */
    static func isNullOrEmpty(_ string: String?) -> Bool {
        return (string ?? "").isEmpty
    }
}
