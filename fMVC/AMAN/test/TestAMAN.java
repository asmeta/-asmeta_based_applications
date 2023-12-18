import org.junit.Test;

import asmeta.fmvc.testrunner.AsmetaFMVCTestRunner;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;
import view.AMANView;

public class TestAMAN {

	@Test
	public void testAMAN() throws Exception {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, "model/scenario1.avalla");
		runner.runTest();
	}
	
}
