   M S B A M L   `   `   `  ����   HotelManager     HotelManager.Room.RoomList   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008       N� Title$  RoomList��$	��543��$	��945�� N� 
Background
 �����.��� -    �Name$ 
pgRoomList��.+�&   System.Windows.Controls.DataGrid  -     Name$ dgRoom��$��	15,10,0,0q�$	��Top=�$	��497��$	��658��$
��Left=�   ColumnWidth5  /System.Windows.Controls.DataGridLengthConverter$ *    
IsReadOnly . �� $��Room Booking��$
��Left=�$��
679,69,0,0q�$	��Top=�$	��207��$	��256��.��� .+��� -    ��Name$ btnBook��$
��Book��$
��Left=�$��
10,152,0,0q�$	��Top=�$	��107��$
��Bold"��� $��Check-in date:��$
��Left=�$��	10,10,0,0q�$	��Top=�$��97���� $��Check-out date:��$
��Left=�$��	10,65,0,0q�$	��Top=�$	��120��(  "System.Windows.Controls.DatePicker  -     Name$ 
dpkCheckin��$
��Left=�$��	10,36,0,0q�$	��Top=�$	��224��  -   $ dpkCheckout��$
��Left=�$��	10,96,0,0q�$	��Top=�$	��224���� -    ��Name$ lblHotelName��$��	Rex Hotel��$
��Left=�$��	689,8,0,0q�$	��Top=�$��25(�$��Stencil)�$	��246��$��Center=��� -   $ 
lblAddress��$(��"5 Stars, Ho Chi Minh City, Vietnam��$
��Left=�$��
754,43,0,0q�$	��Top=�