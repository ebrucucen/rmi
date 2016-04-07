using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RMI.RefCheckService
{
    class Program
    {
        static void Main(string[] args)
        {
            Run()
            var result=CreateFileCopy;
        }
       
    }
    private System.ComponentModel.IContainer components;
    private System.Diagnostics.EventLog eventLog1;

    public MyNewService()
    {
        InitializeComponent();
        var eventLog1 = new System.Diagnostics.EventLog();
        if (!System.Diagnostics.EventLog.SourceExists("MySource"))
        {
            System.Diagnostics.EventLog.CreateEventSource(
                "MySource", "MyNewLog");
        }
        eventLog1.Source = "MySource";
        eventLog1.Log = "MyNewLog";
    }

}
