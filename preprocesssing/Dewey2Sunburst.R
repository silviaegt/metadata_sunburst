#JE, thanks
#1. Ingest table with all three Dewey Metadata levels
Data = read.table("g1g2g3.csv",sep=",",header=TRUE)
#2. Download stringr library to replace numbers / spaces 
library("stringr", lib.loc="~/R/win-library/3.3")
#3. Save all three different columns and transform metadata phrases as lowercase words 
c1 <- tolower(str_replace_all(Data[,"Group1"],"[[:punct:]\\s]+",""))
c2 <- tolower(str_replace_all(Data[,"Group2"],"[[:punct:]\\s]+",""))
c3 <- tolower(str_replace_all(Data[,"Group3"],"[[:punct:]\\s]+",""))
#4. "Merge" each column into one and count each sequence occurrence with table()
sunburst = table(paste(c1,"-",c2,"-",c3, sep=""))
write.csv(sunburst, file = "metadata-sequence.csv")
