# Jon Katz, February 25 2014
# Burlington UseR Meetup: Gamestorming

# Download the Superfoods.csv data, set the target directory as your working directory
# Read in the data and tidy it up
superfoods<-read.csv('Superfood.csv',stringsAsFactors=FALSE)
colnames(superfoods)<-superfoods[1,]
superfoods<-superfoods[-c(1,2),-c(26:38)]
rownames(superfoods)<-1:nrow(superfoods)
# All of the data types ar still wrong...easier to write it and read it in again to fix
write.csv(superfoods,"superfoodsTidy.csv",row.names=FALSE)
superfoods<-read.csv("superfoodsTidy.csv",stringsAsFactors=FALSE)
# Some data types still need to be changed
superfoods[,'POPULARITY']<-as.numeric(superfoods[,'POPULARITY'])
superfoods[,'EVIDENCE']<-as.numeric(superfoods[,'EVIDENCE'])
superfoods['EviJit']<-superfoods[,'EVIDENCE']+runif(nrow(superfoods),-0.4,0.4)
# Add a color-by-type field
superfoods["color"]<-match(superfoods[,'TYPE'],unique(superfoods[,'TYPE']))
color<-rep(NA,nrow(superfoods))
for(line in 1:nrow(superfoods)) color[line]<-switch(EXPR=superfoods[line,"color"],"red","green","yellow","orange","lightgray","purple","darkgray","beige","tan","cyan") 
superfoods["color"]<-color
## Mark the ones to watch blue
#superfoods[superfoods["One.to.watch"]=="OTW","color"]<-"blue"

# Store the alphabetical sorting.  Could also sort by interest or popularity...
superfoods<-superfoods[order(superfoods[,1]),]
superfoods['alphaX']<-1:nrow(superfoods)


##########################
# A function to interactively plot the data, crudely mimicking the online interactivity
# Requires no arguments, provided the above lines have been run.  Run function as:
# superSym()
# Instructions are provided in the console while the plot is active 
##########################
superSym<-function(){
    # Instructions
    cat('To identify a bubble, left-click twice: once\nat upper left corner of label and once at\nlower right corner.  Right-click anywhere to\nreset plot.  Left-click twice away from a\nbubble to exit.\n')
    # Create an infinite loop
    com<-"i"
    while(com=="i"){
        # Order data so big bubbles are plotted first and don't obscure little ones
        superfoods<-superfoods[order(superfoods[,8],decreasing=TRUE),]
        rownames(superfoods)<-1:nrow(superfoods)
        # Create an empty plot to hold the color legend
        layout(matrix(c(1,2),ncol=2,byrow=TRUE),widths=c(1,5))
        leg<-unique(superfoods[,c('color','TYPE')])
        par(mar=c(0,1,0,0))
        plot(0,pch=NA,axes=FALSE,ylab=NA,xlab=NA,main=NA)
        legend('left',legend=leg[,'TYPE'],fill=leg[,'color'],bty='n')
        # Plot the superfoods data
        par(mar=c(0,6.1,0,0))
        symbols(
            x=superfoods[,'alphaX'],
            y=superfoods[,26],
            circles=superfoods[,8],
            inches=0.5,
            bg=superfoods[,'color'],
            yaxt='n',
            ylab=NA)
        axis(2,at=0:6,labels=c('None','Slight','Some','Inconclusive','Promising','Good','Strong'),las=1)
        labels<-unlist(lapply(strsplit(superfoods[,1],split=" "),function(x) x[1]))
        text(x=superfoods[,'alphaX'],y=superfoods[,26],labels=labels,pos=3,offset=0)
        # Another loop to allow multiple bubbles to grow and be compared
        loc<-"0"
        while(length(loc)>0){
            loc<-locator(2,type="p",pch=3)
            if(length(loc)>0){
                # Specify growth size
                grow<-max(na.omit(superfoods[,'POPULARITY']))*3
                # Pull highlighted point from table
                rowdat<-superfoods[superfoods['alphaX']>=loc$x[1] & superfoods['alphaX']<=loc$x[2] & superfoods['EviJit']<=loc$y[1] & superfoods['EviJit']>=loc$y[2],]
                if(nrow(rowdat)>0){
                    # Grow the highlighted bubble
                    rowdat[,'POPULARITY']<-grow
                    symbols(
                        x=rowdat[,'alphaX'],
                        y=rowdat[,26],
                        circles=rowdat[,8],
                        inches=1.5,
                        bg=rowdat[,'color'],
                        add=TRUE)
                    text(x=rowdat[,'alphaX'],y=rowdat[,26],labels=rowdat[,1],pos=3,offset=3)
                    text(x=rowdat[,'alphaX'],y=rowdat[,26],labels=rowdat[,4],pos=3,offset=2)
                    text(x=rowdat[,'alphaX'],y=rowdat[,26],labels=rowdat[,18],pos=3,offset=1)
                } else return(cat('Exit.\n'))
            }
        }
    } 
}
