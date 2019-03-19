library(dplyr)
nla_wq_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv"
download.file(nla_wq_url,"nla_wq.csv",method="curl")
nla_secchi_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_secchi_20091008.csv"
download.file(nla_secchi_url,"nla_secchi.csv" , method="curl")
nla_wq <- read.csv("nla_wq.csv", stringsAsFactors = FALSE)
nla_secchi <- read.csv("nla_secchi.csv", stringsAsFactors = FALSE)
file.remove("nla_wq.csv","nla_secchi.csv")
nla_wq <- nla_wq %>% 
  select(SITE_ID,VISIT_NO,RT_NLA,EPA_REG,WSA_ECO9,LAKE_ORIGIN,PTL,
                  NTL,CHLA) %>%
  filter(VISIT_NO == 1)
nla_secchi <- nla_secchi %>%
  select(SITE_ID,VISIT_NO,SECMEAN) %>%
  filter(VISIT_NO == 1)
nla_dat <- full_join(nla_wq,nla_secchi) %>%
  select(SITE_ID,RT_NLA,EPA_REG,WSA_ECO9,LAKE_ORIGIN,PTL,NTL,CHLA,SECMEAN) %>%
  na.omit(nla_dat) 
write.csv(nla_dat,"../data/nla_dat.csv",row.names = FALSE)
