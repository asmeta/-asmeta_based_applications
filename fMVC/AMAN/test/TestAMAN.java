import java.util.Arrays;

import org.junit.Test;

import asmeta.fmvclib.testrunner.AsmetaFMVCTestRunner;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;
import view.AMANView;

public class TestAMAN {

	@Test
	public void testAMAN_MoveDown() throws Exception {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, "model/ScenarioMoveDown.avalla", Arrays.asList("NONE"), 500);
		runner.runTest();
	}
	
	@Test
	public void testAMAN_MoveUP() throws Exception {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, "model/ScenarioMoveUP.avalla", Arrays.asList("NONE"), 500);
		runner.runTest();
	}
	
	@Test
	public void testAMAN_HOLD() throws Exception {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, "model/ScenarioHOLD.avalla", Arrays.asList("NONE"), 500);
		runner.runTest();
	}
}
