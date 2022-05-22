//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vipin Saini on 20/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblCityName: UILabel!
    
    // Bottom PageControl
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    
    lazy var viewModel: WeatherViewModel = {
        return WeatherViewModel()
    }()
    
    // Default Location Cordination (Belgrade, Serbia)
    let lat: String = "44.804"
    let long: String = "20.4651"
    
    
    
// MARK: - View Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setupViews()
        initViewModel()
    }
    
    
// MARK: - Setup view
    
    func setupViews() {
        
        // Page Control
        pageControl.addTarget(self, action: #selector(pageControlSelectionAction), for: [.touchUpInside, .touchCancel, .touchDragExit])
        [pageControl].forEach {
            view.addSubview($0) }
         
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        // Collection background view
        let imgView: UIImageView = UIImageView.init(frame: UIScreen.screenBound)
        imgView.image = UIImage(named: "bgImage2")
        let bgView = UIView.init(frame: UIScreen.screenBound)
        bgView.addSubview(imgView)
        bgView.alpha = 0.8
        collectionView.backgroundView = bgView
        collectionView.backgroundColor = .black
        
        // SegmentControl
        segmentController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        
        lblCityName.isHidden = true
        pageControl.isHidden = true
    }
    
// MARK: - Button Action
    
    // PageControl click action
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
        let page: Int = sender.currentPage
        let indexPath = IndexPath(item: page, section: 0)
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        })
    }
    
    // Segment click
    @IBAction func switchWeatherSegmentClick(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            viewModel.initFetchWeather(lat: lat, long: long) // Load Live data from API
        } else {
            // Load data from Local Json
            viewModel.initFetchOfflineWeather()
        } 
    }
}


// MARK: - View Model Setup

extension ViewController {
    
    func initViewModel() {
        
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionView.alpha = 0.0
                        self?.lblCityName.isHidden = true
                        self?.pageControl.isHidden = true
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.lblCityName.isHidden = false
                self?.pageControl.isHidden = false
                self?.lblCityName.text = self?.viewModel.getCityViewModel().name ?? "Belgrade"
                self?.pageControl.numberOfPages = self?.viewModel.numberOfCells ?? 0
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.initFetchWeather(lat: lat, long: long)
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Data

extension ViewController: UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherMainCollectionViewCell
        let cellDataVM = viewModel.getCellViewModel(at: indexPath)
         
        cell.weatherList = cellDataVM
        cell.tblView.reloadData()
        return cell
    }
}


// MARK: - CollectionView Layout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0001
    }
}

// MARK: - PageControl update
extension ViewController {
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
}
