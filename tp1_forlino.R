# TRABAJO PRÁCTICO 1
# Alumna: Lara Forlino

#Librerias 
library(tidyverse)
library(janitor)

#Descargo base de datos llamados al 107 COVID
llamados_107 <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/llamados-107-covid/llamados_107_covid.csv")

#observo los nombres de las columnas de la base
colnames(llamados_107)

#limpio nombres de las columnas
llamados_107 <- llamados_107 %>% clean_names()

#aplico pivot_longer y pongo en una misma columna las variables 
# "casos sospechosos" y "casos descartados"

llamados_107_largo <- llamados_107 %>% 
  pivot_longer(cols=c(casos_sospechosos,casos_descartados_covid),
               names_to = "tipo_de_caso",
               values_to = "numero")

#aplico filter en la base original para conservar las fechas en que se 
#recibieron más de 500 llamados
llamados_107_ok <- llamados_107 %>% 
  filter(covid_llamados>500)

#conservo solamente las variables de casos sospechosos y casos descartados
llamados_107_ok <- llamados_107_ok %>% 
  select(fecha,casos_sospechosos,casos_descartados_covid)

#creo una nueva variable dicotómica indicando si en la fecha
#hubo más que 100 casos sospechosos
llamados_107_ok <- llamados_107_ok %>% 
  mutate(mas_10=case_when(casos_sospechosos>100 ~ "si",
                          casos_sospechosos<=100 ~ "no"))
