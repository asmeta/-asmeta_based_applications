package view;

import java.awt.Color;
import java.awt.Font;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.JSpinner;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.SpinnerNumberModel;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.LineBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;

import asmeta.fmvclib.annotations.AsmetaControlledLocation;
import asmeta.fmvclib.annotations.AsmetaMonitoredLocation;
import asmeta.fmvclib.annotations.AsmetaRunStep;
import asmeta.fmvclib.controller.ButtonColumn;
import asmeta.fmvclib.view.AsmetaFMVCView;
import asmeta.fmvclib.view.XButtonModel;
import customcomponents.CustomSliderUI;

public class AMANView implements AsmetaFMVCView {

	private JFrame frame;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "NONE")
	@AsmetaMonitoredLocation(asmLocationName = "zoom")
	@AsmetaRunStep(repaintView = true)
	private JSlider zoom;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "HOLD")
	@AsmetaRunStep
	JButton btnHold;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "DOWN")
	@AsmetaRunStep
	JButton btnMoveUp;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "UP")
	@AsmetaRunStep
	JButton btnMoveDown;

	@AsmetaControlledLocation(asmLocationName = "mins")
	JLabel lblCurrentTimeMins;

	JLabel lblTwoDots;
	JPanel currentTimePanel;

	@AsmetaControlledLocation(asmLocationName = "hours")
	JLabel lblCurrentTimeHours;

	JPanel timelinePanel;

	@AsmetaControlledLocation(asmLocationName = "zoomValue")
	JLabel lblZoomValue;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "NONE")
	@AsmetaRunStep
	Timer guiTimer;

	@AsmetaControlledLocation(asmLocationName = "landingSequence")
	@AsmetaMonitoredLocation(asmLocationName = "selectedAirplane")
	JTable airplaneLabels;

	@AsmetaControlledLocation(asmLocationName = "timeShown")
	JTable times;
	
	JLabel lblMoves;

	@AsmetaMonitoredLocation(asmLocationName = "numMoves")
	JSpinner spnrNumMoves;
	SpinnerNumberModel modelSpnrNumMoves;

	@AsmetaMonitoredLocation(asmLocationName = "action", asmLocationValue = "NONE")
	@AsmetaMonitoredLocation(asmLocationName = "timeToLock")
	@AsmetaControlledLocation(asmLocationName = "blocked")
	@AsmetaRunStep
	ButtonColumn isLockedColumn;
	XButtonModel isLockedModel;
	JTable isLocked;

	public AMANView() throws ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedLookAndFeelException {
		
		// The application frame
		frame = new JFrame();
		frame.getContentPane().setBackground(new Color(56, 87, 35));
		frame.setResizable(false);
		frame.setBounds(100, 100, 777, 810);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		frame.setTitle("ASMETA Aman");

		// The zoom slider
		zoom = new JSlider() {
			@Override
            public void updateUI() {
                setUI(new CustomSliderUI(this));
            }
		};
		zoom.setSnapToTicks(true);
		zoom.setMajorTickSpacing(5);
		zoom.setValue(30);
		zoom.setMinorTickSpacing(5);
		zoom.setMaximum(45);
		zoom.setMinimum(15);
		zoom.setBounds(434, 168, 244, 43);
		zoom.setBackground(Color.BLACK);
		frame.getContentPane().add(zoom);

		// The GUI timer
		guiTimer = new Timer(60000, null);
		guiTimer.start();

		// The hold button
		btnHold = new JButton("HOLD");
		btnHold.setForeground(Color.RED);
		btnHold.setFont(new Font("Tahoma", Font.PLAIN, 16));
		btnHold.setBounds(434, 252, 302, 66);
		btnHold.setBackground(Color.BLACK);
		btnHold.setOpaque(true);
		btnHold.setBorder(new LineBorder(Color.WHITE));
		frame.getContentPane().add(btnHold);

		// The moveUp button
		btnMoveUp = new JButton("UP");
		btnMoveUp.setBounds(434, 359, 128, 43);
		btnMoveUp.setBackground(Color.BLACK);
		btnMoveUp.setOpaque(true);
		btnMoveUp.setBorder(new LineBorder(Color.WHITE));
		btnMoveUp.setForeground(Color.RED);
		btnMoveUp.setFont(new Font("Tahoma", Font.PLAIN, 16));
		frame.getContentPane().add(btnMoveUp);

		// The moveDown button
		btnMoveDown = new JButton("DOWN");
		btnMoveDown.setBounds(564, 359, 128, 43);
		btnMoveDown.setBackground(Color.BLACK);
		btnMoveDown.setOpaque(true);
		btnMoveDown.setBorder(new LineBorder(Color.WHITE));
		btnMoveDown.setForeground(Color.RED);
		btnMoveDown.setFont(new Font("Tahoma", Font.PLAIN, 16));
		frame.getContentPane().add(btnMoveDown);

		// The zoom value
		lblZoomValue = new JLabel("30");
		lblZoomValue.setHorizontalAlignment(SwingConstants.CENTER);
		lblZoomValue.setBounds(690, 168, 61, 43);
		lblZoomValue.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		lblZoomValue.setForeground(Color.white);
		frame.getContentPane().add(lblZoomValue);

		// The table with the components locking the time instant
		isLockedModel = new XButtonModel(Integer.parseInt(lblZoomValue.getText()));
		isLocked = new JTable(Integer.parseInt(lblZoomValue.getText()), 1);
		isLocked.setModel(isLockedModel);
		TableColumnModel columnModelLocked = isLocked.getColumnModel();
		isLocked.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		columnModelLocked.getColumn(0).setPreferredWidth(20);

		// The column containing buttons
		isLockedColumn = new ButtonColumn(isLocked, 0);
		
		// The label "Move"
		lblMoves = new JLabel("MOVE");
		lblMoves.setForeground(Color.RED);
		lblMoves.setFont(new Font("Tahoma", Font.PLAIN, 16));
		lblMoves.setBounds(434, 329, 302, 14);
		frame.getContentPane().add(lblMoves);
		
		// The panel containing data of minutes and hours
		currentTimePanel = new JPanel();
		currentTimePanel.setBounds(119, 0, 101, 40);
		currentTimePanel.setBackground(Color.black);
		currentTimePanel.setOpaque(true);
		currentTimePanel.setBorder(new LineBorder(Color.WHITE));
		frame.getContentPane().add(currentTimePanel);
		
		// The current time hours
		lblCurrentTimeHours = new JLabel() {
			@Override
			public void setText(String text) {
				super.setText(("00" + text).substring(text.length(), 2 + text.length()));
			}
		};
		currentTimePanel.add(lblCurrentTimeHours);
		lblCurrentTimeHours.setHorizontalAlignment(SwingConstants.RIGHT);
		lblCurrentTimeHours.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		lblCurrentTimeHours.setForeground(Color.white);
		
		// The current time dots
		lblTwoDots = new JLabel(":");
		currentTimePanel.add(lblTwoDots);
		lblTwoDots.setHorizontalAlignment(SwingConstants.CENTER);
		lblTwoDots.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		lblTwoDots.setForeground(Color.white);
		
		// The current time minutes
		lblCurrentTimeMins = new JLabel(){
			@Override
			public void setText(String text) {
				super.setText(("00" + text).substring(text.length(), 2 + text.length()));
			}
		};
		currentTimePanel.add(lblCurrentTimeMins);
		lblCurrentTimeMins.setHorizontalAlignment(SwingConstants.LEFT);
		lblCurrentTimeMins.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 24));
		lblCurrentTimeMins.setForeground(Color.white);

		repaintView(true);
	}

	/**
	 * It refreshes the view by repainting the part which is updated (in terms of
	 * number/type of components) when a step is performed
	 */
	@Override
	public void repaintView(boolean firstTime) {
		int nFlights = Integer.parseInt(lblZoomValue.getText());

		// The panel containing the timeline
		if (!firstTime) {
			timelinePanel.removeAll();
			timelinePanel.repaint();
		} else {
			timelinePanel = new JPanel();
			timelinePanel.setBounds(61, 40, 272, 890);
			timelinePanel.setOpaque(false);			
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
		spnrNumMoves.setBounds(695, 359, 41, 43);
		spnrNumMoves.setFont(new java.awt.Font("Tahoma", java.awt.Font.BOLD, 15));
		spnrNumMoves.setForeground(Color.white);	
		spnrNumMoves.setBackground(Color.BLACK);	
		spnrNumMoves.setBorder(new LineBorder(Color.WHITE));
		frame.getContentPane().add(spnrNumMoves);	
		spnrNumMoves.repaint();

		// The times
		times = new JTable(nFlights, 1);
		DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
		TableColumnModel columnModel = times.getColumnModel();
		columnModel.getColumn(0).setPreferredWidth(100);
		centerRenderer.setHorizontalAlignment(JLabel.CENTER);
		centerRenderer.setOpaque(false);
		columnModel.getColumn(0).setCellRenderer(centerRenderer);
		times.setDefaultEditor(Object.class, null);
		times.setEnabled(false);
		times.setShowGrid(true);
		times.setOpaque(false);
		times.setBorder(new LineBorder(Color.WHITE));
		times.setForeground(Color.white);		
		((DefaultTableCellRenderer) times.getDefaultRenderer(Object.class)).setOpaque(false);
		timelinePanel.add(times);

		// The airplaneLabels
		if (firstTime) {
			airplaneLabels = new JTable(nFlights, 1);
		} else {
			DefaultTableModel model = new DefaultTableModel(nFlights, 1);
			airplaneLabels.setModel(model);
		}
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

	public XButtonModel getIsLockedModel() {
		return isLockedModel;
	}

	public JTable getAirplaneLabels() {
		return airplaneLabels;
	}

	public void setVisible(boolean b) {
		frame.setVisible(true);
	}
	
	public Timer getTimer() {
		return this.guiTimer;
	}
	
}
