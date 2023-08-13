Entrega
Recuperación y análisis de texto con R Educación Permanente FCS Consigna de Trabajo Final 2023

Introducción y fundamentación del trabajo

  Para realizar la entrega de la consigna final del curso de Recuperación y análisis de texto con R de Educación Permanente. Opte para trabajar como tema la cuestión Indígena en Uruguay desde los charrúas en el discurso del orden parlamentario. 
  Los motivos que me llevaron a optar por este tema en principio se conectan con estudios de compañeros cercanos de la Facultad de Humanidades que están trabajando el tema desde diversas aristas. Considero interesante también, el aporte sociológico para profundizar en una mirada sobre los discursos que ocupan la agenda estatal y ciudadana con respecto a este tema. 
  La cuestión indígena en Uruguay es un tema de relevancia histórica, cultural, sociológica y política. La situación de los charrúas, una de las poblaciones indígenas originarias de Uruguay,  ha generado debates y reflexiones sobre la identidad nacional y los derechos humanos. La consideración de un punto de vista sociológico y político sobre esta temática es esencial para comprender cómo las dinámicas sociales y políticas han influido en la percepción y el tratamiento de las identidades y derechos de los pueblos indígenas en el país.
  Parte de los nuevos discursos académicos que han circulado en la sociedad Uruguaya plantean la idea de la invisibilización de la presencia indígena en Uruguay. Siendo una cuestión históricamente marginada en la narrativa oficial. A pesar de las adversidades, las comunidades indígenas en Uruguay persisten en la resistencia conformando una conciencia colectiva y reivindicadora en cara a los derechos humanos. 
  En el caso de la sociología, podemos ver un potencial como herramienta que ayude a mostrar la profundidad de los relatos alternativos a los dominantes, sobre la historia y sobre la construcción de identidades en Uruguay. Dando lugar a posibles análisis que incluyan la perspectiva indígena histórica, pero también en el hoy y el presente en la resistencia de sus comunidades.
  
  A nivel de antecedentes solamente mencionare autores como Mónica Michelena, Gonzalo Figueredo y Mónica Sans, entre otros. Nos presentan distinto material que trabaja la cuestión indígena y las transformaciones en las formas de abordaje de esta cuestión desde la academia, pero también desde el ámbito político e histórico en sus relatos.

Selección de muestra y casos
Un primer acercamiento trae consigo desde este curso es la posibilidad de trabajar los discursos parlamentarios presentes en los diarios de sesión, siendo materia prima privilegiada para explorar cómo estas cuestiones han sido abordadas y debatidas en el ámbito político Uruguayo, reflejando las tensiones y transformaciones en la sociedad.
Como muestra se presenta una base de datos que conforma 44 sesiones parlamentarias en su formato de diario de sesión, de las mismas se extraen los discursos sistematizados de los parlamentarios declarantes a través de la técnica de scraping aplicada en la web del parlamento. Esta herramienta fue desarrollada por  Nicolás Schmidt, politólogo del departamento de ciencias políticas de UdelaR. Todas estas sesiones tienen como temporalidad desde la fecha actual hasta principios de marzo del año Dos mil veinte.
En cuanto a la selección de las sesiones, se realizó una búsqueda de los diarios de sesión donde se mencione la palabra indígena y charrúa. De la base de datos construida se tomó la variable speech, refiriendo a las intervenciones parlamentarias. Haciendo un conteo de palabras podemos encontrar que palabras y en qué contexto, se asocian con las palabras que elegimos para centralizar el trabajo.

Sobre el código
Se instalaron las siguientes librerías:
-	Rvest
-	Dplyr
-	Quanteda
-	Readtext
-	Stringr
-	ggplot2
-	quanteda.textstats
-	quanteda.textplots
-	
Dentro del código hay instrucciones y explicaciones de las librerías utilizadas y sobre la utilidad de las funciones aplicadas.  Se destaca la utilización de SPEECH y PUY para la construcción de las bases de datos.

