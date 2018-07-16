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
        var filterAttributeList = [FilterAttribute]()
        
        filterNames.forEach { filterName in
            guard let filter = CIFilter(name: filterName) else { return }
            
            var displayName = ""
            var availableIOSVersion = ""
            var name = ""
            var availableMacOSVersion = ""
            var categories = [String]()
            var documentURL: URL? = nil
            var parameters = [ParameterAttribute]()
            
            let attributeKeys = filter.attributes.keys
            attributeKeys.forEach { attributeKey in
                let attributeValue = filter.attributes[attributeKey]
                if let attributeValue = attributeValue as? String {
                    switch attributeKey {
                    case "CIAttributeFilterDisplayName":
                        displayName = attributeValue
                    case "CIAttributeFilterAvailable_iOS":
                        availableIOSVersion = attributeValue
                    case "CIAttributeFilterName":
                        name = attributeValue
                    case "CIAttributeFilterAvailable_Mac":
                        availableMacOSVersion = attributeValue
                    default: assertionFailure()
                    }
                    
                    return
                }
                if let attributeValue = attributeValue as? NSDictionary {
                    var displayName = ""
                    var description = ""
                    var defaultValue = ""
                    var className = ""
                    var parameterType = ""
                    var sliderMax = ""
                    var sliderMin = ""
                    var identity = ""
                    var max = ""
                    var min = ""
                    var parameterSet = ""
                    
                    let parameterKeys = attributeValue.allKeys as? [String]
                    parameterKeys?.forEach {
                        switch $0 {
                        case "CIAttributeDisplayName":
                            displayName = attributeValue[$0]! as! String
                        case "CIAttributeDescription":
                            description = attributeValue[$0]! as! String
                        case "CIAttributeDefault":
                            defaultValue = "\(attributeValue[$0]!)"
                        case "CIAttributeClass":
                            className = attributeValue[$0]! as! String
                        case "CIAttributeType":
                            parameterType = attributeValue[$0]! as! String
                        case "CIAttributeSliderMax":
                            sliderMax = "\(attributeValue[$0]!)"
                        case "CIAttributeIdentity":
                            identity = "\(attributeValue[$0]!)"
                        case "CIAttributeSliderMin":
                            sliderMin = "\(attributeValue[$0]!)"
                        case "CIAttributeMin":
                            min = "\(attributeValue[$0]!)"
                        case "CIAttributeMax":
                            max = "\(attributeValue[$0]!)"
                        case "CIUIParameterSet":
                            parameterSet = attributeValue[$0]! as! String
                        default: assertionFailure()
                        }
                    }
                    
                    let parameterAttribute = ParameterAttribute(attributeName: attributeKey,
                                                                displayName: displayName,
                                                                description: description,
                                                                defaultValue: defaultValue,
                                                                className: className,
                                                                parameterType: parameterType,
                                                                sliderMax: sliderMax,
                                                                sliderMin: sliderMin,
                                                                identity: identity,
                                                                max: max,
                                                                min: min,
                                                                parameterSet: parameterSet)
                    parameters.append(parameterAttribute)
                    
                    return
                }
                
                if let attributeValue = attributeValue as? NSArray {
                    categories = attributeValue as? [String] ?? []
                    return
                }
                
                if let attributeValue = attributeValue as? URL {
                    documentURL = attributeValue
                    return
                }
                
                assertionFailure()
            }
            
            let filterAttribute = FilterAttribute(displayName: displayName,
                                                  availableIOSVersion: availableIOSVersion,
                                                  name: name,
                                                  availableMacOSVersion: availableMacOSVersion,
                                                  categories: categories,
                                                  documentURL: documentURL,
                                                  parameters: parameters)
            filterAttributeList.append(filterAttribute)
        }
        
        filterAttributeList.forEach { filter in
            print("\n# \(filter.name)")
            print("\n## フィルタ名")
            print("\(filter.displayName)")
            print("\n## SDKs")
            print("iOS \(filter.availableIOSVersion)+ / macOS \(filter.availableMacOSVersion)+")
            print("\n## ドキュメントURL")
            print("\(filter.documentURL?.absoluteString ?? "")")
            print("\n## 所属カテゴリ")
            print("\(filter.categories.joined(separator: ", "))")
            print("\n## パラメータ")
            filter.parameters.forEach { parameter in
                print("\n### \(parameter.attributeName)")
                print("|項目|内容|")
                print("|:--|:--|")
                if !parameter.displayName.isEmpty { print("|パラメーター名|\(parameter.displayName)|") }
                if !parameter.description.isEmpty { print("|説明|\(parameter.description)|") }
                if !parameter.parameterType.isEmpty { print("|タイプ|\(parameter.parameterType)|") }
                if !parameter.className.isEmpty { print("|型|\(parameter.className)|") }
                
                switch (parameter.defaultValue.isEmpty, parameter.identity.isEmpty) {
                case (false, true): print("|Default値|\(parameter.defaultValue)|")
                case (true, false): print("|Identity値|\(parameter.identity)|")
                case (false, false): print("|Default値, Identity値|\(parameter.defaultValue), \(parameter.identity)|")
                case (true, true): break
                }
                
                switch (parameter.min.isEmpty, parameter.max.isEmpty) {
                case (false, true): print("|最小値, 最大値|\(parameter.min) ~ 無し|")
                case (true, false): print("|最小値, 最大値|無し ~ \(parameter.max)|")
                case (false, false): print("|最小値, 最大値|\(parameter.min) ~ \(parameter.max)|")
                case (true, true): break
                }
                
                switch (parameter.sliderMin.isEmpty, parameter.sliderMax.isEmpty) {
                case (false, true): print("|スライダー最小値, 最大値|\(parameter.sliderMin) ~ 無し|")
                case (true, false): print("|スライダー最小値, 最大値|無し ~ \(parameter.sliderMax)|")
                case (false, false): print("|スライダー最小値, 最大値|\(parameter.sliderMin) ~ \(parameter.sliderMax)|")
                case (true, true): break
                }
                
                if !parameter.parameterSet.isEmpty { print("|パラメーターセット|\(parameter.parameterSet)|") }
            }
        }
    }
}

