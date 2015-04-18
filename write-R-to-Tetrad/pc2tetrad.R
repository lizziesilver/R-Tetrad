
################################################################################
# Takes the output of PC (from the pcalg package), or a graphNEL graph,
# and writes the graph to file in the format supported by the Tetrad program.
# For more information about Tetrad, see:
# http://www.phil.cmu.edu/projects/tetrad/

write.pc2tetrad <- function(pcfit, filename){
	# Check that we're either getting the raw output of PC, or else
	# a graphNEL graph:
	stopifnot((class(pcfit)=="pcAlgo" | class(pcfit)=="graphNEL"))
	
	if (class(pcfit)=="pcAlgo") {
		pcgraph <- pcfit@graph
	} else {
		pcgraph <- pcfit
	}
	
	v <- nodes(pcgraph)
	e <- edges(pcgraph)
	
	# preallocating the edge matrix will help with memory usage.
	# However, this will be larger than we need, because the 
	# undirected edges are counted twice.
	ed <- matrix(nrow=numEdges(pcgraph), ncol=1)
	
	i = 0
	# vi is the "from" node
	for (vi in v){
		
		# ti is the "to" node
		for(ti in e[[vi]]){
			
			i = i+1
			
			# check if the edge is undirected - i.e. whether
			# there's an edge between these nodes in the 
			# other direction
			if (vi %in% e[[ti]]){
				
				# add the undirected edge
				ed[i,1] <- paste(vi, "---", ti, sep=" ")
				
				# remove the other direction from the edge list
				e[[ti]] <- e[[ti]][-which(e[[ti]]==vi)]
				
			} else {
				
				# otherwise, add the directed edge
				ed[i,1] <- paste(vi, "-->", ti, sep=" ")
			}
		}
	}
	
	# get rid of any remaining NA entries
	ed <- ed[is.character(ed[,1]),1]
	
	# numbers for the lines
	numed <- length(ed)
	
	# write to file
	write("Graph Nodes:", file = filename)
	write(paste(v, collapse=" "), file = filename, append=TRUE)
	write("\nGraph Edges:", file = filename, append=TRUE)
	write(paste(paste(1:numed, ".", sep=""), ed, sep=" "), 
		  file = filename, append=TRUE)
	
}
