import java.io.IOException;
import java.util.Arrays;

import javax.swing.UnsupportedLookAndFeelException;

import org.junit.Test;

import asmeta.fmvclib.testrunner.AsmetaFMVCTestRunner;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;
import view.AMANView;

public class TestAMAN {

	@Test
	public void testAMAN_MoveDown() throws Exception {
		runTestScenario("model/ScenarioMoveDown.avalla");
	}
	
	@Test
	public void testAMAN_MoveUP() throws Exception {
		runTestScenario("model/ScenarioMoveUP.avalla");
	}
	
	@Test
	public void testAMAN_HOLD() throws Exception {
		runTestScenario("model/ScenarioHOLD.avalla");
	}
	
	@Test
	public void testAMAN_LOCK() throws Exception {
		runTestScenario("model/ScenarioLOCK.avalla");
	}

	public void runTestScenario(String scenario) throws Exception, ClassNotFoundException, InstantiationException,
			IllegalAccessException, UnsupportedLookAndFeelException, IOException, InterruptedException {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, controller, scenario, Arrays.asList("NONE"), 500);
		runner.runTest();
	}
}
