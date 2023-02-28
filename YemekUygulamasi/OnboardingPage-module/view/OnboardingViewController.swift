//
//  OnboardingPage.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 26.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class OnboardingViewController: UIViewController {
    var PresenterNesnesi:OnboardingViewToPresenterProtocol?
    var hasCurrentUser:Bool?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Başlayalım", for: .normal)
            } else {
                nextBtn.setTitle("İleri", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnboardingRouter.createModule(ref: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        slides = [
            OnboardingSlide(title: "Lezzetli Yemekler", description: "Dünyanın dört bir yanındaki farklı kültürlerden çeşitli harika yemekleri deneyimleyin.", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "Dünya Standartlarında Şefler", description: "Yemeklerimiz sadece en iyiler tarafından hazırlanmaktadır.", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Anında Teslimat", description: "Siparişleriniz dünyanın neresinde olursanız olun anında teslim edilir.", image: #imageLiteral(resourceName: "slide3"))
        ]
        
        pageControl.numberOfPages = slides.count
        PresenterNesnesi?.control()
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            if hasCurrentUser == true{
                self.performSegue(withIdentifier: "toMain", sender: nil)
            }else {
                self.performSegue(withIdentifier: "toLogin", sender: self)
           }
        
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
}
extension OnboardingViewController : OnboardingPresenterToViewProtocol {
    func vieweVeriGonder(isSuccess: Bool) {
        hasCurrentUser = isSuccess
    }
}
