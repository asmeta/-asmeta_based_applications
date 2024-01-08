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
public class CalcView extends JFrame implements AsmetaFMVCView {
    // Campi della view
	@AsmetaMonitoredLocation(asmLocationName="number")
    private JTextField m_userInputTf = new JTextField(5);
	
	@AsmetaControlledLocation(asmLocationName="calc_result")
    private JTextField m_totalTf     = new JTextField(20);
	
    @AsmetaMonitoredLocation(asmLocationName="operation", asmLocationValue = "MULT")
    @AsmetaRunStep
    private JButton    m_multiplyBtn = new JButton("Multiply");
    
    // Costruttore
    public CalcView() {
    	// Il model implementa Observable, aggiungo al modello un Observer 
    	// (la view stessa)
    	//m_model.addObserver(this);
    	
    	// Inizio a configurare la vista
        m_totalTf.setEditable(false);
        
        // Layout dei componenti  
        JPanel content = new JPanel();
        content.setLayout(new FlowLayout());
        content.add(new JLabel("Input"));
        content.add(m_userInputTf);
        content.add(m_multiplyBtn);
        content.add(new JLabel("Total"));
        content.add(m_totalTf);
        
        // Creo il contenitore...
        this.setContentPane(content);
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
        return m_userInputTf.getText();
    }    
    
    // Rende disponibile all'esterno l'eventuale testo del messaggio di errore 
    public void showError(String errMessage) {
        JOptionPane.showMessageDialog(this, errMessage);
    }
    
    public JTextField getmTotalTf() {
    	return this.m_totalTf;
    }

	@Override
	public void repaintView(boolean firstTime) {

	}

}
