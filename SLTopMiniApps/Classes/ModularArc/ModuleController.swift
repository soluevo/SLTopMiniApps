//
//  ModelController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit
import LocalAuthentication
import SVProgressHUD

@available(iOS 11.0, *)
class MAModuleController: UIViewController, MASectionManager {
    
    var componentsTemp = [MASectionComponent]()
    var isCentralizeComponents = false
    
    private let refreshControl = UIRefreshControl()
    
    lazy var moduleTableView: UITableView = {
        let moduleTableView = UITableView(frame: .zero)
        moduleTableView.translatesAutoresizingMaskIntoConstraints = false
        moduleTableView.backgroundColor = UIColor.clear
        moduleTableView.tableFooterView = UIView()
        moduleTableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return moduleTableView
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var titleTemp = ""
    
    var componentViews = [MASectionComponent]()
    
    private var topConstraint: NSLayoutConstraint?
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width - 100, height: 20))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.titleTemp = self.navigationItem.title ?? ""
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = .white
        self.configSubviews()
        self.registerCells()
//        self.configNavBarTitle()
        self.addComponentTop(view: UIView(frame: .zero))
        self.addComponentBottom(view: UIView(frame: .zero))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let barColor = UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")
        self.navigationController?.navigationBar.backgroundColor = barColor
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let url = URL(string: ConfigManager.instance.companySelected?.imageUrl ?? "") {
            let imageView = (self.navigationItem.titleView as! UIImageView)
            imageView.af_setImage(withURL: url)
            imageView.image = imageView.image?.resizeImage(targetSize: CGSize(width: (imageView.image?.size.width ?? 0) * 25 / (imageView.image?.size.height ?? 0), height: 25))
            ConfigManager.instance.companySelected?.logo = (self.navigationItem.titleView as! UIImageView).image
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateTableViewContentInset()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.titleTemp = self.navigationItem.title ?? ""
        self.navigationItem.title = ""
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configNavBarTitle(){
        let textAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white,
//            NSAttributedString.Key.font: UIFont.avenirBlack(20)
        ]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @available(iOS 11.0, *)
    private func configSubviews() {
        
        self.view.addSubview(moduleTableView)
        moduleTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        moduleTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        moduleTableView.dataSource = self
        moduleTableView.delegate = self
        
        self.view.addSubview(topView)
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.moduleTableView.topAnchor).isActive = true
        self.topConstraint = topView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        self.topConstraint?.isActive = true
        
        self.view.addSubview(bottomView)
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: self.moduleTableView.bottomAnchor).isActive = true
    }
    
    func addRefresh(){
        if #available(iOS 10.0, *) {
            moduleTableView.refreshControl = refreshControl
        } else {
            moduleTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.loadData()
    }
    
    func loadData() {
        self.refreshControl.endRefreshing()
    }
    
    func reloadData(){
        self.moduleTableView.reloadData()
        self.moduleTableView.isScrollEnabled = ((self.componentViews.first?.components.first as? MAEmptyComponent) == nil)
    }
    
    func insertCell(sec: Int, index: Int) {
        self.moduleTableView.beginUpdates()
        self.moduleTableView.insertRows(at: [IndexPath(row: index, section: sec)], with: .fade)
        self.moduleTableView.endUpdates()
    }
    
    func removeCell(index: Int, section: Int) {
        self.moduleTableView.beginUpdates()
        self.moduleTableView.deleteRows(at: [IndexPath(row: index, section: section)], with: .fade)
        self.moduleTableView.endUpdates()
    }
    
    func reloadComponent(sec: Int, index: Int) {
        self.moduleTableView.reloadRows(at: [IndexPath(row: index, section: sec)], with: .fade)
    }
    
    func setTopMarging(){ self.topConstraint?.constant = 20 }
    
    func setNoneTop(){
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height
        self.topConstraint?.constant = -topBarHeight
        
    }
    
    func registerCells() {
        
        moduleTableView.register(MAModuleCell.self, forCellReuseIdentifier: "ModuleCell")
        
    }
    
    func setTopMarging(_ marging: Int = 20){ self.topConstraint?.constant = CGFloat(marging) }
    
    func addComponentTop(view: UIView) {
        self.topView.subviews.forEach{$0.removeFromSuperview()}
        self.topView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: topView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        self.topView.layoutSubviews()
    }
    
    func addComponentBottom(view: UIView) {
        self.bottomView.subviews.forEach{$0.removeFromSuperview()}
        self.bottomView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        self.bottomView.layoutSubviews()
    }
    
    func setBottomBar(color: UIColor){
        let bot = UIView(frame: .zero)
        bot.backgroundColor = color
        self.view.addSubview(bot)
        bot.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bot.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bot.heightAnchor.constraint(equalToConstant: UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0).isActive = true
        bot.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func updateTableViewContentInset() {
        let viewHeight: CGFloat = moduleTableView.frame.size.height
        let tableViewContentHeight: CGFloat = moduleTableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0

        if marginHeight > 0 && isCentralizeComponents {
            self.moduleTableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0)
        }
    }
    
    func setCentralizeComponents() {
        self.isCentralizeComponents = true
        self.reloadData()
    }
    
    func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }

    enum BiometricType {
        case none
        case touch
        case face
    }
}

@available(iOS 11.0, *)
extension MAModuleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSection(section)?.components.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.componentViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleCell", for: indexPath) as? MAModuleCell else {return MAModuleCell()}
        cell.moduleModel = self.getSection(indexPath.section)?.components[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = self.getSection(section)?.title else {return nil}
        return MAHeaderTitleModularView(title: title)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.getSection(section)?.title else {return 0}
        return 50
    }
    
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}

extension UIViewController {
    func showLoading() {
        self.view.isUserInteractionEnabled = false
        self.view.subviews.forEach({ (view) in
            view.isUserInteractionEnabled = false
        })
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        self.view.isUserInteractionEnabled = true
        self.view.subviews.forEach({ (view) in
            view.isUserInteractionEnabled = true
        })
        SVProgressHUD.dismiss()
    }
}

extension UIView {
    func showLoading() {
        self.isUserInteractionEnabled = false
        self.subviews.forEach({ (view) in
            view.isUserInteractionEnabled = false
        })
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        self.isUserInteractionEnabled = true
        self.subviews.forEach({ (view) in
            view.isUserInteractionEnabled = true
        })
        SVProgressHUD.dismiss()
    }
}







