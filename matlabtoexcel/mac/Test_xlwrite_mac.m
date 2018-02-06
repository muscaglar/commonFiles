%% Test script for excel write (xlwrite in OS X)

 import mymxl.*;
 import jxl.*;   

 mat1=randn(20,150,5);
 
 xlwrite_mac('mat1_excel.xls',mat1)