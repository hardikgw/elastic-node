# mat4BinSmooth function
#  The lexical scope of function include a function
#  in which it is defined.  
#
#  Functions defined in the mat4BinSmooth
#  function have access to the variables in 
#  mat4BinSmooth.
# 
#  offDiag() and onDiag() have access to the
#  variables in mat4BinSmooth  
# 
#  In panel.hexbinplot I used
#  arguments like xbins=xbins with
#  no problem.
# 
#  In panel.loess I had to use new names
#  such as span=smSpan for the ui input
#  values to make changes.  There may
#  be a concept I am missing related to 
#  the if statement, the use of do.call()
#  or the context of the function definition
#  that changes the rules.  

mat4BinSmooth <- function(dat,
  datTitle="",titleCex,
  varNam=NULL,varNamCex=.85,
  axisTextCex=.65, pScale=3,
  denCol=rgb(.7,.85,1),denLwd=2,
  xbins=15, border=gray(.7), power=.4,
  sm=TRUE, smSpan, smDegree,smCol='red',smLwd=2){

  offDiag <- function(x, y, ...){
    panel.grid(h=-1,v=-1,...)
    panel.hexbinplot(x,y,xbins=xbins,...,
      border=border,trans=function(x)x^power)
    if(sm)panel.loess(x, y,span=smSpan,degree=smDegree,
      lwd=smLwd,lty=1,col='red',col.line=smCol)
  }

  onDiag <- function(x, ...){
    yrng <- current.panel.limits()$ylim
    d <- density(x, na.rm=TRUE)
    d$y <- with(d, yrng[1] + 0.95 * diff(yrng) * y / max(y) )
    panel.lines(d,col=denCol,lwd=denLwd)
    diag.panel.splom(x, ...)
  }

  splom(dat,as.matrix=TRUE,
    xlab='',main=datTitle,title.cex=titleCex, 
    varname=varNam, varname.font=2,
    varname.cex=varNamCex,
    pscale=pScale, axis.text.cex=axisTextCex,
    axis.text.line.height=0, axis.line.tck=.5,
    axis.text.col="purple",axis.text.font=2,
 
    panel=offDiag,
    diag.panel = onDiag
  )
}


