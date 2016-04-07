using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.IO;
using System.Threading.Tasks;

namespace ChangeFileName
{
    public partial class MyService : ServiceBase
    {
        public MyService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            
          var result= CreateCopyFile();
        }
        static bool CreateCopyFile()
        {
            var datePreStamp = DateTime.Now.AddMinutes(-1).ToString("ddMMyy_hhmm");
            var dateNowstamp = DateTime.Now.ToString("ddMMYY_hhmm");
            var file = @"c:\tempa" + dateNowstamp.ToString() + ".txt";
            var preFile= @"c:\tempa" + datePreStamp.ToString() + ".txt";
            // exceptions:
            if (System.IO.File.Exists(file))
            {
                throw new Exception("the file already exists");
            }else if (!(File.Exists(preFile)))
            {
                throw new Exception("the pre file exists");
            }
            else
            {
                File.Create(file);
                File.Delete(preFile);
            }
         return true;
        }
        protected override void OnStop()
        {
        }
    }
}
