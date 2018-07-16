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
        
        filterNames.forEach { filterName in
            print("\n# \(filterName)")
            guard let filter = CIFilter(name: filterName) else { return }
            
            let attributeKeys = filter.attributes.keys
            attributeKeys.forEach { attributeKey in
                let attributeValue = filter.attributes[attributeKey]
                
                if let attributeValue = attributeValue as? String {
                    switch attributeKey {
                    case "CIAttributeFilterDisplayName":
                        print("\n## 表示名\n\(attributeValue)")
                    case "CIAttributeFilterAvailable_iOS":
                        print("\n## 利用可能なiOSバージョン\n\(attributeValue)")
                    case "CIAttributeFilterName":
                        print("\n## フィルタ名\n\(attributeValue)")
                    case "CIAttributeFilterAvailable_Mac":
                        print("\n## 利用可能なMacOSバージョン\n\(attributeValue)")
                    default: assertionFailure()
                    }
                    
                    return
                }
                if let attributeValue = attributeValue as? NSDictionary {
                    print("\n## \(attributeKey)パラメータ")
                    let parameterKeys = attributeValue.allKeys as? [String]
                    parameterKeys?.forEach {
                        switch $0 {
                        case "CIAttributeDisplayName": print("- 表示名: \(attributeValue[$0]!)")
                        case "CIAttributeDescription": print("- 説明: \(attributeValue[$0]!)")
                        case "CIAttributeDefault": print("- 初期値: \(attributeValue[$0]!)")
                        case "CIAttributeClass": print("- クラス: \(attributeValue[$0]!)")
                        case "CIAttributeType": print("- タイプ: \(attributeValue[$0]!)")
                        case "CIAttributeSliderMax": print("- スライダー最大値: \(attributeValue[$0]!)")
                        case "CIAttributeIdentity": print("- アイデンティティ: \(attributeValue[$0]!)")
                        case "CIAttributeSliderMin": print("- スライダー最小値: \(attributeValue[$0]!)")
                        case "CIAttributeMin": print("- 最小値: \(attributeValue[$0]!)")
                        case "CIAttributeMax": print("- 最大値: \(attributeValue[$0]!)")
                        case "CIUIParameterSet": print("- パラメーターセット: \(attributeValue[$0]!)")
                        default: assertionFailure()
                        }
                    }
                    return
                }
                
                if let attributeValue = attributeValue as? NSArray {
                    print("\n## カテゴリ")
                    attributeValue.forEach { print(" - \($0)") }
                    return
                }
                
                if let attributeValue = attributeValue as? URL {
                    print("\n## ドキュメントURL\n\(attributeKey) = \(attributeValue)")
                    return
                }
                
                assertionFailure()
            }
        }
    }
}

