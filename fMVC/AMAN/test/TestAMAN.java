import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.swing.UnsupportedLookAndFeelException;

import org.asmeta.atgt.generator2.AsmTGBySimulationOnAction;
import org.asmeta.atgt.generator2.AsmTestGeneratorBySimulation;
import org.asmeta.atgt.testoptimizer.UnchangedRemover;
import org.asmeta.atgt.testoptimizer.UnecessaryChangesRemover;
import org.asmeta.parser.ASMParser;
import org.asmeta.simulator.Environment;
import org.asmeta.simulator.Environment.TimeMngt;
import org.junit.Test;

import asmeta.fmvclib.testrunner.AsmetaFMVCTestRunner;
import atgt.coverage.AsmTestSequence;
import atgt.coverage.AsmTestSuite;
import atgt.testseqexport.ToAvallaLastAction;
import atgt.testseqexport.toAvalla;
import asmeta.AsmCollection;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;
import view.AMANView;

public class TestAMAN {

	private static final int STEP = 500;
	private static final String MODEL_AMAN = "model/aman2.asm";

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
	
	@Test
	public void test0() throws Exception {
		runTestScenario("model/test0.avalla");
	}
	
	@Test
	public void test1() throws Exception {
		runTestScenario("model/test1.avalla");
	}
	
	@Test
	public void testGenerateAndRun() throws Exception {		
		Environment.timeMngt = TimeMngt.auto_increment;
		AsmCollection asm = ASMParser.setUpReadAsm(new File(MODEL_AMAN));
		List<String> stepActions = Arrays.asList("action","zoom","timeToLock");
		AsmTestGeneratorBySimulation atgt = new AsmTGBySimulationOnAction(asm, 3, 5, stepActions);
		AsmTestSuite tests = atgt.getTestSuite();
		int counter = 0;
		for (AsmTestSequence test : tests.getTests()) {
			UnchangedRemover.monRemover.optimize(test);
			UnecessaryChangesRemover opt2 = new UnecessaryChangesRemover(asm);
			opt2.optimize(test);
			ToAvallaLastAction export =  new ToAvallaLastAction(new FileOutputStream(new File("temp/test" + counter + ".avalla")),test, MODEL_AMAN, "test" + counter, stepActions);
			export.saveToStream();
			runTestScenario("temp/test" + counter + ".avalla");
			counter++;
		}
	}

	public void runTestScenario(String scenario) throws Exception, ClassNotFoundException, InstantiationException,
			IllegalAccessException, UnsupportedLookAndFeelException, IOException, InterruptedException {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel(MODEL_AMAN);
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.getTimer().stop();
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, controller, scenario, Arrays.asList("NONE"), STEP);
		runner.runTest();
	}
}
