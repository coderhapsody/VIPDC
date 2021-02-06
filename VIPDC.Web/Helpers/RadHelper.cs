using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using VIPDC.Providers;

namespace VIPDC.Web.Helpers
{
    public static class RadHelper
    {
        public static int[] GetRowIdForDeletion(RadGrid radGrid)
        {
            return
                radGrid.Items.Cast<GridDataItem>()
                        .Where(row => (row.FindControl("chkDelete") as CheckBox).Checked)
                        .Select(row => Convert.ToInt32(row.GetDataKeyValue("ID")))
                        .ToArray();
        }

        public static void SetUpGrid(RadGrid radGrid)
        {
            radGrid.Columns[0].Display = false;
            radGrid.PageSize = Convert.ToInt32(ConfigurationManager.AppSettings[ApplicationSettingKeys.PageSize]);
        }
    }
}