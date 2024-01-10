import static org.junit.Assert.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
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

import asmeta.AsmCollection;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import asmeta.fmvclib.testrunner.AsmetaFMVCTestRunner;
import atgt.coverage.AsmTestSequence;
import atgt.coverage.AsmTestSuite;
import atgt.testseqexport.ToAvallaLastAction;
import controller.CalcController;
import view.SimpleCalculatorView;

public class TestSimpleCalculator {

	public static final String MODEL = "model/SimpleCalculator.asm";
	public static final int STEP = 50;
	
	@Test
	public void testGenerateAndRun() throws Exception {
		Environment.timeMngt = TimeMngt.auto_increment;
		AsmCollection asm = ASMParser.setUpReadAsm(new File(MODEL));
		List<String> stepActions = Arrays.asList("math_action", "mem_action");
		AsmTestGeneratorBySimulation atgt = new AsmTGBySimulationOnAction(asm, 10, 10, stepActions);
		AsmTestSuite tests = atgt.getTestSuite();
		int counter = 0;
		for (AsmTestSequence test : tests.getTests()) {
			UnecessaryChangesRemover opt2 = new UnecessaryChangesRemover(asm);
			opt2.optimize(test);
			File file = new File("temp/test" + counter + ".avalla");
			ToAvallaLastAction export = new ToAvallaLastAction(new FileOutputStream(file), test, MODEL,
					"test" + counter, stepActions);
			export.saveToStream();
			runTestScenario("temp/test" + counter + ".avalla");
			counter++;
		}
	}

	public void runTestScenario(String scenario) throws Exception, ClassNotFoundException, InstantiationException,
			IllegalAccessException, UnsupportedLookAndFeelException, IOException, InterruptedException {
		// Define the model
		AsmetaFMVCModel model = new AsmetaFMVCModel(MODEL);
		SimpleCalculatorView view = new SimpleCalculatorView();
		CalcController controller = new CalcController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		// Create the test runner
		AsmetaFMVCTestRunner runner = new AsmetaFMVCTestRunner(view, controller, scenario, Collections.emptyList(), STEP);
		runner.runTest();
	}

}
