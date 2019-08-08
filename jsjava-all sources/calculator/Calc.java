import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JMenu;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JPanel;
import java.awt.FlowLayout;


public class Calc {

	private JFrame frame;
	private JTextField textField;
	private JTextField textField1;
	private JTextField textField2;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Calc window = new Calc();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public Calc() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 300, 400);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBounds(24, 172, 247, 120);
		frame.getContentPane().add(panel);
		panel.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
		
		textField = new JTextField();
		textField.setBounds(22, 56, 254, 50);
		frame.getContentPane().add(textField);
		textField.setColumns(10);
		
		textField1 = new JTextField();
		textField1.setBounds(146, 111, 130, 26);
		frame.getContentPane().add(textField1);
		textField1.setColumns(10);
		
		textField2 = new JTextField();
		textField2.setBounds(146, 138, 130, 26);
		frame.getContentPane().add(textField2);
		textField2.setColumns(10);
		
		JLabel lblInput = new JLabel("Input 1:");
		lblInput.setBounds(48, 118, 61, 16);
		frame.getContentPane().add(lblInput);
		
		JLabel lblInput_1 = new JLabel("Input 2");
		lblInput_1.setBounds(48, 144, 61, 16);
		frame.getContentPane().add(lblInput_1);
		
		JMenuBar menuBar = new JMenuBar();
		menuBar.setBounds(0, 0, 294, 31);
		frame.getContentPane().add(menuBar);
		
		JMenu mnNewMenu = new JMenu("View");
		menuBar.add(mnNewMenu);
		
		
		
		JButton button_1 = new JButton("*");
		button_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a = 0; double b = 0; double c;
					
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField1.getText().isEmpty() && !textField2.getText().isEmpty() ) 
					{
						a = Double.parseDouble(textField1.getText() );
						b = Double.parseDouble(textField2.getText() );
					}				
					c = a * b;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(button_1);
		
		JButton button_2 = new JButton("/");
		button_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a = 0; double b = 0;
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField1.getText().isEmpty() && !textField2.getText().isEmpty() ) 
					{
						a = Double.parseDouble(textField1.getText() );
						b = Double.parseDouble(textField2.getText() );
					}
					
					if (b == 0) 
					{
						JOptionPane.showMessageDialog(null, "can't divide by 0");
						return;
					}
					double c = a / b;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(button_2);
		
		JButton btnNewButton = new JButton("-");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a= 0 ; double b=0; double c;
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField1.getText().isEmpty() && !textField2.getText().isEmpty() ) 
					{
						a = Double.parseDouble(textField1.getText() );
						b = Double.parseDouble(textField2.getText() );
					}
					c = a - b;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(btnNewButton);
		
		JButton button = new JButton("+");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a =0; double b=0; double c;
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField1.getText().isEmpty() && !textField2.getText().isEmpty() ) 
					{
						a = Double.parseDouble(textField1.getText() );
						b = Double.parseDouble(textField2.getText() );
					}
					c = a + b;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(button);
		
		JButton btnx = new JButton("1/x");
		btnx.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a=0; double b=0; double c = 0;
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField.getText().isEmpty()  ) 
					{
						c = Double.parseDouble(textField.getText() ); 
					}
					if (c == 0) 
					{
						JOptionPane.showMessageDialog(null, "can't divide by 0");
						return;
					}
					c = 1 / c;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(btnx);
		
		JButton button_4 = new JButton("%");
		button_4.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try 
				{
					double a=0; double b=0; double c = 0;
					if ( textField1.getText().isEmpty() )     
					{ 
						a = 0; 
						textField1.setText(Double.toString(a) );
					}
					if ( textField2.getText().isEmpty() )     
					{ 
						b = 0; 
						textField2.setText(Double.toString(b) );
					}
					
					if ( !textField.getText().isEmpty()  ) 
					{
						c = Double.parseDouble(textField.getText() ); 
					}
					c = c / 100;
					textField.setText(Double.toString(c) );
				}
				catch (Exception e1) 
				{
					JOptionPane.showMessageDialog(null, "invalid input, try another number");
				}
			}
		});
		panel.add(button_4);
		
		JButton btnSqrt = new JButton("sqrt");
		panel.add(btnSqrt);
		
		JButton btnAc = new JButton("AC");
		panel.add(btnAc);
		
		JButton button_3 = new JButton("=");
		panel.add(button_3);
		
		
		
	}
}
