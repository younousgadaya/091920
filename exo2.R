library(dplyr)
library(sf)
library(ggplot2)
greendb = read.csv("greendb.csv")
spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]
greendb$Genus=spec

map = sf::read_sf("moscow.geojson")

#постройте картосхему средних диаметров стволов деревьев родов Клен и Ясень

data  = greendb %>% group_by(Genus,adm_region) %>%
  summarise(min_height= mean(height_m,na.rm =T)) %>%
  filter(Genus %in% c("Клен", "Ясень" ))


map = map %>% mutate (adm_region = NAME)
map = left_join(map, data, by="adm_region")


ggplot(map)+
  geom_sf(aes(fill=min_height))+
  theme()+
  facet_wrap(~Genus)





  
