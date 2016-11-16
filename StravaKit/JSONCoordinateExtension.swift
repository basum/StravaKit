import SwiftyJSON

extension JSON {

    var coordinates: [Coordinate] { return array!.map({ $0.coordinate }) }

    var coordinate: Coordinate {
        let latitudeLongitude = arrayObject!
        return Coordinate((latitudeLongitude[0] as AnyObject).doubleValue!, (latitudeLongitude[1] as AnyObject).doubleValue!)
    }
}
