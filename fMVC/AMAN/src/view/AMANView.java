package view;

import java.awt.Color;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.SpinnerNumberModel;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumnModel;

import asmeta.fmvclib.annotations.AsmetaControlledLocation;
import asmeta.fmvclib.annotations.AsmetaMonitoredLocation;
import asmeta.fmvclib.annotations.AsmetaRunStep;
import asmeta.fmvclib.annotations.LocationType;
import asmeta.fmvclib.controller.ButtonColumn;
import asmeta.fmvclib.model.AsmetaFMVCModel;
import asmeta.fmvclib.view.AsmetaFMVCView;
import controller.AMANController;
import javax.swing.JSpinner;

public class AMANView implements AsmetaFMVCView {

	private JFrame frame;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "NONE")
	@AsmetaMonitoredLocation(asmLocationName = "zoom", asmLocationType = LocationType.INTEGER)
	@AsmetaRunStep(refreshGui = true)
	private JSlider zoom;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "HOLD")
	@AsmetaRunStep
	JButton btnHold;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "DOWN")
	@AsmetaRunStep
	JButton btnMoveUp;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "UP")
	@AsmetaRunStep
	JButton btnMoveDown;

	@AsmetaControlledLocation(asmLocationName = "mins", asmLocationType = LocationType.STRING)
	JLabel lblCurrentTimeMins;

	JLabel lblTwoDots;

	@AsmetaControlledLocation(asmLocationName = "hours", asmLocationType = LocationType.STRING)
	JLabel lblCurrentTimeHours;

	JPanel timelinePanel;

	@AsmetaControlledLocation(asmLocationName = "zoomValue", asmLocationType = LocationType.STRING)
	JLabel lblZoomValue;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "NONE")
	@AsmetaRunStep
	Timer guiTimer;

	@AsmetaControlledLocation(asmLocationName = "landingSequence", asmLocationType = LocationType.MAP, mapKeyType = LocationType.INTEGER)
	@AsmetaMonitoredLocation(asmLocationName = "selectedAirplane", asmLocationType = LocationType.RESERVE)
	JTable airplaneLabels;

	@AsmetaControlledLocation(asmLocationName = "timeShown", asmLocationType = LocationType.MAP, mapKeyType = LocationType.INTEGER)
	JTable times;

	@AsmetaMonitoredLocation(asmLocationName = "numMoves", asmLocationType = LocationType.INTEGER)
	JSpinner spnrNumMoves;
	SpinnerNumberModel modelSpnrNumMoves;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationType = LocationType.ENUM, asmLocationValue = "NONE")
	@AsmetaMonitoredLocation(asmLocationName = "timeToLock", asmLocationType = LocationType.INTEGER)
	@AsmetaRunStep
	ButtonColumn isLockedColumn;
	IsLockedModel isLockedModel;
	JTable isLocked;

	public AMANView() throws ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedLookAndFeelException {
		UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		
		// The application frame
		frame = new JFrame();
		frame.setResizable(false);
		frame.setBounds(100, 100, 900, 840);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		frame.setTitle("ASMETA Aman");

		// The zoom slider
		zoom = new JSlider();
		zoom.setSnapToTicks(true);
		zoom.setMajorTickSpacing(5);
		zoom.setValue(45);
		zoom.setMinorTickSpacing(5);
		zoom.setMaximum(45);
		zoom.setMinimum(15);
		zoom.setBounds(575, 168, 244, 43);
		frame.getContentPane().add(zoom);

		// The GUI timer
		guiTimer = new Timer(60000, null);
		guiTimer.start();

		// The hold button
		btnHold = new JButton("HOLD");
		btnHold.setBounds(575, 254, 302, 66);
		btnHold.setBackground(Color.LIGHT_GRAY);
		frame.getContentPane().add(btnHold);

		// The moveUp button
		btnMoveUp = new JButton("UP");
		btnMoveUp.setBounds(575, 326, 128, 66);
		btnMoveUp.setBackground(Color.LIGHT_GRAY);
		frame.getContentPane().add(btnMoveUp);

		// The moveDown button
		btnMoveDown = new JButton("DOWN");
		btnMoveDown.setBounds(704, 326, 128, 66);
		btnMoveDown.setBackground(Color.LIGHT_GRAY);
		frame.getContentPane().add(btnMoveDown);

		// The current time hours
		lblCurrentTimeHours = new JLabel("0");
		lblCurrentTimeHours.setHorizontalAlignment(SwingConstants.RIGHT);
		lblCurrentTimeHours.setBounds(136, 6, 50, 32);
		lblCurrentTimeHours.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		frame.getContentPane().add(lblCurrentTimeHours);

		// The current time dots
		lblTwoDots = new JLabel(":");
		lblTwoDots.setHorizontalAlignment(SwingConstants.CENTER);
		lblTwoDots.setBounds(183, 6, 19, 32);
		lblTwoDots.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		frame.getContentPane().add(lblTwoDots);

		// The current time minutes
		lblCurrentTimeMins = new JLabel("0");
		lblCurrentTimeMins.setHorizontalAlignment(SwingConstants.LEFT);
		lblCurrentTimeMins.setBounds(198, 6, 86, 32);
		lblCurrentTimeMins.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		frame.getContentPane().add(lblCurrentTimeMins);

		// The zoom value
		lblZoomValue = new JLabel("45");
		lblZoomValue.setHorizontalAlignment(SwingConstants.CENTER);
		lblZoomValue.setBounds(816, 168, 61, 43);
		lblZoomValue.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		frame.getContentPane().add(lblZoomValue);

		// The table with the components locking the time instant
		isLockedModel = new IsLockedModel(Integer.parseInt(lblZoomValue.getText()));
		isLocked = new JTable(Integer.parseInt(lblZoomValue.getText()), 1);
		isLocked.setModel(isLockedModel);
		TableColumnModel columnModelLocked = isLocked.getColumnModel();
		isLocked.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		columnModelLocked.getColumn(0).setPreferredWidth(20);

		// The column containing buttons
		isLockedColumn = new ButtonColumn(isLocked, 0);

		refreshView(true);
	}

	/**
	 * It refreshes the view by repainting the part which is updated (in terms of
	 * number/type of components) when a step is performed
	 */
	@Override
	public void refreshView(boolean firstTime) {
		int nFlights = Integer.parseInt(lblZoomValue.getText());

		// The panel containing the timeline
		if (!firstTime) {
			timelinePanel.removeAll();
			timelinePanel.repaint();
		} else {
			timelinePanel = new JPanel();
			timelinePanel.setBounds(61, 40, 272, 890);
			frame.getContentPane().add(timelinePanel);
		}

		// Remove rows if more than the necessary are shown
		while (isLockedModel.getRowCount() > nFlights)
			isLockedModel.removeRow(isLockedModel.getRowCount() - 1);

		// Add rows if fewer than the necessary are shown
		while (isLockedModel.getRowCount() < nFlights)
			isLockedModel.addRow();

		timelinePanel.add(isLocked);

		// The spinner containing the number of moves
		modelSpnrNumMoves = new SpinnerNumberModel(1, 1, nFlights, 1);
		spnrNumMoves = new JSpinner(modelSpnrNumMoves);
		spnrNumMoves.setBounds(834, 326, 43, 66);
		spnrNumMoves.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 15));
		frame.getContentPane().add(spnrNumMoves);
		spnrNumMoves.repaint();

		// The times
		times = new JTable(nFlights, 1);
		TableColumnModel columnModel = times.getColumnModel();
		columnModel.getColumn(0).setPreferredWidth(20);
		times.setDefaultEditor(Object.class, null);
		times.setEnabled(false);
		times.setShowGrid(false);
		times.setOpaque(false);
		((DefaultTableCellRenderer) times.getDefaultRenderer(Object.class)).setOpaque(false);
		timelinePanel.add(times);

		// The airplaneLabels
		airplaneLabels = new JTable(nFlights, 1);
		airplaneLabels.setDefaultEditor(Object.class, null);
		airplaneLabels.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		airplaneLabels.setShowGrid(false);
		airplaneLabels.setOpaque(false);
		((DefaultTableCellRenderer) airplaneLabels.getDefaultRenderer(Object.class)).setOpaque(false);
		timelinePanel.add(airplaneLabels);
	}

	public JTable getIsLocked() {
		return isLocked;
	}

	public IsLockedModel getIsLockedModel() {
		return isLockedModel;
	}

	public JTable getAirplaneLabels() {
		return airplaneLabels;
	}

	public static void main(String[] args) throws Exception {
		AsmetaFMVCModel model = new AsmetaFMVCModel("model/aman2.asm");
		AMANView view = new AMANView();
		AMANController controller = new AMANController(model, view);
		controller.updateAndSimulate(null);
		view.frame.setVisible(true);
	}
}
