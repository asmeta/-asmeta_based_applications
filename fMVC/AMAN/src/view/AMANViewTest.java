package view;

import static org.junit.Assert.*;

import org.junit.Test;

import asmeta.fmvclib.model.AsmetaFMVCModel;
import controller.AMANController;

public class AMANViewTest {

	@Test
	public void test() throws Exception {
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.setVisible(true);
		System.out.println(view.airplaneLabels.getModel().getValueAt(18, 0));
		assertEquals("a3", view.airplaneLabels.getModel().getValueAt(18, 0));
		assertEquals("45", view.lblZoomValue.getText());
		
		view.btnHold.doClick();
	}

}
