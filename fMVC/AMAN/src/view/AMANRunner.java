package view;

import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;

/** executes the AMAN system
 * 
 * @author angelo gargantini
 *
 */
public class AMANRunner {
	
	public static void main(String[] args) throws Exception {
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
	}

}
