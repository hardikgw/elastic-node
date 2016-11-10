# mat4BinSmooth function
#  In panel.hexbinplot I could use
#  argument like xbins=xbins,
#  In panel.loess I had to use new names
#  such as span=smSpan for the ui input
#  values to make changes.  There may
#  be a concept I am missing related to 
#  and/or the use of do.call()

mat4BinSmooth <- function(dat,title="",
  xbins=15, border=gray(.7), power,
  sm=TRUE, smSpan, smDegree,lineCol='red',smLwd=2){

  offDiag <- function(x, y, ...){
    panel.grid(h=-1,v=-1,...)
    panel.hexbinplot(x,y,xbins=xbins,...,
      border=border,trans=function(x)x^power)
     if(sm)panel.loess(x, y,span=smSpan,degree=smDegree,
      lwd=smLwd,lty=1,col='red',col.line=lineCol)
  }

  onDiag <- function(x, ...){
    yrng <- current.panel.limits()$ylim
    d <- density(x, na.rm=TRUE)
    d$y <- with(d, yrng[1] + 0.95 * diff(yrng) * y / max(y) )
    panel.lines(d,col=rgb(.83,.66,1),lwd=2)
    diag.panel.splom(x, ...)
  }

  splom(dat,as.matrix=TRUE,
    xlab='',main=title,
    pscale=0, varname.cex=0.8,axis.text.cex=0.6,
    axis.text.col="purple",axis.text.font=2,
    axis.line.tck=.5,
    panel=offDiag,
    diag.panel = onDiag
  )
}


