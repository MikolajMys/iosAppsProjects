//
//  MBTilesOverlay.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import MapKit
import SQLite3
import Network

class MBTilesOverlay: MKTileOverlay {
    var db: OpaquePointer?
    
    init?(mbtilesPath: String) {
        super.init(urlTemplate: nil)
        
        if sqlite3_open(mbtilesPath, &db) != SQLITE_OK {
            print("Failed to open MBTiles database")
            return nil
        }
    }

    deinit {
        sqlite3_close(db)
    }

    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        guard let db = db else {
            result(nil, NSError(domain: "MBTilesError", code: 1, userInfo: nil))
            return
        }

        let query = "SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            let flippedY = (1 << path.z) - 1 - path.y
            sqlite3_bind_int(stmt, 1, Int32(path.z))
            sqlite3_bind_int(stmt, 2, Int32(path.x))
            sqlite3_bind_int(stmt, 3, Int32(flippedY))

            if sqlite3_step(stmt) == SQLITE_ROW {
                let bytes = sqlite3_column_blob(stmt, 0)
                let length = sqlite3_column_bytes(stmt, 0)
                let data = Data(bytes: bytes!, count: Int(length))
                result(data, nil)
            } else {
                result(nil, nil) // Jeśli nie ma kafelka, systemowa mapa się wyświetli
            }
        } else {
            result(nil, NSError(domain: "MBTilesError", code: 2, userInfo: nil))
        }

        sqlite3_finalize(stmt)
    }
}


//import MapKit
//import SQLite3
//
//class MBTilesOverlay: MKTileOverlay {
//    var db: OpaquePointer?
//
//    init?(mbtilesPath: String) {
//        super.init(urlTemplate: nil)
//        
//        if sqlite3_open(mbtilesPath, &db) != SQLITE_OK {
//            print("Failed to open MBTiles database")
//            return nil
//        }
//    }
//
//    deinit {
//        sqlite3_close(db)
//    }
//
//    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
//        guard let db = db else {
//            result(nil, NSError(domain: "MBTilesError", code: 1, userInfo: nil))
//            return
//        }
//        
//        let query = "SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?"
//        var stmt: OpaquePointer?
//
//        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
//            let flippedY = (1 << path.z) - 1 - path.y // MBTiles używa odwrotnej numeracji Y
//            sqlite3_bind_int(stmt, 1, Int32(path.z))
//            sqlite3_bind_int(stmt, 2, Int32(path.x))
//            sqlite3_bind_int(stmt, 3, Int32(flippedY))
//
//            if sqlite3_step(stmt) == SQLITE_ROW {
//                let bytes = sqlite3_column_blob(stmt, 0)
//                let length = sqlite3_column_bytes(stmt, 0)
//                let data = Data(bytes: bytes!, count: Int(length))
//                result(data, nil)
//            } else {
//                result(nil, nil)
//            }
//        } else {
//            result(nil, NSError(domain: "MBTilesError", code: 2, userInfo: nil))
//        }
//
//        sqlite3_finalize(stmt)
//    }
//}
//
