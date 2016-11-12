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
write.csv(sunburst, file = "ms.csv")


### create table as needed for Kerry Rodden's Sunburst

test_data = read.table("ms.csv",sep=",",header=TRUE,stringsAsFactors=FALSE)

head(test_data)

for (i in 1:nrow(test_data))
{
 string_length = length(strsplit(test_data[i,2],split="-")[[1]])
 string_ending = strsplit(test_data[i,2],split="-")[[1]][string_length]

 if (string_length==2 & string_ending=="") #for strings with -- at the end
 {
   test_data[i,2]=str_replace(test_data[i,2],pattern="--",replacement="-end")
 }
 else if (string_length==2) #for strings with - at the end
 {
   test_data[i,2]=paste0(test_data[i,2],"end")
 }
}

test_data = test_data[,-1]

write.table(test_data,"metadata-sequence.csv",sep=",",row.names=FALSE,col.names=FALSE)

