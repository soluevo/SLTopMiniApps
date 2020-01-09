//
//  ModelController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

@available(iOS 11.0, *)
class ModuleController: UIViewController, SectionManager {
    var componentsTemp = [SectionComponent]()
    var showMenu = false
    
    private let refreshControl = UIRefreshControl()
    
    lazy var moduleTableView: UITableView = {
        let moduleTableView = UITableView(frame: .zero)
        moduleTableView.translatesAutoresizingMaskIntoConstraints = false
        moduleTableView.backgroundColor = UIColor.clear
        moduleTableView.tableFooterView = UIView()
        moduleTableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return moduleTableView
    }()
    
    var titleTemp = ""
    
    var componentViews = [SectionComponent]()
    
    private var topConstraint: NSLayoutConstraint?
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTemp = self.navigationItem.title ?? ""
        self.navigationController?.navigationBar.tintColor = .black
        self.view.backgroundColor = .clear
        self.configSubviews()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = titleTemp
        self.configNavBarTitle()
        self.configureCustoms()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.titleTemp = self.navigationItem.title ?? ""
        self.navigationItem.title = ""
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    private func configNavBarTitle(){
        let textAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureCustoms(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func configSubviews() {
        
        self.view.addSubview(moduleTableView)
        moduleTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        moduleTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.topConstraint = moduleTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        self.topConstraint?.isActive = true
        moduleTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        moduleTableView.dataSource = self
        moduleTableView.delegate = self
        
    }
    
    func addRefresh(){
        moduleTableView.refreshControl = refreshControl
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
        self.moduleTableView.isScrollEnabled = ((self.componentViews.first?.components.first as? EmptyComponent) == nil)
    }
    
    func loadMore(){}
    
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
    
    func setTopMarging(_ marging: Int = 20){ self.topConstraint?.constant = CGFloat(marging) }
    
    func setNoneTop(){
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height
        self.topConstraint?.constant = -topBarHeight
        
    }
    
    func registerCells() {
        
        moduleTableView.register(ModuleCell.self, forCellReuseIdentifier: "ModuleCell")
        
    }
}

@available(iOS 11.0, *)
extension ModuleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSection(section)?.components.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.componentViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleCell", for: indexPath) as? ModuleCell else {return ModuleCell()}
        if indexPath.row == (self.getSection(indexPath.section)?.components.count ?? 0) - 10 {
            self.loadMore()
            return cell
        }
        cell.moduleModel = self.getSection(indexPath.section)?.components[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = self.getSection(section)?.title else {return nil}
        return HeaderTitleModularView(title: title)
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



