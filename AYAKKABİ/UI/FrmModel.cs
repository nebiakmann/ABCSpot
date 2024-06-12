using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ABCSpot.UI
{
    public partial class FrmModel : Form
    {
        public FrmModel()
        {
            InitializeComponent();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
        }

        public Model Model { get; set; }
        public bool Güncelleme { get; set; } = false;
        public object Urun { get; internal set; }

        private void btnOK_Click(object sender, EventArgs e)
        {
            if (!ErrorControl(txtAd)) return;
            if (!ErrorControl(cbnumara)) return;
            if (!ErrorControl(nmFiyat)) return;
            if (!ErrorControl(cbRenk)) return;

            Model.Ad = txtAd.Text;
            Model.Numara = cbnumara.Text;
            Model.Fiyat = (double)nmFiyat.Value;
            Model.Birim = cbRenk.Text;

            DialogResult = DialogResult.OK;
        }

        private bool ErrorControl(Control c)
        {
            if (c is TextBox || c is ComboBox)
            {
                if (string.IsNullOrEmpty(c.Text))
                {
                    errorProvider1.SetError(c, "Eksik veya hatalı bilgi");
                    c.Focus();
                    return false;
                }
                else
                {
                    errorProvider1.SetError(c, "");
                    return true;
                }
            }

            if (c is NumericUpDown)
            {
                if (((NumericUpDown)c).Value == 0)
                {
                    errorProvider1.SetError(c, "Eksik veya hatalı bilgi");
                    c.Focus();
                    return false;
                }
                else
                {
                    errorProvider1.SetError(c, "");
                    return true;
                }
            }

            return true;
        }

        private void FrmModel_Load(object sender, EventArgs e)
        {
            txtID.Text = Model.ID.ToString();
            if (Güncelleme)
            {
                txtAd.Text = Model.Ad;
                nmFiyat.Value = (decimal)Model.Fiyat;
                cbRenk.Text = Model.Birim;
            }
        }
    }

    public partial class Model
    {
        public int ID { get; set; }
        public string Ad { get; set; }
        public string Numara { get; set; }
        public double Fiyat { get; set; }
        public string Birim { get; set; }

        public static implicit operator Model(ABCSpot.Model v)
        {
            throw new NotImplementedException();
        }
    }
}
