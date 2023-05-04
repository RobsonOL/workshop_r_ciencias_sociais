library(basedosdados)
library(tidyverse)

# set_billing_id(Sys.getenv("GOOGLE_BILLING"))

query <- "
          SELECT *
          FROM `basedosdados.br_me_rais.microdados_vinculos`
          WHERE ano = 2020 AND sigla_uf = 'PB'
        "

df_pb2020 <- read_sql(query)
cbo_2002 <- read_sql("SELECT * FROM `basedosdados.br_bd_diretorios_brasil.cbo_2002`")
municipios <- read_sql("SELECT * FROM `basedosdados.br_bd_diretorios_brasil.municipio`")
sexo <- data.frame(
  sexo = c(1, 2),
  sexo_nome = c("Masculino", "Feminino")
)

raca_cor <- data.frame(
  raca_cor = c(1,2,4,6,8,9,-1),
  raca_cor_nome = c("Indígena", "Branca", "Preta", "Amarela", "Parda",
                    "Não identificada", "Ignorado")
)

grau_instrucao <- data.frame(
  grau_instrucao_apos_2005 = c(seq(1,11), -1),
  grau_instrucao_apos_2005_nome = c("ANALFABETO", "ATE 5.A INC",
                                    "5.A CO FUND",
                                    "5. A 9. FUND",
                                    "FUND COMPL",
                                    "MEDIO INCOMP",
                                    "MEDIO COMPL",
                                    "SUP. INCOMP",
                                    "SUP. COMP",
                                    "MESTRADO",
                                    "DOUTORADO",
                                    "IGNORADO")
  
)



# df_pb2020 |> 
#   write_csv("Exemplo/dados/rais_pb2020.csv.gz")

df_pb2020 <- read_csv("Exemplo/dados/rais_pb2020.csv.gz")


df <- df_pb2020 |> 
  left_join(cbo_2002 |> select(cbo_2002, descricao)) |> 
  rename(cbo_2002_descricao = descricao) |> 
  left_join(municipios |> select(id_municipio, nome) |> mutate(id_municipio = as.numeric(id_municipio))) |> 
  rename(municipio = nome) |> 
  left_join(sexo) |> 
  left_join(grau_instrucao) |> 
  left_join(raca_cor)

df |> 
  write_csv("Exemplo/dados/rais_pb2020_completo.csv.gz")
