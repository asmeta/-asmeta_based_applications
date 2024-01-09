package view;

import java.awt.*;
import javax.swing.*;

import asmeta.fmvclib.annotations.AsmetaControlledLocation;
import asmeta.fmvclib.annotations.AsmetaMonitoredLocation;
import asmeta.fmvclib.annotations.AsmetaRunStep;
import asmeta.fmvclib.annotations.LocationType;
import asmeta.fmvclib.view.AsmetaFMVCView;


// View della Calcolatrice. Implementiamo "Observer" per fare in modo di
// controllare le modifiche sul model e venir notificati ad ogni modifica
// del model
@SuppressWarnings("serial")
public class SimpleCalculatorView extends JFrame implements AsmetaFMVCView {
    // Campi della view
	@AsmetaMonitoredLocation(asmLocationName="number")
    private JTextField number = new JTextField(5);

	@AsmetaControlledLocation(asmLocationName="mem")
    private JTextField memory = new JTextField(5);

	
	@AsmetaControlledLocation(asmLocationName="calc_result")
    private JTextField calcresult     = new JTextField(20);
	
    @AsmetaMonitoredLocation(asmLocationName="math_action", asmLocationValue = "INC")
    @AsmetaRunStep
    private JButton    m_INCBtn = new JButton("INC");
    
    @AsmetaMonitoredLocation(asmLocationName="math_action", asmLocationValue = "DEC")
    @AsmetaRunStep
    private JButton    m_DECBtn = new JButton("DEC");

    @AsmetaMonitoredLocation(asmLocationName="mem_action", asmLocationValue = "MPLUS")
    @AsmetaRunStep
    private JButton    mPlusBtn = new JButton("M+");
    
    @AsmetaMonitoredLocation(asmLocationName="mem_action", asmLocationValue = "MRESET")
    @AsmetaRunStep
    private JButton    mResetBtn = new JButton("M reset");

    
    
    // Costruttore
    public SimpleCalculatorView() {
    	// Il model implementa Observable, aggiungo al modello un Observer 
    	// (la view stessa)
    	//m_model.addObserver(this);
    	
    	// Inizio a configurare la vista
    	calcresult.setEditable(false);
        
        // Layout dei componenti  
        JPanel mathPanel = new JPanel();
        mathPanel.setLayout(new FlowLayout());
        mathPanel.add(new JLabel("Input"));
        mathPanel.add(number);
        mathPanel.add(m_INCBtn);
        mathPanel.add(m_DECBtn);
        mathPanel.add(new JLabel("Total"));
        mathPanel.add(calcresult);
        
        JPanel memoryPanel = new JPanel();
        memoryPanel.setLayout(new FlowLayout());
        memoryPanel.add(mPlusBtn);
        memoryPanel.add(mResetBtn);
        memoryPanel.add(new JLabel("Memory"));
        memoryPanel.add(memory);
        
        JPanel allPanel = new JPanel();
        allPanel.setLayout(new BoxLayout(allPanel, BoxLayout.Y_AXIS));
        allPanel.add(mathPanel);
        allPanel.add(memoryPanel);
        // Creo il contenitore...
        this.setContentPane(allPanel);
        this.pack();
        // Imposto il titolo alla view
        this.setTitle("Simple Calc - MVC");
        // Imposto il meccanismo di chiusura sulla finestra
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
        
    /*
     * I metodi seguenti servono a chi detiene un riferimento alla view 
     * (il controller)
     * Se non ci fossero, il controller dovrebbe avere un riferimento 
     * esplicito a tutti gli elementi della view per poter svolgere 
     * operazioni. In questo modo, invece, � sufficiente avere il 
     * riferimento all'intera classe CalcView.
     */
    // Getter per rendere disponibile all'esterno il valore del campo 
    // testo del textField
    public String getUserInput() {
        return number.getText();
    }    
    
    // Rende disponibile all'esterno l'eventuale testo del messaggio di errore 
    public void showError(String errMessage) {
        JOptionPane.showMessageDialog(this, errMessage);
    }
    
    public JTextField getmTotalTf() {
    	return this.calcresult;
    }

	@Override
	public void repaintView(boolean firstTime) {

	}

}
