clear
set more off
cd C:\Users\Lena\Desktop\ecmdz6
log using homeass2_kasianova_shulyak.log, text replace

use "C:\Users\Lena\Desktop\ecmdz6\crime4.dta", clear 

gen lpolpc1 = lpolpc-clpolpc

scatter lcrmrte lpolpc
scatter lcrmrte ldensity
scatter lcrmrte lpctymle

scatter lcrmrte county
scatter lcrmrte lpctymle
scatter lcrmrte lprbarr
scatter lcrmrte lavgsen
corr lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc
reg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc
xtset country year
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc, be
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc, fe
predict uu, u

local list "lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc"
foreach xx of local list {
display "`xx'"
xtreg `xx', fe
predict mm, xb
predict u1, u
gen tm_ `xx' = u1+mm
drop ul mm
}
\
reg uu west central urban pctmin80 tm_lprbarr tm_lprbconv tm_lprbpris tm_lavgsen tm_lpol

xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc d8*, fe

test d82 d83 d84 d85 d86 d87
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc d8* ldensity lwcon lwtuc lwtrd lw
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc, re
xttest0
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc, re
est store RE
xtreg lcrmrte lprbarr lprbconv lprbpris lavgsen lpolpc, fe
est store FE
hausman FE RE, sigmamore
