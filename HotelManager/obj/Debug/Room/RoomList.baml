   M S B A M L   `   `   `  ����  HotelManager     HotelManager.Room.RoomList   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5        N� Title$  RoomList��5      $	��543��6   $	��945��6!    N� 
Background
 �����.��5
      � .+�5   
   &   System.Windows.Controls.DataGrid  $��	15,10,0,0q�6   $	��Top=�6&   $	��497��6>   $	��658��6K   $
��Left=�6W      Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Room Number��6&      HeaderStringFormat$	 dsf��6r   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6<   Z�    ClipboardContentBinding 6O   Z� 6r     5      $
 Type��6&   $  ��6k    65   Z�  6H   Z� 6k     5      $ Price��6&   $  ��6l    66   Z�  6I   Z� 6l     5      $ Status��6&   $  ��6m    67   Z�  6J   Z� 6m   5      �� 5   
   $��Room Booking��6   $
��Left=�6)   $��
679,69,0,0q�6D   $	��Top=�6X   $	��207��6p   $	��256��6}   .��5      � .+�5      �� $
��Book��6   $
��Left=�6(   $��
10,152,0,0q�6C   $	��Top=�6W   $	��107��6o   $
��Bold"�6{   �� 5      $��Check-in date:��6   $
��Left=�61   $��	10,10,0,0q�6L   $	��Top=�6_   $��97��6w   �� 5      $��Check-out date:��6   $
��Left=�62   $��	10,65,0,0q�6M   $	��Top=�6`   $	��120��6x   (  "System.Windows.Controls.DatePicker  5      $
��Left=�6   $��	10,36,0,0q�68   $	��Top=�6K   $	��224��6c     5      $
��Left=�6   $��	10,96,0,0q�68   $	��Top=�6K   $	��224��6c   5      5      �� 5   
   $��	Rex Hotel��6   $
��Left=�6$   $��	689,0,0,0q�6?   $	��Top=�6R   $��30(�6j   $��Stencil)�6x   �� 5   
   $(��"5 Stars, Ho Chi Minh City, Vietnam��6   $
��Left=�6=   $��
754,38,0,0q�6X   $	��Top=�6l   5      5      