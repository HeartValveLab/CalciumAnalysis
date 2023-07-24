for iz=1:length(zname)

zplane      =   padnumber(3,str2num(char(extractBefore(extractAfter(zname{iz},'_z_'),'_t'))));
    rTimepoint	=	padnumber(3,str2num(char(extractBefore(extractAfter(zname{iz},'_t_'),'.tif'))));
   
    znameIm{iz,4} = zplane;
    znameIm{iz,5} = rTimepoint;
    
end