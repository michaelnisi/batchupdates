//
//  SectionDataSourceView.swift
//  BatchUpdates
//
//  Created by Michael Nisi on 23.04.19.
//

import Foundation
import UIKit

/// Enumerates view types `SectionedDataSource` can update.
public enum SectionDataSourceView {
  case collection(UICollectionView)
  case table(UITableView)
  
  func performBatchUpdates(
    _ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
    switch self {
    case .table(let tv):
      tv.performBatchUpdates(updates, completion: completion)
    case .collection(let cv):
      cv.performBatchUpdates(updates, completion: completion)
    }
  }
  
  func update(
    sectionsToDelete: IndexSet,
    rowsToDelete: [IndexPath],
    sectionsToInsert: IndexSet,
    rowsToInsert: [IndexPath]
  ) {
    switch self {
    case .table(let tv):
      tv.deleteSections(sectionsToDelete, with: .fade)
      tv.deleteRows(at: rowsToDelete, with: .fade)
      tv.insertSections(sectionsToInsert, with: .fade)
      tv.insertRows(at: rowsToInsert, with: .fade)
      
    case .collection(let cv):
      cv.deleteSections(sectionsToDelete)
      cv.deleteItems(at: rowsToDelete)
      cv.insertSections(sectionsToInsert)
      cv.insertItems(at: rowsToInsert)
    }
  }
}
