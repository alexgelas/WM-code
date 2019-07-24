function saveXcorr(folder,filepath,fig)

fullFilepathXcorr=strcat(folder,'/',filepath,'-xcorr');
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 5];
saveas(fig,fullFilepathXcorr,'fig');
saveas(fig,fullFilepathXcorr,'png');
set(fig,'PaperSize',[fig.PaperPosition(3), fig.PaperPosition(4)]);
print(fig,fullFilepathXcorr,'-dpdf','-r0')
end