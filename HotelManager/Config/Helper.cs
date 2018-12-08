using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelManager
{
    public static class Helper
    {
        public static String generatePagingQuery(String tableName, int fromRow, int toRow)
        {
            return @"SELECT  *
                    FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY maKS ) AS RowNum, *
                                FROM      " + tableName + @") AS RowConstrainedResult
                    WHERE   RowNum >= " + fromRow.ToString() + @" AND RowNum < " + toRow.ToString() + @"
                    ORDER BY RowNum";
        }
    }
}
