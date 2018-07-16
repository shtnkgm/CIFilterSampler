//
//  FilterListViewController.swift
//  CIFIlterSampler
//
//  Created by Shota Nakagami on 2018/07/16.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import PureLayout

final class FilterListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterNames: [String] = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        
        var typeList = Set<String>()
        
        filterNames.forEach { filterName in
            print("フィルタ名: \(filterName)")
            guard let filter = CIFilter(name: filterName) else { return }
            
            let attributeKeys = filter.attributes.keys
            attributeKeys.forEach { attributeKey in
                let attributeValue = filter.attributes[attributeKey]
                
                if let attributeValue = attributeValue as? String {
                    switch attributeKey {
                    case "CIAttributeFilterDisplayName":
                        print("表示名: \(attributeKey) = \(attributeValue)")
                    case "CIAttributeFilterAvailable_iOS":
                        print("利用可能なiOSバージョン: \(attributeKey) = \(attributeValue)")
                    case "CIAttributeFilterName":
                        print("フィルタ名: \(attributeKey) = \(attributeValue)")
                    case "CIAttributeFilterAvailable_Mac":
                        print("利用可能なMacOSバージョン: \(attributeKey) = \(attributeValue)")
                    default: assertionFailure()
                    }
                
                    return
                }
                if let attributeValue = attributeValue as? NSDictionary {
                    print("パラメータ: \(attributeKey) = \(attributeValue)")
                    let parameterKeys = attributeValue.allKeys as? [String]
                    parameterKeys?.forEach { parameterKey in
                        if parameterKey == "CIAttributeType" {
                            // print("おお: "\(attributeValue[parameterKey])")
                            typeList.insert(attributeValue[parameterKey] as! String)
                        }
                    }
                    return
                }
                
                if let attributeValue = attributeValue as? NSArray {
                    print("カテゴリ: \(attributeKey) = \(attributeValue)")
                    return
                }
                
                if let attributeValue = attributeValue as? URL {
                    print("ドキュメントURL: \(attributeKey) = \(attributeValue)")
                    return
                }
                
                assertionFailure()
            }
        }
        print(typeList)
    }
}
