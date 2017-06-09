//
//  SportsViewController.swift
//  SportsCollector
//
//  Created by Salih Alborno on 08/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var sportsImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    var imagePicker = UIImagePickerController()
    var sport : Sport? = nil
    @IBOutlet weak var addUpdateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
        
        if sport != nil {
            sportsImageView.image = UIImage(data: sport!.image! as Data)
            titleTextField.text = sport!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
   
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        sportsImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if sport != nil {
            sport!.title = titleTextField.text
            sport!.image = UIImagePNGRepresentation(sportsImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let sport = Sport(context: context)
            sport.title = titleTextField.text
            sport.image = UIImagePNGRepresentation(sportsImageView.image!)! as NSData
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(sport!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
