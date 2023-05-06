library(tidyverse)
library(basedosdados)
library(tidyquant)

set_billing_id(Sys.getenv("GOOGLE_BILLING"))

#### Base de dados da Paraíba

# https://basedosdados.org/dataset/br-ana-atlas-esgotos?bdm_table=municipio
atlas_esgotos <- read_sql("SELECT * FROM `basedosdados.br_ana_atlas_esgotos.municipio` WHERE sigla_uf = 'PB'")
atlas_esgotos |> write_csv("atividades/exemplos_df/01_atlas_esgotos_pb.csv.gz")

# https://basedosdados.org/dataset/br-ibge-pam?bdm_table=municipio_lavouras_permanentes
lavouras_permanentes <- read_sql("SELECT * FROM `basedosdados.br_ibge_pam.municipio_lavouras_permanentes` WHERE sigla_uf = 'PB'")
lavouras_permanentes |> write_csv("atividades/exemplos_df/02_lavouras_permanentes_pb.csv.gz")

# https://basedosdados.org/dataset/br-ipea-avs?bdm_table=municipio
indice_vunerabilidade_social <- read_sql("SELECT * FROM `basedosdados.br_ipea_avs.municipio` WHERE sigla_uf = 'PB'")
indice_vunerabilidade_social |> write_csv("atividades/exemplos_df/03_indice_vunerabilidade_pb.csv.gz")

# https://basedosdados.org/dataset/br-anatel-telefonia-movel?bdm_table=municipio
telefonia_movel <- read_sql("SELECT * FROM `basedosdados.br_anatel_telefonia_movel.ddd`")
telefonia_movel |> 
  mutate(acessos = as.numeric(acessos)) |> 
  mutate(tipo = paste0(tecnologia, "-", sinal)) |> 
  mutate(data = as.Date(paste0(ano,"-",mes,"-01"))) |>
  write_csv("atividades/exemplos_df/04_telefonia_movel_br.csv.gz")


# https://basedosdados.org/dataset/br-mme-consumo-energia-eletrica?bdm_table=uf
consumo_energia <- read_sql("SELECT * FROM `basedosdados.br_mme_consumo_energia_eletrica.uf`")
consumo_energia |> write_csv("atividades/exemplos_df/05_consumo_energia.csv.gz")

# https://basedosdados.org/dataset/br-ibge-pib?bdm_table=municipio

pib_municipal <- read_sql("SELECT * FROM `basedosdados.br_ibge_pib.municipio`")
pib_municipal |> write_csv("atividades/exemplos_df/06_pib_municipal.csv.gz")

# 
frota_pb <- read_sql("SELECT * FROM `basedosdados.br_denatran_frota.municipio_tipo` WHERE sigla_uf = 'PB'")
frota_pb |> write_csv("atividades/exemplos_df/07_frota_automoveis_pb.csv.gz")


# https://basedosdados.org/dataset/br-inep-ana?bdm_table=escola
avaliacao_alfabetizacao <- read_sql("SELECT * FROM `basedosdados.br_inep_ana.escola` WHERE id_uf = '11'")
avaliacao_alfabetizacao |> write_csv("atividades/exemplos_df/08_avaliacao_alfabetizacao_pb.csv.gz")

# https://basedosdados.org/dataset/br-me-caged?bdm_table=microdados_movimentacao
caged_movimentacao <- read_sql("SELECT * FROM `basedosdados.br_me_caged.microdados_movimentacao` WHERE sigla_uf = 'PB' AND ano > 2021")
caged_movimentacao |> write_csv("atividades/exemplos_df/09_caged_movimentacao_pb.csv.gz")


# 
tq_index("IBV")
