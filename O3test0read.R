setwd("D:/FACSIMILE/ANsCBmodel")
file1 <- "O3test0.dat"
df <- read.table(file1,1,skip=1)

par(mfrow=c(3,4))

plot(df$O3[1:10],type="o")
plot(df$O1D[1:10],type="o")
plot(df$O3P[1:10],type="o")
plot(df$OH[1:10],type="o")
plot(df$NO[1:10],type="o")
plot(df$NO2[1:10],type="o")
plot(df$HO2[1:10],type="o")
plot(df$H2O2[1:10],type="o")
plot(df$CH3O[1:10],type="o")
plot(df$CH3O2[1:10],type="o")
plot(df$CH3OOH[1:10],type="o")
plot(df$O3F[1:10],type="o")
