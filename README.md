# BatchUpdates

BatchUpdates makes updating UITableView and UICollectionView easier.

## Resources

- [WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/225/)
- [DeepDiff](https://github.com/onmyway133/DeepDiff)
- [Ordered Collection Diffing](https://github.com/apple/swift-evolution/blob/master/proposals/0240-ordered-collection-diffing.md)

## Example

Adopt the `SectionedDataSource` protocol in your data source.

```swift
import BatchUpdates

class SomeDataSource: SectionedDataSource {

  /// Enumerates item types provided by this data source, where `Product`
  /// would be some data type in your domain model.
  enum Item: Hashable {
    case product(Product)
    case message(String)
  }

  /// The central change handler called when the collection changed.
  var sectionsChangeHandler: (([[Change<Item>]]) -> Void)?

}
```

In some view controller you would install the data source.

```swift
let dataSource = SomeDataSource()
collectionView.dataSource = dataSource

dataSource.sectionsChangeHandler = { [weak self] changes in
  guard let cv = self?.collectionView else {
    return
  }

  self?.dataSource.commit(changes, performingWith: .collection(cv))
}
```

Your data source `SomeDataSource` would expose an API that modifies data in your domain 
model and transform that data into data source items of type `SomeDataSource.Item`. 
When the data changes, the data source submits the `sectionsChangeHandler` on the 
main queue suggesting the changes—without updating its sections, that’s the view 
controller’s job, which can commit the changes in that block. `SectionedDataSource` 
performs batch updates for `.collection` and `.table` views.

## Documentation

Go take a look at [this](https://michaelnisi.github.io/batchupdates/).

## Install

Add `BatchUpdates.xcodeproj` to your Xcode Workspace.

## License

[MIT](https://raw.github.com/michaelnisi/batchupdates/master/LICENSE)
