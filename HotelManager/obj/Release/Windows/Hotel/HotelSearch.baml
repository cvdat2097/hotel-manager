   M S B A M L   `   `   `  ����   HotelManager$    HotelManager.Hotel.HotelSearch   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     -     N�Name$  pgHotelSearch�� N� Title$ HotelSearch��$	��543��$	��945�� N� 
Background
 �����.��� .+��� $��Search��$
��Left=�$��	679,0,0,0q�$	��Top=�$	��216��$	��256��.��� .+��� -    ��Name$ 	btnSearch��$��Search��$
��Left=�$��
10,134,0,0q�$	��Top=�$	��107��$
��Bold"��� -    ��Name$ txtCity��$
��Left=�$��	10,37,0,0q�$	��Top=�$	��169�� �� 
IsReadOnly .  $��14(�$��25���� $��City:��$
��Left=�$��	10,11,0,0q�$	��Top=��� -   $ txtPriceFrom��$
��Left=�$��	11,97,0,0q�$	��Top=�$	��106��$��14(��� $��Price from:��$
��Left=�$��	11,71,0,0q�$	��Top=�$��91���� -   $ 
txtPriceTo��$
��Left=�$��
123,97,0,0q�$	��Top=�$	��111��$��14(��� $��	Price to:��$
��Left=�$��
123,71,0,0q�$	��Top=�$��70���� $��Star:��$
��Left=�$��
184,11,0,0q�$	��Top=��� -    ��Name$ cmbStar��$
��Left=�$��
184,37,0,0q�$	��Top=�$��50�� �� 
IsReadOnly . $��14(�.@��� $��1���� $��2���� $��3���� $��4����  �� 
IsSelected . $��5���� -   $ btnShowRoom��$��
Show Rooms��$
��Left=�$��127,134,0,0q�$	��Top=�$	��107��&   System.Windows.Controls.DataGrid  -   	  Name$	 dgHotel��$��	15,10,0,0q�$	��Top=�$	��497��$	��658��$
��Left=�$
 �� IsSynchronizedWithCurrentItem$
 FalseY�   ColumnWidth5  /System.Windows.Controls.DataGridLengthConverter$ *    
IsReadOnly . �� -	    ��Name$ 	lblStatus��$�� ��$
��Left=�$	��Top=�$��744,184,0,0q�$��10(�$��Right=�$	��176��