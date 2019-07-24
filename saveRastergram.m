function saveRastergram(folder,filepath,fig,index)

if exist('index','var')
    fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram-',int2str(index));
else
    fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram');
end
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 5];
saveas(fig,fullFilepathRastergram,'fig');
saveas(fig,fullFilepathRastergram,'png');
saveas(fig,fullFilepathRastergram,'emf');
set(fig,'PaperSize',[fig.PaperPosition(3), fig.PaperPosition(4)]);
print(fig,fullFilepathRastergram,'-dpdf','-r0')
end