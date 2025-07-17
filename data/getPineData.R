#' getPineData
#' 
#' This grabs the raw mixed haplotypes/genotypes and merges it with the coordinates
#'  returning a data file ready for analysis.
#'  
getPineData <- function() { 
  library( tidyverse ) 
  library( gstudio )
  
  read_population( "data/PechinataPollenPools.csv", type = "zyme", locus.columns = 4:13) -> offspring 
  
  suppressMessages( 
    read_csv( "data/PechinataCoordinates.csv") -> coords
    )
  
  
  merge( offspring, coords ) |> 
    select( Treatment, Family, Offspring, X, Y, everything() ) |> 
    mutate( Treatment = factor( Treatment, 
                                ordered=TRUE,
                                levels = c( "Forest", 
                                            "Selective", 
                                            "Clearcut" ) ), 
            Family = factor( Family ), 
            Offspring = factor( Offspring, ordered=TRUE ) ) -> pines 
  
  return( pines )
}

