//
//  BaseModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

// MARK: - Model Protocol

protocol BaseModel {
    
    //    typealias T
    
    static func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any?
    static func instanceFromData(_ data: Data) -> Any?
    
    static func arrayFromData(_ data: Data) -> [Any]?
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?)
}

// MARK: - BaseModel extension

extension BaseModel {
    
    // MARK: - BaseModel Protocol Implementation
    
    // Implementation of base functions which can
    // be used by the BaseModel conforming classes
    
    static func instanceFromData(_ data: Data) -> Any? {
        do {
            let jsonDict: [String: Any]? =
            try JSONSerialization.jsonObject(with: data,
                options: .allowFragments) as? [String: Any]
            
            if let _ = jsonDict {
                return instanceFromDictionary(jsonDict! as [String: Any])
            }
        } catch {
            
        }
        
        return nil
    }
    
    static func arrayFromData(_ data: Data) -> [Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let jsonArray = jsonObject as? [Any] {
                var objectCollection: [Any] = [Any]()
                
                for jsonDict in jsonArray {
                    if let dict = jsonDict as? [String: Any] {
                        objectCollection.append(instanceFromDictionary(dict)!)
                    }
                }
                
                return objectCollection
            }
        } catch {
            
        }
        
        return nil
    }
    
    func listFromRawArray<T: BaseModel>(_ listArray:[Any]?) -> [T]? {
        if listArray == nil {
            return nil
        }
        
        var itemList = [T]()
        for (element) in listArray! {
            let instance = T.instanceFromDictionary(element as? [String : Any]) as? T
            
            if instance != nil {
                itemList.append(instance!)
            }
        }
        
        return itemList
    }
}

