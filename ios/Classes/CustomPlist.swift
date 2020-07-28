// //
// //  CustomPlist.swift
// //  Core
// //
// //  Created by Hendrick Ooi on 22/01/2016.
// //  Copyright © 2016 iFast Corporation Ltd. All rights reserved.
// //

// // HOW TO USE
// // 1. #import <Core/Core-Swift.h>

// // 2. CustomPlist *customPlist = [[CustomPlist alloc]init];

// // 3. SAVE / UPDATE
// //      NSDictionary *saveDict = [customPlist savePlist:[self class] plistFileName:[PLIST_FILE_NAME] dictionaryKey:[KEY] dictionaryObject:[OBJECT]];

// // 4. LOAD
// //      NSDictionary *loadDict = [customPlist loadPlist:[self class] plistFileName:[PLIST_FILE_NAME] dictionaryKey:[KEY]];

// import UIKit

// @objc open class CustomPlist: NSObject {
    
//     public enum PlistFileName: String {
//         case Token = "Token"
//         case FundWatchLocal = "FundWatchLocal"
//     }
    
//     open func loadPlist(_ currentClass:AnyClass, plistFileName : String, dictionaryKey : String)->AnyObject?{
//         let path = getPlistPath(plistFileName)
        
//         if plistExistsAtPath(currentClass, plistFileName: plistFileName, path: path) {
//             let myDict = NSDictionary(contentsOfFile: path)
//             return myDict!.object(forKey: dictionaryKey) as AnyObject
//         } else {
//             print("Plist does not exist")
//             return nil
//         }
//     }
    
//     open func savePlist(_ currentClass:AnyClass, plistFileName : String, dictionaryKey : String, dictionaryObject:AnyObject)->AnyObject?{
//         let path = getPlistPath(plistFileName)
        
//         if plistExistsAtPath(currentClass, plistFileName: plistFileName, path: path) {
//             // save plist
//             let dict: NSMutableDictionary = NSMutableDictionary(contentsOfFile: path)!
//             dict.setObject(dictionaryObject, forKey: dictionaryKey as NSCopying)
//             dict.write(toFile: path, atomically: false)
//             return dict.object(forKey: dictionaryKey) as AnyObject
//         }else{
//             // create new plist
//             let newDict: NSMutableDictionary = NSMutableDictionary()
//             newDict.setObject(dictionaryObject, forKey: dictionaryKey as NSCopying)
//             newDict.write(toFile: path, atomically: false)
//             return newDict.object(forKey: dictionaryKey) as AnyObject
//         }
//     }
    
    
//     open func saveNestedPlist(_ currentClass:AnyClass, plistFileName : String, dictionaryKey : String, dictionaryObject:AnyObject){
//         let path = getNestedPlistPath(plistFileName)
        
//         // let currentCountry = (I18NUtil.getCountryPreference())!!!
//         let currentCountry = ""
        
//         if plistExistsAtPath(currentClass, plistFileName: plistFileName, path: path) {
//             // save plist
//             self.updateNestedPlist(dictionaryKey, dictionaryObject: dictionaryObject, path: path, currentCountry: currentCountry!)
//             return
//         }
        
//         // create new plist
//         self.createNewNestedPlist(dictionaryKey, dictionaryObject: dictionaryObject, path: path, currentCountry: currentCountry!)
//     }
    
//     open func deleteDictionaryFromNestedPlist(_ currentClass:AnyClass, plistFileName : String, dictionaryKey : String, toBeDeletedKey:String){
//         let tempDictionary : NSMutableDictionary = self.loadPlist(currentClass, plistFileName: plistFileName, dictionaryKey: dictionaryKey) as! NSMutableDictionary
        
//         if(tempDictionary.count > 1){
//             tempDictionary.removeObject(forKey: toBeDeletedKey)
            
//             let path = getPlistPath(plistFileName)
            
//             let finalDict:NSMutableDictionary = NSMutableDictionary.init(object: tempDictionary, forKey: dictionaryKey as NSCopying)
            
//             finalDict.write(toFile: path, atomically:true)
//         }
//     }
    
//     func updateNestedPlist(_ dictionaryKey : String, dictionaryObject:AnyObject, path:String, currentCountry:String){
//         let toBeSavedTokenDict: NSMutableDictionary = NSMutableDictionary()
//         toBeSavedTokenDict.setObject(dictionaryObject, forKey: dictionaryKey as NSCopying)
        
//         var currentContentDict: NSDictionary
//         currentContentDict = NSDictionary(contentsOfFile: path)!
        
//         var _ : NSMutableDictionary
//         var consolidatedCountryDict : NSMutableDictionary!
//         var consolidatedContentDict : NSMutableDictionary!
        
        
//         if(currentContentDict.object(forKey: currentCountry) != nil){
            
//             consolidatedContentDict = self.consolidateDictionaryBasedOnTokenType(currentContentDict, dictionaryKey: dictionaryKey, toBeSavedTokenDict: toBeSavedTokenDict, currentCountry: currentCountry)
            
//         }else{
//             consolidatedContentDict = NSMutableDictionary(dictionary: (toBeSavedTokenDict as! [AnyHashable: Any]))
//         }
        
//         let tempCountryDict: NSMutableDictionary = NSMutableDictionary()
//         tempCountryDict.setObject(consolidatedContentDict, forKey: currentCountry as NSCopying)
        
//         consolidatedCountryDict = self.consolidateDictionaryBasedOnCountry(currentContentDict, tempCountryDict: tempCountryDict)
//         consolidatedCountryDict.write(toFile: path, atomically: false)
//     }
    
    
    
//     func createNewNestedPlist(_ dictionaryKey : String, dictionaryObject:AnyObject, path:String, currentCountry:String){
//         let newTokenDict: NSMutableDictionary = NSMutableDictionary()
//         newTokenDict.setObject(dictionaryObject, forKey: dictionaryKey as NSCopying)
        
//         let newCountryDict: NSMutableDictionary = NSMutableDictionary()
//         newCountryDict.setObject(newTokenDict, forKey: currentCountry as NSCopying)
//         newCountryDict.write(toFile: path, atomically: false)
        
//     }
    
//     func consolidateDictionaryBasedOnCountry(_ currentContentDict: NSDictionary, tempCountryDict: NSMutableDictionary) -> NSMutableDictionary{
//         var consolidatedCountryDict : NSMutableDictionary!
        
//         consolidatedCountryDict = NSMutableDictionary(dictionary: (currentContentDict as! [AnyHashable: Any]))
//         consolidatedCountryDict.addEntries(from: tempCountryDict as! [AnyHashable: Any])
        
//         return consolidatedCountryDict
//     }
    
//     func consolidateDictionaryBasedOnTokenType(_ currentContentDict: NSDictionary, dictionaryKey:String, toBeSavedTokenDict: NSMutableDictionary, currentCountry:String) -> NSMutableDictionary{
//         var consolidatedTokenDict : NSMutableDictionary!
//         var countryDict : NSMutableDictionary
        
//         countryDict = currentContentDict.object(forKey: currentCountry) as! NSMutableDictionary
        
//         for key in countryDict.allKeys{
//             if(dictionaryKey == key as! String){
//                 countryDict.removeObject(forKey: key)
//             }
//         }
        
//         consolidatedTokenDict = NSMutableDictionary(dictionary: (countryDict as! [AnyHashable: Any]))
//         consolidatedTokenDict.addEntries(from: toBeSavedTokenDict as! [AnyHashable: Any])
        
//         return consolidatedTokenDict
//     }
    
//     func getNestedPlistPath(_ plistFileName : String)->String{
//         let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//         let documentsDirectory = paths.object(at: 0) as! NSString
//         return documentsDirectory.appendingPathComponent(plistFileName + ".plist")
//     }
    
//     open func loadNestedPlist(_ currentClass:AnyClass, plistFileName : String, dictionaryKey : String)->AnyObject?{
//         let path = getNestedPlistPath(plistFileName)
//         print("plist path ", path)
        
//         if plistExistsAtPath(currentClass, plistFileName: plistFileName, path: path) {
//             let myDict = NSDictionary(contentsOfFile: path)
//             return myDict!.object(forKey: dictionaryKey) as AnyObject
//         } else {
//             print("Plist does not exist")
//             return nil
//         }
//     }
    
    
//     open func getPlistPath(_ plistFileName : String)->String{
//         let plistFileNamebyCountry = String(format: "%@", plistFileName)
//         let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//         let documentsDirectory = paths.object(at: 0) as! NSString
//         return documentsDirectory.appendingPathComponent(plistFileNamebyCountry + ".plist")
//     }
    
//     public func plistExistsAtPath(_ currentClass:AnyClass,plistFileName:String, path:String)->Bool{
//         var path = path
        
//         if path.isEmpty{
//             print("path is empty")
//             path = getPlistPath(plistFileName)
//         }
        
//         let fileManager = FileManager.default
        
//         if(!fileManager.fileExists(atPath: path)) {
//             return false;
//         } else {
// //            print("Plist already exits at path.")
//             return true;
//         }
//     }
// }


