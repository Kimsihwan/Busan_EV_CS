//
//  ViewController.swift
//  Busan_EV_CS
//
//  Created by test on 2018. 11. 6..
//  Copyright © 2018년 ksh. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, XMLParserDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    var annotation: BusanData?
    var annotations: Array = [BusanData]()
    
    var item: [String:String] = [:]
    var items: [[String:String]] = []
    var currentElement = ""
    
    var address: String?
    var lat: String?
    var long: String?
    var name: String?
    var loc: String?
    var dLat: Double?
    var dLong: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "부산 전기차 충전소"
        
        if let path = Bundle.main.url(forResource: "EV", withExtension: "xml"){
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                if myParser.parse() {
                    print("파싱 성공")
                    for item in items {
                        print("item \(item["소재지지번주소"]!)")
                    }
                } else {
                    print("파싱 실패")
                }
            } else {
                print("파싱 오류1")
            }
        } else {
            print("XML 파일 없음")
        }
        
        myMapView.delegate = self
        
        // 초기맵 설정
        zoomToRegion()
        
        for item in items {
            lat = item["위도"]
            long = item["경도"]
            name = item["충전소명"]
            loc = item["소재지지번주소"]
            dLat = Double(lat!)
            dLong = Double(long!)
            annotation = BusanData(coordinate: CLLocationCoordinate2D(latitude: dLat!, longitude: dLong!), title: name!, subtitle: loc!)
            annotations.append(annotation!)
        }
        myMapView.showAnnotations(annotations, animated: true)
        myMapView.addAnnotations(annotations)
        
    }
    
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 35.180100, longitude: 129.081017)
        let span = MKCoordinateSpan(latitudeDelta: 0.27, longitudeDelta: 0.27)
        let region = MKCoordinateRegion(center: location, span: span)
        myMapView.setRegion(region, animated: true)
    }
    
    
    
    // XMLParser Delegete 메소드
    
    // XML 파서가 시작 테그를 만나면 호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "record" {
            items.append(item)
        }
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // 공백제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        // 공백체크 후 데이터 뽑기
        if !data.isEmpty {
            item[currentElement] = data
        }
        
    }
    
 


}

