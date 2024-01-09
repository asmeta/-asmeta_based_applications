package controller;

import java.awt.Color;
import java.util.Observable;

import asmeta.fmvclib.controller.AsmetaFMVCController;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import view.SimpleCalculatorView;

@SuppressWarnings("deprecation")
public class CalcController extends AsmetaFMVCController{

	public CalcController(AsmetaFMVCModel model, SimpleCalculatorView view)
			throws IllegalArgumentException, IllegalAccessException {
		super(model, view);
	}
	
	@Override
	public void update(Observable o, Object arg) {
		// Handle the main parameters as regularly done by the Asmeta FMVCLib
		super.update(o, arg);
	
		// Set the background color of the result text-box based on the sign
		if (Integer.parseInt(((SimpleCalculatorView)this.m_view).getmTotalTf().getText()) >= 0)
			((SimpleCalculatorView)this.m_view).getmTotalTf().setBackground(Color.GREEN);
		else
			((SimpleCalculatorView)this.m_view).getmTotalTf().setBackground(Color.RED);
		
	}

}
