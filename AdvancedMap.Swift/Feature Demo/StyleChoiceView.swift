//
//  StyleChoiceView.swift
//  Feature Demo
//
//  Created by Aare Undo on 19/06/2017.
//  Copyright © 2017 CARTO. All rights reserved.
//

import Foundation
import UIKit
import CartoMobileSDK

class StyleChoiceView : MapBaseView {

    var languageButton: PopupButton!
    var baseMapButton: PopupButton!
    var mapOptionsButton: PopupButton!
    
    var languageContent: LanguagePopupContent!
    var baseMapContent: StylePopupContent!
    var mapOptionsContent: MapOptionsPopupContent!
    
    var currentLanguage: String = ""
    var currentSource: String = "carto.streets"
    var currentLayer: NTTileLayer!
    var buildings3D: Bool = false
    var texts3D: Bool = true

    convenience init() {
        
        self.init(frame: CGRect.zero)
        
        initialize()
        
        currentLayer = addBaseLayer()
        
        languageButton = PopupButton(imageUrl: "icon_language.png")
        baseMapButton = PopupButton(imageUrl: "icon_basemap.png")
        mapOptionsButton = PopupButton(imageUrl: "icon_switches.png")
        
        addButton(button: languageButton)
        addButton(button: baseMapButton)
        addButton(button: mapOptionsButton)
        
        infoContent.setText(headerText: Texts.basemapInfoHeader, contentText: Texts.basemapInfoContainer)
        
        languageContent = LanguagePopupContent()
        baseMapContent = StylePopupContent()
        baseMapContent.highlightDefault()
        mapOptionsContent = MapOptionsPopupContent()
    }

    override func addRecognizers() {
        
        super.addRecognizers()
        
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(self.languageButtonTapped(_:)))
        languageButton.addGestureRecognizer(recognizer)
        
        recognizer = UITapGestureRecognizer(target: self, action: #selector(self.baseMapButtonTapped(_:)))
        baseMapButton.addGestureRecognizer(recognizer)

        recognizer = UITapGestureRecognizer(target: self, action: #selector(self.mapOptionsButtonTapped(_:)))
        mapOptionsButton.addGestureRecognizer(recognizer)
    }
    
    override func removeRecognizers() {
        
        super.removeRecognizers()
        
        languageButton.gestureRecognizers?.forEach(languageButton.removeGestureRecognizer)
        baseMapButton.gestureRecognizers?.forEach(baseMapButton.removeGestureRecognizer)
        mapOptionsButton.gestureRecognizers?.forEach(mapOptionsButton.removeGestureRecognizer)
    }
    
    @objc func languageButtonTapped(_ sender: UITapGestureRecognizer) {
        
        if (languageButton.isEnabled) {
            popup.setContent(content: languageContent)
            popup.popup.header.setText(text: "SELECT A LANGUAGE")
            popup.show()
        }
    }
    
    @objc func baseMapButtonTapped(_ sender: UITapGestureRecognizer) {
        popup.setContent(content: baseMapContent)
        popup.popup.header.setText(text: "SELECT A BASEMAP")
        popup.show()
    }
    
    @objc func mapOptionsButtonTapped(_ sender: UITapGestureRecognizer) {
        popup.setContent(content: mapOptionsContent)
        popup.popup.header.setText(text: "CONFIGURE RENDERING")
        popup.show()
    }
    
    func updateMapLanguage(language: String) {
        currentLanguage = language
        
        let decoder = (currentLayer as? NTVectorTileLayer)?.getTileDecoder() as? NTMBVectorTileDecoder
        decoder?.setStyleParameter("lang", value: currentLanguage)
    }

    func updateBaseLayer(selection: String, source: String) {
        
        if (source == StylePopupContent.CartoVectorSource) {
            if (selection == StylePopupContent.Positron) {
                currentLayer = NTCartoOnlineVectorTileLayer(style: .CARTO_BASEMAP_STYLE_POSITRON)
            } else if (selection == StylePopupContent.DarkMatter) {
                currentLayer = NTCartoOnlineVectorTileLayer(style: .CARTO_BASEMAP_STYLE_DARKMATTER)
            } else if (selection == StylePopupContent.Voyager) {
                currentLayer = NTCartoOnlineVectorTileLayer(style: .CARTO_BASEMAP_STYLE_VOYAGER)
            }
        } else if (source == StylePopupContent.CartoRasterSource) {
            if (selection == StylePopupContent.HereSatelliteDaySource) {
                currentLayer = NTCartoOnlineRasterTileLayer(source: "here.satellite.day@2x")
            } else if (selection == StylePopupContent.HereNormalDaySource) {
                currentLayer = NTCartoOnlineRasterTileLayer(source: "here.normal.day@2x")
            }
        }
        
        if (source == StylePopupContent.CartoRasterSource) {
            languageButton.disable()
        } else {
            languageButton.enable()
        }
        
        map.getLayers().clear()
        map.getLayers().add(currentLayer)
        
        updateMapLanguage(language: currentLanguage)
        updateMapOption(option: "buildings3d", value: buildings3D)
        updateMapOption(option: "texts3d", value: texts3D)
    }
    
    func updateMapOption(option:String!, value:Bool) {

        if (option == "globe") {
            map.getOptions()?.setRenderProjectionMode(value ? NTRenderProjectionMode.RENDER_PROJECTION_MODE_SPHERICAL : NTRenderProjectionMode.RENDER_PROJECTION_MODE_PLANAR)
            return
        }
        
        let decoder = (currentLayer as? NTVectorTileLayer)?.getTileDecoder() as? NTMBVectorTileDecoder
        if (option == "buildings3d") {
            buildings3D = value
            decoder?.setStyleParameter("buildings", value: value ? "2" : "1")
        }
        if (option == "texts3d") {
            texts3D = value
            decoder?.setStyleParameter("texts3d", value: value ? "1" : "0")
        }
    }
}
