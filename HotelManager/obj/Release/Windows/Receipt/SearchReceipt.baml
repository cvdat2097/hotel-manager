   M S B A M L   `   `   `  ����   HotelManager(    "HotelManager.Receipt.SearchReceipt   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     -     N�Name$  pdgSearchReceipt�� N� Title$ SearchReceipt��$	��543��$	��945�� N� 
Background
 �����.��� .+��� $��Search��$
��Left=�$��	679,0,0,0q�$	��Top=�$	��280��$	��256��.��� .+��� -    ��Name$ 	btnSearch��$��Search��$
��Left=�$��
10,195,0,0q�$	��Top=�$	��107��$
��Bold"��� -    ��Name$ txtCustomerId��$��KH001��$
��Left=�$��	11,39,0,0q�$	��Top=�$	��223��$��14(��� $��Customer ID:��$
��Left=�$��	10,13,0,0q�$	��Top=�$	��138���� -   $ txtPriceFrom��$��0��$
��Left=�$��	11,96,0,0q�$	��Top=�$	��106��$��14(��� $��Price from:��$
��Left=�$��	11,65,0,0q�$	��Top=�$��95�� J� RenderTransformOrigin$ -3.577,0.077&��� -   $ 
txtPriceTo��$
��2000��$
��Left=�$��
127,96,0,0q�$	��Top=�$	��107��$��14(��� $��	Price to:��$
��Left=�$��
127,65,0,0q�$	��Top=�$��60��$ -3.577,0.077&��� $��Issued Date:��$
��Left=�$��
10,122,0,0q�$	��Top=�$	��138��(  "System.Windows.Controls.DatePicker  -     Name$ dpkIssuedDate��$
��Left=�$��
10,153,0,0q�$	��Top=�$	��224���� -    ��Name$ 	lblStatus��$��Status��$
��Left=�$	��Top=�$��
69,232,0,0q�$	��165��$��Right=��� -   $ 	btnExport��$��Export��$
��Left=�$��122,195,0,0q�$	��Top=�$	��107��$
��Bold"�&   System.Windows.Controls.DataGrid  -	     Name$ 	dgReceipt��$��	15,10,0,0q�$	��Top=�$	��497��$	��658��$
��Left=�	   ColumnWidth5  /System.Windows.Controls.DataGridLengthConverter$	 * 
   
IsReadOnly
 . �� -
   $��Demo Detail��$
��Left=�$	��Top=�$��75��$��773,487,0,0q�