# район Лефортово -докажите что диаметр стволов родов Клен и Ясень 
# значимо отличаются
greendb = read_csv("greendb.csv")

spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]

data  = greendb %>% mutate(Genus = genus) 
data = data %>% filter(Genus %in% c("Клен","Ясень")) %>%
  filter(adm_region=="район Лефортово")

data.aov <- aov(d_trunk_m ~ Genus, data = data)

summary(data.aov)
TukeyHSD(data.aov)


