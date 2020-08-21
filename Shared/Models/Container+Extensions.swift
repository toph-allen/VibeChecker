//
//  Container+Extensions.swift
//  VibeChecker
//
//  Created by Toph Allen on 6/25/20.
//

import Foundation
import CoreData

extension Container {
    @objc var childArray: [Container]? {
        get {
            return nil
        }
    }
    
    var isLeaf: Bool {
        get {
            if self is Folder {
                return false
            } else {
                return true
            }
        }
    }
    
    var inVibeTree: Bool {
        get {
            switch self {
            case _ as Vibe:
                return true
            case let folder as Folder:
                for descendant in folder.descendants {
                    if descendant is Vibe {
                        return true
                    }
                }
            default:
                return false
            }
            return false
        }
    }
    
    var inPlaylistTree: Bool {
        get {
            switch self {
            case _ as Playlist:
                return true
            case let folder as Folder:
                for descendant in folder.descendants {
                    if descendant is Playlist {
                        return true
                    }
                }
            default:
                return false
            }
            return false
        }
    }
    
}

extension Folder {
    @objc override var childArray: [Container]? {
        get {
            let childArray = self.children?.allObjects as? [Container]
            return childArray!.sorted { c1, c2 in
                if c1.isLeaf == c2.isLeaf {
                    return c1.name ?? "" < c2.name ?? ""
                } else {
                    return !c1.isLeaf && c2.isLeaf // This sorts the trues last?
                }
            }

        }
    }
}
