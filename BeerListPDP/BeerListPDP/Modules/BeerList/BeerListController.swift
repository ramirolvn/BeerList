//
//  BeerListController.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import UIKit
import CommonPackage
import RxSwift

class BeerListController: UIViewController, Storyboarded {
    @IBOutlet weak var beerTable: UITableView!
    private var viewModel: BeerListViewModelProtocol? {
        guard let viewModel = BeerListModule.shared.container.container.resolve(BeerListViewModelProtocol.self) else {
            return nil
        }
        return viewModel
    }
    var disposeBag: DisposeBag? = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    deinit {
        self.disposeBag = nil
    }

    private func configView() {
        self.title = "Lista de Cervejas"
        beerTable.dataSource = self
        beerTable.delegate = self
        beerTable.rowHeight = UITableView.automaticDimension
        beerTable.register(nibName: BeerCell.getCellName(), cellType: BeerCell.self, bundle: nil)
        viewModel?.getBeerList()
        configObservables()
    }

    private func configObservables() {
        guard let dispose = self.disposeBag else { return }
        viewModel?.beersObservable.subscribe(onNext: { [unowned self] _ in
            self.beerTable.reloadData()
        }).disposed(by: dispose)

        viewModel?.defaultErrorObservable.subscribe(onNext: { [unowned self] error in
            guard let error = error, error else { return }
            self.showDefaultErrorAlert()
        }).disposed(by: dispose)
    }

    private func showDefaultErrorAlert() {
        DefaultAlertController.showAlert(parent: self,
                                         title: "Atenção",
                                         message: "Algum erro ocorreu, por favor tente novamente mais tarde!",
                                         style: .alert,
                                         defaultActions: ["Ok"],
                                         completion: {_ in
                                            print("Ok Pressed")
                                         })
    }
}

// MARK: - TableView DataSource
extension BeerListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getRowsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let beerCell = beerTable.dequeueReusableCell(nibName: BeerCell.getCellName(),
                                                           with: BeerCell.self, for: indexPath),
              let beer = viewModel?.getBeer(at: indexPath.row) else {
            return UITableViewCell()
        }
        beerCell.config(beer: beer)
        if viewModel?.testIfNeedDoAnotherRequest(at: indexPath.row) ?? false {
            viewModel?.getBeerList()
        }
        return beerCell
    }
}

// MARK: - TableView Delegate
extension BeerListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let beer = viewModel?.getBeer(at: indexPath.row) else { return }
        BeerListModule.shared.goToDetail(beer: beer)
    }
}
