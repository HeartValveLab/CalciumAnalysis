function kpad=padnumber(no,it)
%% by Francesco Boselli

oo='000000000000000000000000000000000000000000000000000000000000000000000';
oo=oo(1:no);
it=num2str(it);
kpad=[oo(1:length(oo)-length(it)) it];


