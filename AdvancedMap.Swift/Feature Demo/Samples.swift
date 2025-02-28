//
//  Samples.swift
//  Feature Demo
//
//  Created by Aare Undo on 19/06/2017.
//  Copyright © 2017 CARTO. All rights reserved.
//

import Foundation

class Samples {
    
    static var list = [Sample]()
    
    static func initialize() {
        
        let folder = ""
        var sample = Sample()
        
        sample.title = "BASEMAP STYLES"
        sample.description = "Various samples of different CARTO Base Maps"
        sample.imageResource = folder + "icon_sample_styles.png"
        sample.controller = StyleChoiceController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "SEARCH API"
        sample.description = "Search points of interests near route"
        sample.imageResource = folder + "icon_sample_route_search.png"
        sample.controller = RouteSearchController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "OFFLINE MAP"
        sample.description = "Download existing map packages for offline use"
        sample.imageResource = folder + "icon_sample_package_download.png"
        sample.controller = OfflineMapController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "OFFLINE ROUTING"
        sample.description = "Download existing routing packages for offline use"
        sample.imageResource = folder + "icon_sample_offline_routing.png"
        sample.controller = OfflineRoutingController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "VECTOR ELEMENTS"
        sample.description = "Different popups, polygons and a NMLModel"
        sample.imageResource = folder + "icon_sample_vector_objects.png"
        sample.controller = VectorObjectController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "ELEMENT CLUSTERING"
        sample.description = "Loads 20000 elements and shows as clusters"
        sample.imageResource = folder + "icon_sample_clustering.png"
        sample.controller = ClusteringController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "OBJECT EDITING"
        sample.description = "Places editable objects on the world map"
        sample.imageResource = folder + "icon_sample_object_editing.png"
        sample.controller = VectorObjectEditingController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "GPS LOCATION"
        sample.description = "Locates you and places a marker on the location"
        sample.imageResource = folder + "icon_sample_gps_location.png"
        sample.controller = GPSLocationController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "GEOCODING"
        sample.description = "Enter an address to locate it on the map"
        sample.imageResource = folder + "icon_sample_geocoding.png"
        sample.controller = GeocodingController.self
        
        list.append(sample)
        
        sample = Sample()
        sample.title = "REVERSE GEOCODING"
        sample.description = "Click an area on the map to get information about it"
        sample.imageResource = folder + "icon_sample_reverse_geocoding.png"
        sample.controller = ReverseGecodingController.self
        
        list.append(sample)
    }
}

class Sample {
    
    var imageResource: String!
    
    var title: String!
    
    var description: String!
    
    var controller: BaseController.Type!
}
