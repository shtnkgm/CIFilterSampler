//
//  FilterAttribute.swift
//  CIFIlterSampler
//
//  Created by Shota Nakagami on 2018/07/17.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import Foundation

struct FilterAttribute {
    let displayName: String
    let availableIOSVersion: String
    let name: String
    let availableMacOSVersion: String
    let categories: [String]
    let documentURL: URL?
    let parameters: [ParameterAttribute]
}
