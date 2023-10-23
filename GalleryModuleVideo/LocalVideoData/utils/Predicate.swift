//
//  Predicate.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import Photos
import SwiftUI

class Predicate {
    var predicateString: String? = ""
    var arguments: [Any] = []
    var assetKeys: [AssetKeys] = []
    var assetCollectionKeys: [AssetCollectionKeys] = []
    
    var comparators: [QueryComparator] = []
    var conjuncts: [Conjuncts] = []
    var caseInsensitiveQuerys: [CapitalizationQuery] = []
    var mapAssetKeysToSpecifier: [AssetKeys: QuerySpecifier] = [:]
    var mapAssetCollectionKeysToSpecifier:  [AssetCollectionKeys: QuerySpecifier] = [:]
    
    //    init(_ predicateString: String, _ arguments: [Any]) {
    //        self.predicateString = predicateString
    //        self.arguments = arguments
    //    }
    //
    
    init() {
        // PHAsset
        mapAssetKeysToSpecifier[.burstIdentifier] = .objectSpecifier
        mapAssetKeysToSpecifier[.creationDate] = .objectSpecifier
        mapAssetKeysToSpecifier[.duration] = .intSpecifier
        mapAssetKeysToSpecifier[.localIdentifier] = .objectSpecifier
        mapAssetKeysToSpecifier[.mediaSubType] = .objectSpecifier
        mapAssetKeysToSpecifier[.mediaType] = .objectSpecifier
        mapAssetKeysToSpecifier[.modificationDate] = .objectSpecifier
        mapAssetKeysToSpecifier[.pixelHeight] = .intSpecifier
        mapAssetKeysToSpecifier[.pixelWidth] = .intSpecifier
        
        // PHAssetCollection
        mapAssetCollectionKeysToSpecifier[.localIdentifier] = .objectSpecifier
        mapAssetCollectionKeysToSpecifier[.title] = .objectSpecifier
        mapAssetCollectionKeysToSpecifier[.startDate] = .objectSpecifier
        mapAssetCollectionKeysToSpecifier[.endDate] = .objectSpecifier
        mapAssetCollectionKeysToSpecifier[.estimatedAssetCount] = .intSpecifier
    }
    //
    //
    //
    func getPredicate() -> NSPredicate? {
        guard let predicateString = self.predicateString else {
            return nil
        }
        
        return NSPredicate(format: predicateString, argumentArray: arguments)
    }
    
    func validatingAssetKeysInputs(){
        
        var numberOfBoolArguments : Int {
            var count = 0
            //            for item in arguments {
            //                if (item. as! String == "true" || item as! String == "false") {
            //                    count += 1
            //                }
            //            }
            return count
        }
        print(assetKeys.count, comparators.count, arguments.count, conjuncts.count)
        
        if assetKeys.count != comparators.count {
            fatalError("Keys and Comparators count doesn't match")
        }else if assetKeys.count != arguments.count - numberOfBoolArguments {
            fatalError("Keys and Arguments count doesn't match")
        }else if assetKeys.count != conjuncts.count + 1{
            fatalError("Keys and Conjuncts count doesn't match")
        } else {
            makePredicateLogic()
        }
    }
    
    func validatingAssetCollectionKeysInputs(){
        
        var numberOfBoolArguments : Int {
            var count = 0
            //            for item in arguments {
            //                if (item. as! String == "true" || item as! String == "false") {
            //                    count += 1
            //                }
            //            }
            return count
        }
        print(assetCollectionKeys.count, comparators.count, arguments.count)
        
        if assetCollectionKeys.count != comparators.count {
            fatalError("Keys and Comparators count doesn't match")
        }else if assetCollectionKeys.count != arguments.count - numberOfBoolArguments {
            fatalError("Keys and Arguments count doesn't match")
        }else if assetCollectionKeys.count != conjuncts.count + 1{
            fatalError("Keys and Conjuncts count doesn't match")
        } else {
            makeAssetCollectionPredicateLogic()
        }
    }
    
    func makeAssetCollectionPredicateLogic(){
        var currentString = ""
        
        for idx in 0...assetCollectionKeys.count - 1 {
            if (idx != assetCollectionKeys.count - 1) {
                if caseInsensitiveQuerys.count > 0{
                    currentString = assetCollectionKeys[idx].rawValue + comparators[idx].rawValue + caseInsensitiveQuerys[idx].rawValue
                    + mapAssetCollectionKeysToSpecifier[assetCollectionKeys[idx]]!.rawValue + conjuncts[idx].rawValue
                    
                }
                else{
                    currentString = assetCollectionKeys[idx].rawValue + comparators[idx].rawValue + mapAssetCollectionKeysToSpecifier[assetCollectionKeys[idx]]!.rawValue + conjuncts[idx].rawValue
                }
                
            }
            else{
                if caseInsensitiveQuerys.count > 0{
                    currentString = assetCollectionKeys[idx].rawValue + comparators[idx].rawValue + caseInsensitiveQuerys[idx].rawValue + mapAssetCollectionKeysToSpecifier[assetCollectionKeys[idx]]!.rawValue
                }
                else {
                    currentString = assetCollectionKeys[idx].rawValue + comparators[idx].rawValue + mapAssetCollectionKeysToSpecifier[assetCollectionKeys[idx]]!.rawValue
                }
            }
            self.predicateString! += currentString
            
        }
    }
    
    func makePredicateLogic(){
        var currentString = ""
        
        for idx in 0...assetKeys.count - 1 {
            if (idx != assetKeys.count - 1) {
                if caseInsensitiveQuerys.count > 0{
                    currentString = assetKeys[idx].rawValue + comparators[idx].rawValue + caseInsensitiveQuerys[idx].rawValue
                    + mapAssetKeysToSpecifier[assetKeys[idx]]!.rawValue + conjuncts[idx].rawValue
                    
                }
                else{
                    currentString = assetKeys[idx].rawValue + comparators[idx].rawValue + mapAssetKeysToSpecifier[assetKeys[idx]]!.rawValue + conjuncts[idx].rawValue
                }
                
            }
            else{
                if caseInsensitiveQuerys.count > 0{
                    currentString = assetKeys[idx].rawValue + comparators[idx].rawValue + caseInsensitiveQuerys[idx].rawValue + mapAssetKeysToSpecifier[assetKeys[idx]]!.rawValue
                }
                else {
                    currentString = assetKeys[idx].rawValue + comparators[idx].rawValue + mapAssetKeysToSpecifier[assetKeys[idx]]!.rawValue
                }
            }
            self.predicateString! += currentString
            
        }
    }
    
    //    func makePHAssetPredicateLogic(keys: AssetKeys..., comparators: QueryComparator..., caseSensitive isCaseSensitive: Bool..., specifiers: QuerySpecifier...) {
    //
    //
    //    }
    
    //    func makePHAssetCollectionPredicateLogic(key: AssetCollectionKeys, comparator: QueryComparator, caseSensitive isCaseSensitive: Bool = false, specifier: QuerySpecifier) {
    //
    //        if isCaseSensitive == true{
    //            self.predicateString! += key.rawValue + comparator.rawValue + QueryComparator.caseInsensitiveBeforeSpecifier.rawValue +  specifier.rawValue
    //        }
    //        else{
    //            self.predicateString! += key.rawValue + comparator.rawValue +  specifier.rawValue
    //        }
    //    }
    
    //    func andConjunct() {
    //        if (((self.predicateString?.isEmpty) != nil) ) {
    //            self.predicateString! += " AND "
    //        }
    //        else{
    //            print("Predicate String is Empty nothing to add AND to")
    //        }
    //    }
    
    //    func orConjunct() {
    //        if (((self.predicateString?.isEmpty) != nil) ) {
    //            self.predicateString! += " OR "
    //        }
    //        else{
    //            print("Predicate String is Empty nothing to add AND to")
    //        }
    //    }
}

class PredicateBuilder {
    private var predicate: Predicate
    
    init() {
        self.predicate = Predicate()
    }
    
    func setPredicateString(_ predicateString: String) -> PredicateBuilder {
        self.predicate.predicateString = predicateString
        return self
    }
    
    func addArguments(_ arguments: Any...) -> PredicateBuilder {
        for arg in arguments{
            self.predicate.arguments.append(arg)
        }
        
        return self
    }
    
    func addAssetKeys(_ assetKeys: AssetKeys...) -> PredicateBuilder {
        for key in assetKeys{
            self.predicate.assetKeys.append(key)
        }
        return self
    }
    
    func addAssetCollectionKey(_ assetCollectionKeys: AssetCollectionKeys...) -> PredicateBuilder {
        for key in assetCollectionKeys {
            self.predicate.assetCollectionKeys.append(key)
        }
        return self
    }
    
//        func addSpecifier(_ specifiers: QuerySpecifier...) -> PredicateBuilder {
//            for specifier in specifiers{
//                self.predicate.specifiers.append(specifier)
//            }
//            return self
//        }
    
    func addComparator(_ comparators: QueryComparator...) -> PredicateBuilder {
        for comparator in comparators{
            self.predicate.comparators.append(comparator)
        }
        return self
    }
    
    func addCaseInsentiveQuery( _ caseInsensitives: CapitalizationQuery...) -> PredicateBuilder{
        for item in caseInsensitives{
            self.predicate.caseInsensitiveQuerys.append(item)
        }
        return self
    }
    
    func addConjuncts(_ conjuncts: Conjuncts...) -> PredicateBuilder {
        for conjunct in conjuncts {
            self.predicate.conjuncts.append(conjunct)
        }
        
        return self
    }
    
    func build() -> Predicate {
        return self.predicate
    }
}

enum CapitalizationQuery: String{
    case caseInsensitive = "[c]"
}

enum QueryComparator: String {
    case notEqual = "!="
    case equal = "=="
    case greaterThan = ">"
    case lessThan = "<"
    case greaterThanOrEqual = ">="
    case lessThanOrEqual = "<="
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case In = "IN"
    case contains = "CONTAINS"
    case between = "BETWEEN"
    case like = "LIKE"
    case matching = "MATCHING"
}
enum QuerySpecifier: String {
    case objectSpecifier = "%@"
    case integerSpecifier = "%i"
    case fractionSpecifier = "%f"
    case keypathSpecifier = "%K"
    case intSpecifier = "%d"
    case trueSpecifier = "true"
    case falseSpecifier = "false"
}

enum Conjuncts: String {
    case and = "AND"
    case or = "OR"
}

// %K == %@
enum AssetKeys: String {
    case localIdentifier = "localIndentifier" // %@
    case modificationDate = "modificationDate" // %@
    case mediaType = "mediaType" // %d
    case mediaSubType = "mediaSubtypes" // %d
    case creationDate = "creationDate" // %d
    case duration = "duration" // %d, %i
    case pixelWidth = "pixelWidth" // %d, %i
    case pixelHeight = "pixelHeight"  // %d, %i
    
    case isHidden = "isHidden" // true, false
    case isFavorite = "isFavorite" // true, false
    case burstIdentifier = "burstIdentifier" // %@
}

enum AssetCollectionKeys: String {
    case localIdentifier = "localIndentifier" // %@
    case title = "title" // %@
    case startDate = "startDate" // %@
    case endDate = "endDate" // %@
    case estimatedAssetCount = "estimatedAssetCount" // %d, %i
}

enum AssetCollectionListKeys: String {
    case localIdentifier = "localIndentifier"
    case title = "title"
    case startDate = "startDate"
    case endDate = "endDate"
}
