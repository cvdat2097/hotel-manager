   M S B A M L   `   `   `  ����  HotelManager"    HotelManager.Room.RoomStatus   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5        N� Title$  
RoomStatus��5      $	��543��6   $	��945��6"    N� 
Background
 �����.��5
      � .+�5   
   &   System.Windows.Controls.DataGrid  $��	15,10,0,0q�6   $	��Top=�6&   $	��497��6>   $	��658��6K   $
��Left=�6W      Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Status��6&      HeaderStringFormat$  ��6m   1  +System.Windows.Controls.DataGridBoundColumn   Binding 67   Z�    ClipboardContentBinding 6J   Z� 6m     5      $ Room Number��6&   $	 dsf��6r    6<   Z�  6O   Z� 6r     5      $
 Type��6&   $  ��6k    65   Z�  6H   Z� 6k     5      $ Price��6&   $  ��6l    66   Z�  6I   Z� 6l     5      $ Check-in Date��6&   $  ��6t    6>   Z�  6Q   Z� 6t     5      $ Check-out Date��6&   $  ��6u    6?   Z�  6R   Z� 6u     5      $ Booked Date��6&   $  ��6r    6<   Z�  6O   Z� 6r     5      $ Action��6&   $  ��6m    67   Z�  6J   Z� 6m   5      �� 5   
   $��Search Room��6   $
��Left=�6(   $��
679,69,0,0q�6C   $	��Top=�6W   $	��206��6o   $	��256��6|   .��5      � .+�5      �� $��Search��6   $
��Left=�6*   $��
10,150,0,0q�6E   $	��Top=�6Y   $	��107��6q   $
��Bold"�6}   �� 5      $��Date:��6   $
��Left=�6(   $��	10,11,0,0q�6C   $	��Top=�6V   $��97��6n   (  "System.Windows.Controls.DatePicker  5      $
��Left=�6   $��	10,37,0,0q�68   $	��Top=�6K   $	��224��6c   �� 5      $
��Left=�6   $��	10,97,0,0q�66   $	��Top=�6I   $	��224��6a    �� 
IsReadOnly .  �� 
IsEditable . $��14(�6�   .@�5      �� $	��VIP��6   $
��Left=�6-   $	��Top=�6H   �� 5      $��Normal��6   $
��Left=�60   $	��Top=�6K   �� 5      $��Hourly��6   $
��Left=�60   $	��Top=�6K   5       �� 5!      $��
Room type:��6   $
��Left=�6-   $��	10,66,0,0q�6H   $	��Top=�6[   5"      5#      �� 5$   
   $��	Rex Hotel��6   $
��Left=�6$   $��	689,0,0,0q�6?   $	��Top=�6R   $��30(�6j   $��Stencil)�6x   �� 5%   
   $(��"5 Stars, Ho Chi Minh City, Vietnam��6   $
��Left=�6=   $��
754,38,0,0q�6X   $	��Top=�6l   5&      5'      