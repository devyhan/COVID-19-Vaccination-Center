//
//  ViewController.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class VaccinationCenterVC: UIViewController {
  private var viewModel = VaccinationCenterVM()
  private var disposeBag = DisposeBag()
  
  private var fetchMoreDatasSubject = PublishSubject<Void>()
  private lazy var input = VaccinationCenterVM.Input(
    fetchMoreDatas: self.fetchMoreDatasSubject.asObservable(),
    refreshControlAction: self.refreshControl.rx.controlEvent(.valueChanged).asObservable()
  )
  private lazy var output = self.viewModel.transform(input: input)

  private let refreshControl = UIRefreshControl()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.register(CenterCell.self, forCellReuseIdentifier: CenterCell.identifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.refreshControl = refreshControl
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableHeaderView = UIView()
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.refreshControl?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    return tableView
  }()
  
  private lazy var spinner: UIView = {
    let view = UIView(
      frame:
        CGRect(
          x: 0,
          y: 0,
          width: view.frame.size.width,
          height: 100
        )
    )
    let spinner = UIActivityIndicatorView()
    spinner.center = view.center
    view.addSubview(spinner)
    spinner.startAnimating()
    return view
  }()
  
  private lazy var floatingButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .white
    button.setImage(UIImage(named: "top-alignment"), for: .normal)
    button.tintColor = .white
    button.layer.cornerRadius = 25
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOpacity = 1.0
    button.layer.shadowOffset = CGSize.zero
    button.layer.shadowRadius = 6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.topItem?.title = "예방접종센터 리스트"
    
    setConstraints()
    setBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  private func setConstraints() {
    let guid = view.safeAreaLayoutGuide
    
    [tableView, spinner, floatingButton].forEach {
      view.addSubview($0)
    }
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    floatingButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-50)
      make.bottom.equalTo(guid).offset(-50)
      make.width.height.equalTo(50)
    }
  }
  
  private func setBindings() {
    output.vaccinationItems
      .drive(
        tableView.rx.items(
          cellIdentifier: CenterCell.identifier,
          cellType: CenterCell.self
        )
      ) { _, item, cell in
        cell.rowItem = item
        cell.selectionStyle = .none
      }
      .disposed(by: disposeBag)
    
    output.refreshControlCompelted
      .drive { [weak self] _ in
        guard let self = self else { return }
        self.tableView.refreshControl?.endRefreshing()
      }
      .disposed(by: disposeBag)
    
    output.isLoadingSpinnerAvaliable
      .drive { [weak self] isAvaliable in
        guard let self = self else { return }
        self.spinner.isHidden = !isAvaliable
        self.tableView.tableFooterView = isAvaliable ? self.spinner : UIView(frame: .zero)
      }
      .disposed(by: disposeBag)
    
    tableView.rx.didScroll
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .subscribe { [weak self] _ in
        guard let self = self else { return }
        let offSetY = self.tableView.contentOffset.y
        let contentHeight = self.tableView.contentSize.height
        
        if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
          self.fetchMoreDatasSubject.onNext(())
        }
      }
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Center.self)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] member in
        let viewController = VaccinationCenterDetailVC()
        viewController.title = member.centerName
        viewController.center = member
        self?.navigationController?.pushViewController(viewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    floatingButton.rx.tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
      .disposed(by: disposeBag)
  }
}
