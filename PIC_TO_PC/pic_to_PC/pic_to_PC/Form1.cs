using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
namespace pic_to_PC
{
    public partial class Form1 : Form
    {
        SerialPort port = new SerialPort("COM2", 9600, Parity.None, 8, StopBits.One);
        public Form1()
        {
            InitializeComponent();
            port.Open();
            port.DataReceived += new
            SerialDataReceivedEventHandler(DataReceivedHandler);
        }
        private void DataReceivedHandler(object sender, SerialDataReceivedEventArgs e)
        {
            port = (SerialPort)sender;
            String w = port.ReadLine();
            int Size = w.Length;
            if (w != string.Empty && w[0] == 'M')
            {
                Invoke(new Action(() => motionlabel.Text = w));
            }
            else if (w != string.Empty && w[Size - 2] == 'C')
            {
                Invoke(new Action(() => temperatureLabel.Text = w));
            }
            else if (w != string.Empty && w[Size - 2] == '%')
            {
                Invoke(new Action(() => humidityLabel.Text = w));
            }



        }


    }
}
     
