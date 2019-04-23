# BatchUpdates

BatchUpdates makes updating UITableView and UICollectionView easier.

## Resources

- [WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/225/)
- [DeepDiff](https://github.com/onmyway133/DeepDiff)
- [Ordered Collection Diffing](https://github.com/apple/swift-evolution/blob/master/proposals/0240-ordered-collection-diffing.md)

## Example

Adopt the `SectionedDataSource` protocol with your `UICollectionViewDataSource` or `UITableViewDataSource` object.

```swift
import BatchUpdates

class SomeDataSource: SectionedDataSource {

  /// Enumerates item types provided by this data source, where `Product`
  /// would be some data type in your domain model.
  enum Item: Hashable {
    case product(Product)
    case message(String)
  }

  /// The changes block receives changes.
  var changesBlock: (([[Change<Item>]]) -> Void)?

}
```

A view controller would install the data source.

```swift
let dataSource = SomeDataSource()
collectionView.dataSource = dataSource

dataSource.changesBlock = { [weak self] changes in
  guard let cv = self?.collectionView else {
    return
  }

  self?.dataSource.commit(changes, performingWith: .collection(cv))
}
```

Your data source `SomeDataSource` would implement an API for communicating with 
your domain model and services, providing their data as sections of data source
items enumerated by `SomeDataSource.Item`. 

When the data source has received new data, it diffs old and new sections with its
`static func makeChanges(old: [Array<Item>], new: [Array<Item>]) -> [[Change<Item>]]`
function and submits `changesBlock` on the main queue, suggesting the changes without 
updating its internal state. The sections data structure remains untouched until the view 
controller commits the changes. This is when `SectionedDataSource` performs batch updates,
updating the data model inside the updates block of `performBatchUpdates(_:completion:)` 
on `UICollectionView` or `UITableView`.

## Documentation

Go take a look at [this](https://michaelnisi.github.io/batchupdates/).

## Install

Add `BatchUpdates.xcodeproj` to your Xcode Workspace.

## License

[MIT](https://raw.github.com/michaelnisi/batchupdates/master/LICENSE)
