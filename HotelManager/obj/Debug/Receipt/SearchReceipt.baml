   M S B A M L   `   `   `  ����  HotelManager(    "HotelManager.Receipt.SearchReceipt   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5        N� Title$  SearchReceipt��5      $	��543��6   $	��945��6%    N� 
Background
 �����.��5
      � .+�5   
   �� $��Search��6   $
��Left=�6#   $��	679,0,0,0q�6>   $	��Top=�6Q   $	��252��6i   $	��256��6v   .��5      � .+�5      �� $��Search��6   $
��Left=�6*   $��
10,195,0,0q�6E   $	��Top=�6Y   $	��107��6q   $
��Bold"�6}   �� 5      $
��Left=�6   $��	11,39,0,0q�65   $	��Top=�6H   $	��223��6`   $��14(�6l   �� 5      $��Customer ID:��6   $
��Left=�6/   $��	10,13,0,0q�6J   $	��Top=�6]   $	��138��6u   �� 5      $
��Left=�6   $��	11,96,0,0q�65   $	��Top=�6H   $	��106��6`   $��14(�6l   �� 5      $��From:��6   $
��Left=�6(   $��	11,65,0,0q�6C   $	��Top=�6V   $��60��6n    J� RenderTransformOrigin$ -3.577,0.077&�6y   �� 5      $��Clear��6   $
��Left=�6)   $��127,195,0,0q�6D   $	��Top=�6Y   $	��107��6q   �� 5      $
��Left=�6   $��
127,96,0,0q�65   $	��Top=�6I   $	��107��6a   $��14(�6m   �� 5      $	��To:��6   $
��Left=�6&   $��
127,65,0,0q�6A   $	��Top=�6U   $��60��6m   $ -3.577,0.077&�6x   �� 5      $��Issue Date:��6   $
��Left=�6.   $��
10,122,0,0q�6I   $	��Top=�6]   $	��138��6u   (  "System.Windows.Controls.DatePicker  5      $
��Left=�6   $��
10,153,0,0q�68   $	��Top=�6L   $	��224��6d   5      5      &   System.Windows.Controls.DataGrid  5   
   $��	15,10,0,0q�6   $	��Top=�6&   $	��497��6>   $	��658��6K   $
��Left=�6W      Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Receipt No.��6&      HeaderStringFormat$	 dsf��6r   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6<   Z�    ClipboardContentBinding 6O   Z� 6r     5      $
 Date��6&   $  ��6k    65   Z�  6H   Z� 6k     5      $ Total��6&   $  ��6l    66   Z�  6I   Z� 6l   5       �� 5!   
   $��Export Receipt��6   $
��Left=�6+   $	��Top=�6F   $��678,267,0,0q�6^   $	��126��6s   $	��257��6�   .��5"      � .+�5#      �� $
��Left=�6   $��23��65   $��	10,41,0,0q�6A    �� TextWrapping$
 Wrap=�6T   $�� ��6h   $	��Top=�6p   $	��225��6�   �� 5$      $��Booking ID: ��6   $
��Left=�6/   $	��Top=�6J   $��	10,10,0,0q�6b   �� 5%      $��Export��6   $
��Left=�6*   $��	10,78,0,0q�6E   $	��Top=�6X   $	��107��6p   $
��Bold"�6|   5&      5'      5)      5*      