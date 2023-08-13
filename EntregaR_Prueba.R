library(rvest)
library(dplyr)
library(quanteda) 
library(readtext) 
library(stringr)
library(ggplot2)
library(quanteda.textstats)
library(quanteda.textplots)

#Utilicé la técnica  de scraping de los diarios de sesiones del parlamento. Utilizando Speech y puy.

#Instalación de las librerías
remotes::install_github("Nicolas-Schmidt/speech")
remotes::install_github("Nicolas-Schmidt/puy")

#Creación de bases de datos de cada diario

url <- "https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion/6204/IMG"

sesion39_40 <- speech::speech_build(url)

sesion39_40 <- speech::speech_build(file = url, compiler = TRUE, quality = TRUE)

#*Con la siguiente función tuve un error = Error in `purrr::map()`:ℹ
#* In index: 1.Caused by error in `paste0()`: 
#* ! cannot coerce type 'builtin' to vector of type 'character' Run `rlang::last_trace()` to see where the error occurred. 

#* sesion6_4449 <- speech::speech_build(file = url, compiler = FALSE, quality = TRUE, add.error.sir = c, rm.error.leg = c("PRtSIDENTE", "SUB", "PRfSlENTE"))
#* 
#* 

#agregué partidos políticos como variable
sesion39_40 <- puy::add_party(sesion39_40)

#Combine todas las bases de datos en una sola

sesiones <- rbind(sesion1_4382, sesion11_4336, sesion13_4397, sesion15_15, sesion15_4274, sesion16_17, sesion18_18,
sesion19_19, sesion19_4344, sesion2_4261, sesion21_21, sesion22_4406, sesion24_4408, sesion25_4409, sesion27_4470, sesion28_4412,
sesion28_4471, sesion29_29, sesion29_30, sesion29_4288, sesion3_3, sesion3_4328, sesion3_4384, sesion31_31, sesion31_4415,
sesion36_37, sesion36_4295, sesion38_4442, sesion39_40, sesion4_4388, sesion44_4303, sesion48_4307, sesion49_4443,
sesion51_4376, sesion52_4377, sesion54_4379, sesion58_4317, sesion6_4449, sesion6_6, sesion7_4391, sesion7_4450, sesion7_7,
sesion8_4328, sesion8_4333, sesion8_8)

#para cargar las bases de datos se puede utilizar esta función
# library(tidyverse) # tidyverse
# load("Clase1/Material/world.Rdata") # cargo base de datos 


#función para crear el data frame a partir de la base de datos

dfm_sesiones <- quanteda::dfm(quanteda::tokens(sesiones$speech,
                                                     remove_punct = TRUE,
                                                     remove_numbers = TRUE),
                                    tolower=TRUE,
                                    verbose = FALSE)%>%
  quanteda::dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                                   tolower(sesiones$legislator),"presi*"),
                       min_nchar=3)%>%
  quanteda::dfm_trim(min_termfreq = 6)%>%
  dfm_tfidf()%>%
  quanteda::dfm_group(groups = sesiones$party)
  
##Con el dfm de sesiones, limpio palabras que no me aportan al trabajo se puede seguir trabajando en mejorar el filtrado
sacopalabras= c(quanteda::stopwords("spanish"),tolower(sesiones$legislator),"presidente", "señor", "vos", "al menos", "creo", 
"senadora", "senador", "ahora", "nº", "diputado")



##nube de palabras
dim(dfm_sesiones)


quanteda.textplots::textplot_wordcloud(dfm_sesiones, min.count = 7,max_words = 500,
      random.order = FALSE,colors = RColorBrewer::brewer.pal(8,"Dark2"),comparison = T)

quanteda::topfeatures(dfm_sesiones,50)




top = data.frame(topfeatures(dfm_tfidf(dfm_sesiones),20))
top$palabra = rownames(top)

#*A la hora de intetar crear un gráfico de barras con ggplot no pude hacerlo con el dfm_sesiones
#*Intenté con la función que nos explicaron en clase pero no tuve éxito

#*library(ggplot2)
#*topplot = top[1:20, ] %>%
#*  ggplot(aes(x = reorder(palabra, topfeatures.dfm_tfidf.dfm_sesiones...20.), 
#*             y = topfeatures.dfm_tfidf.dfm_sesiones...20., fill = palabra)) + 
#*  geom_col(show.legend = FALSE) +
#*  coord_flip() +
#*  geom_text(aes(hjust = -0.1, label = round(topfeatures.dfm_tfidf.dfm_sesiones...20.,1))) +
#*  theme_minimal() +
#*  theme(axis.title.y = element_blank(), axis.title.x = element_blank(), axis.text = element_text(size = 15)) +
#*  ggtitle("Palabras más frecuentes (n=20)") +
#*  scale_fill_manual(values = c(rep("#00A08A",20)))#*



#*Tuve que optar por utilizar el objeto sesiones sin depurar para construir el gráfico con una función que encontre en el perfil
#*github de Nicolás. Pero sólo funcionó con el objeto sesiones sin depurar, y no con su dfm.

library(magrittr)

minchar <- function(string, min = 3){
  string <- stringr::str_remove_all(string, "[[:punct:]]")
  string <- unlist(strsplit(string, " "))
  string[nchar(string) > min]
}


##GRAFICO CON PALABRAS BARRAS instalar package tidytext - install.packages("tidytext")
library(ggplot2)


sesiones$speech %>% 
  minchar(., min = 4) %>%  
  tibble::enframe() %>% 
  tidytext::unnest_tokens(word, value) %>%
  dplyr::count(word, sort = TRUE) %>%
  dplyr::mutate(word = stats::reorder(word, n)) %>%
  dplyr::filter(!stringr::str_detect(word, "presidente") ) %>% 
  .[1:40,] %>% 
  ggplot(aes(word, n)) +
  geom_col(col = "black", fill = "#00A08A", width = .7) +
  labs(x = "", y = "") +
  coord_flip() +
  theme_minimal()


#En esta función busco la correlación de diversas palabras teniendo como protagonista la palabra indígena
quanteda.textstats::textstat_simil(dfm_tfidf(dfm_sesiones),selection = "charrúa",
                                   method = "correlation",margin = "features")%>%
  as.data.frame()%>%
  dplyr::arrange(-correlation)%>%
  dplyr::top_n(20)

#Con kwic podemos visualizar el contexto en el que fue mencionada las palabras que son de interés (indígena y charrúa)
kwic = quanteda::kwic(quanteda::tokens(sesiones$speech,
                                       remove_punct = TRUE,
                                       remove_numbers = TRUE), 
                      pattern = quanteda::phrase(c("charrúa")),
                      window = 20)

DT::datatable(kwic)



#funcion para guardar cada base de datos como Rdata en la carpeta Rdata
#*Cada sesion esta guardada con el formato en el nombre ej: sesion(nºsesion_nºdiario)
#*la base de datos sesiones es una combinación de cada base de cada diario de sesion

save(sesion3_4384, file = "E:\\Mis Documentos\\GitHub\\EntregaR\\EntregaDB\\Rdata\\sesion3_4384.Rdata")



#*guardé también cada base de datos en la carpeta Excel carpeta en formato xlsx

install.packages("xlsx")
library(xlsx)

write.Rdata(sesion8_8,"E:\\Mis Documentos\\GitHub\\EntregaR\\EntregaDB\\Excel\\sesion8_8.Rdata")

library(readxl)
read_excel(ruta_archivo, sheet = "nombre_de_la_hoja")