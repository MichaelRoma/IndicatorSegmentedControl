// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public final class IndicatorSegmentedControl: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    private var selectedTabIndex = 0
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TabCell.self, forCellWithReuseIdentifier: TabCell.identifier)
        return collectionView
    }()
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
        return view
    }()
    
    //MARK: Public Property
   public let tabs: [String]
   public var valueChangeAction: ((_ selectedTabIndex: Int) -> Void)?
    
   public init(tabs: [String], selectedTabIndex: Int = 0, valueChangeAction: ( (_: Int) -> Void)? = nil) {
        self.tabs = tabs
        self.selectedTabIndex = selectedTabIndex
        self.valueChangeAction = valueChangeAction
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [collectionView,bottomSeparatorView, indicatorView].forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemWidthScale = 1 / CGFloat(tabs.count == 0 ? 1 : tabs.count)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidthScale),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 2),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            bottomSeparatorView.widthAnchor.constraint(equalToConstant: collectionView.bounds.width),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: collectionView.bounds.width / CGFloat(tabs.count))
        ])
    }
    
    // MARK: - CollectionView DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCell.identifier, for: indexPath) as! TabCell
        cell.label.text = tabs[indexPath.item]
        cell.label.textColor = (indexPath.item == selectedTabIndex) ? .red : .black
        return cell
    }
    
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndex = selectedTabIndex
        selectedTabIndex = indexPath.item
        
        collectionView.reloadItems(at: [IndexPath(item: previousIndex, section: 0), indexPath])
        
        let indicatorWidth = collectionView.bounds.width / CGFloat(tabs.count)
        let collectionViewOriginX = collectionView.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame.origin.x = collectionViewOriginX + indicatorWidth * CGFloat(indexPath.item)
        }
        valueChangeAction?(selectedTabIndex)
    }
}
