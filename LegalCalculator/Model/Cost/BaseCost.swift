//
//  BaseCost.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 01/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseCost: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let costs = "costs"
        static let total = "total"
        static let totalMax = "total_max"
        static let totalMin = "total_min"
    }
    
    // MARK: Properties
    public var costs: [Cost]?
    public var total: Int = 0
    public var totalMax: Int = 0
    public var totalMin: Int = 0

    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        total = json[SerializationKeys.total].intValue
        totalMax = json[SerializationKeys.totalMax].intValue
        totalMin = json[SerializationKeys.totalMin].intValue
        if let items = json[SerializationKeys.costs].array { costs = items.map { Cost(json: $0) } }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = costs { dictionary[SerializationKeys.costs] = value.map { $0.dictionaryRepresentation() } }
        dictionary[SerializationKeys.total] = total
        dictionary[SerializationKeys.totalMax] = totalMax
        dictionary[SerializationKeys.totalMin] = totalMin

        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.costs = aDecoder.decodeObject(forKey: SerializationKeys.costs) as? [Cost]
        self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as! Int
        self.totalMax = aDecoder.decodeObject(forKey: SerializationKeys.totalMax) as! Int
        self.totalMin = aDecoder.decodeObject(forKey: SerializationKeys.totalMin) as! Int

    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(costs, forKey: SerializationKeys.costs)
        aCoder.encode(total, forKey: SerializationKeys.total)
        aCoder.encode(totalMax, forKey: SerializationKeys.totalMax)
        aCoder.encode(totalMin, forKey: SerializationKeys.totalMin)

    }
    
}
