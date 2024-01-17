//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailView()
    }
    
    private func configureDetailView() {
        let vc = UIHostingController(rootView: WordDetails(viewModel: viewModel))
        let detailsView = vc.view!
        containerView.addSubview(detailsView)
        detailsView.constrainToFillSuperview()
    }
    
    // MARK: actions
    
    @IBAction func didTapButton() {
        guard let text = textField.text else {
            return
        }
        
        viewModel.search(query: text)
    }
}
