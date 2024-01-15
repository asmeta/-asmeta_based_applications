package controller;

import java.awt.Color;
import java.awt.Component;
import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Observable;

import javax.swing.JComponent;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

import asmeta.fmvclib.annotations.LocationType;
import asmeta.fmvclib.controller.AsmetaFMVCController;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import view.AMANView;

@SuppressWarnings("deprecation")
public class AMANController extends AsmetaFMVCController {

	public AMANController(AsmetaFMVCModel model, AMANView view)
			throws IllegalArgumentException, IllegalAccessException {
		super(model, view);

		// --------------------------------------------------------------------------------------------
		// Case-study-specific elements can be handled here by accessing this.initMap
		// --------------------------------------------------------------------------------------------
	}

	@Override
	public void update(Observable o, Object arg) {
		// Handle the main parameters as regularly done by the Asmeta FMVCLib
		super.update(o, arg);

		// --------------------------------------------------------------------------------------------
		// Case-study-specific elements can be handled by accessing this.updateSetMap
		// --------------------------------------------------------------------------------------------
		// Set the text on buttons based on the value in the TableModel
		updateButtonColumnStatus("blocked", ((AMANView) this.m_view).getIsLocked());

		// Set the color of cells
		setAirplaneLabelColors();
	}

	/**
	 * Sets the color of the labels for each airplane
	 */
	@SuppressWarnings("serial")
	public void setAirplaneLabelColors() {
		m_model.computeValue("landingSequenceColor", LocationType.INTEGER);
		List<Entry<String, String>> values = m_model.getValue("landingSequenceColor");
		JTable table = ((AMANView) this.m_view).getAirplaneLabels();
		ArrayList<String> colors = new ArrayList<>();

		// Iterate over the results
		int counter = 0;
		for (int i = 0; i < ((AMANView) this.m_view).getIsLockedModel().getRowCount(); i++) {
			if (counter < values.size()) {
				for (Entry<String, String> assignment : values) {
					if (!assignment.getValue().equals("undef")
							&& i == Integer.parseInt(assignment.getKey().split("_")[1])) {
						colors.add(assignment.getValue());
						counter++;
					}
				}
			} else
				colors.add("WHITE");
		}

		// Set the color
		table.setDefaultRenderer(Object.class, new DefaultTableCellRenderer() {
			@Override
			public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected,
					boolean hasFocus, int row, int column) {
				final Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row,
						column);
				try {
					if (colors.get(row).equals("WHITE") && table.getValueAt(row, column).equals("")) {
						((JComponent) c).setOpaque(false);
					} else {
						c.setBackground((Color) (Color.class.getField(colors.get(row))).get(null));
						((JComponent) c).setOpaque(true);
					}
				} catch (IllegalArgumentException | IllegalAccessException | NoSuchFieldException | SecurityException
						| IndexOutOfBoundsException | NullPointerException e) {
					((JComponent) c).setOpaque(false);
				}
				return c;
			}
		});

		table.repaint();
	}

}
