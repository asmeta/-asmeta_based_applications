package mvcRunner;

import asmeta.fmvclib.controller.AsmetaFMVCController;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.CalcController;
import view.SimpleCalculatorView;

public class CalcMVC {

	public static void main(String[] args) throws Exception {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/SimpleCalculator.asm");
		// Define the view
		SimpleCalculatorView view = new SimpleCalculatorView();
		// The controller has both the references of the model and the view
		@SuppressWarnings("unused")
		AsmetaFMVCController controller = new CalcController(model, view);
		// Show the view
		view.setVisible(true);
	}
}
