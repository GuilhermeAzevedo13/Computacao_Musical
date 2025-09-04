# Projeto Final de Computação Musical - Sintetizador em Octave

## Visão Geral do Projeto

[cite_start]Este repositório contém a implementação de um sintetizador simples em GNU Octave, desenvolvido como atividade avaliativa para a disciplina de Computação Musical[cite: 3587]. [cite_start]O projeto é dividido em três partes principais, que abordam desde a criação de timbres de instrumentos com síntese FM até a implementação de um interpretador de partituras e a aplicação de efeitos sonoros[cite: 3590].

## Estrutura do Repositório

O projeto está organizado em múltiplos arquivos `.m` para garantir modularidade e clareza. Todos os arquivos devem estar na mesma pasta para que os scripts principais funcionem corretamente.

#### 1. Scripts Principais (Para Executar)
Estes são os arquivos que devem ser executados para demonstrar cada parte da atividade.
* **`script_parte1.m`**: Demonstra os instrumentos sintetizados na Parte 1.
* **`script_parte2.m`**: Demonstra o interpretador de partitura da Parte 2 com a melodia "Asa Branca".
* **`script_parte3.m`**: Demonstra os efeitos sonoros da Parte 3 aplicados em sons de batida.

#### 2. Funções da Parte 1 (Instrumentos)
* [cite_start]**`fm_sopro.m`**: Patch de síntese para um som similar a um instrumento de sopro[cite: 3593].
* [cite_start]**`fm_corda.m`**: Patch de síntese para um som similar a um instrumento de corda[cite: 3595].
* [cite_start]**`fm_bate.m`**: Patch de síntese para um som de percussão (batida)[cite: 3596].

#### 3. Funções da Parte 2 (Interpretador de Partitura)
* [cite_start]**`toca_string.m`**: A função principal que lê e interpreta a string musical[cite: 3615, 3637].
* [cite_start]**`nota_para_freq.m`**: Função auxiliar que converte a notação de uma nota (ex: 'An4') para sua frequência correspondente em Hz[cite: 3612, 3635].

#### 4. Funções da Parte 3 (Efeitos Sonoros)
* [cite_start]**`overdrive.m`**: Aplica um efeito de saturação suave (*soft clipping*)[cite: 3661].
* [cite_start]**`distorcao.m`**: Aplica um efeito de saturação pesada (*hard clipping*)[cite: 3661].
* [cite_start]**`tremolo.m`**: Aplica um efeito de modulação de amplitude[cite: 3661].

#### 5. Funções de Base (Dependências)
* [cite_start]**`fm_synth.m`**: Função de síntese FM genérica, utilizada por todos os instrumentos[cite: 3600, 3601].
* **`envelope.m`**: Função auxiliar que cria envelopes de ataque e decaimento para controlar a amplitude e o timbre.
* **`resolve_env.m`**: Função auxiliar que processa os envelopes (sejam eles vetores, escalares ou funções).

## Como Executar

Para avaliar cada parte do trabalho, execute o script correspondente na Janela de Comandos do Octave. Certifique-se de que o Octave esteja com o "Diretório Atual" apontando para a pasta onde todos os arquivos `.m` estão salvos.

* **Para testar a Parte 1:**
    ```octave
    >> script_parte1
    ```

* **Para testar a Parte 2:**
    ```octave
    >> script_parte2
    ```

* **Para testar a Parte 3 (Extra):**
    ```octave
    >> script_parte3
    ```

## Descrição Detalhada das Partes

### Parte 1: Síntese de Instrumentos

[cite_start]Nesta parte, foram criados três "patches" de instrumentos usando síntese FM[cite: 3592]. Cada um foi modelado para atender a características sonoras específicas:

* [cite_start]**`fm_sopro`**: Simula um instrumento de sopro com um envelope de amplitude de subida e descida suaves[cite: 3593]. [cite_start]O timbre (quantidade de harmônicos) acompanha a amplitude: o som é mais puro quando está baixo e mais brilhante quando está alto[cite: 3594].
* [cite_start]**`fm_corda`**: Simula uma corda percutida com um ataque rápido e um decaimento de amplitude exponencial[cite: 3595]. [cite_start]O timbre também é dinâmico: começa com muitos harmônicos (brilhante) e estes decaem mais rápido que a amplitude, tornando o som mais suave ao longo do tempo[cite: 3595].
* **`fm_bate`**: Simula uma batida de percussão. [cite_start]Para isso, utiliza um espectro **inarmônico**, criado por uma razão de frequências irracional (√2) entre a portadora e a modulante[cite: 3596]. [cite_start]O envelope tem um ataque e decaimento muito rápidos[cite: 3596]. [cite_start]A função aceita uma frequência como parâmetro, permitindo a criação de tons graves ("fechados") e agudos ("abertos")[cite: 3598].

### Parte 2: Interpretador de Partitura em String

[cite_start]O objetivo desta parte foi criar um programa que traduz uma string formatada em uma peça musical[cite: 3615].

* A função **`toca_string.m`** é o coração desta parte. [cite_start]Ela processa a string, que é separada por vírgulas, e interpreta três tipos de comandos[cite: 3616]:
    * [cite_start]**`Tx`**: Altera a duração padrão das notas para `x` segundos[cite: 3617].
    * [cite_start]**`Ix`**: Altera o instrumento a ser usado para 'c' (corda), 's' (sopro) ou 'p' (percussão)[cite: 3618, 3619, 3620, 3621].
    * **Nota (5 caracteres)**: Um bloco de 5 caracteres como `Cn34f` é interpretado como uma nota musical.
        * [cite_start]**`Cn3`**: Os três primeiros caracteres (Nome, Acidente, Oitava) são enviados para a função `nota_para_freq.m`[cite: 3623, 3626, 3629].
        * **`4`**: O quarto caractere é o denominador da duração. [cite_start]A nota durará 1/4 da duração padrão[cite: 3630, 3631]. [cite_start](Esta regra é ignorada para a percussão [cite: 3630]).
        * [cite_start]**`f`**: O quinto caractere define a intensidade: 'F' para amplitude 1.0 e 'f' para 0.5[cite: 3632, 3633, 3634].

* A função **`nota_para_freq.m`** usa a teoria musical descrita no enunciado. [cite_start]Com a referência **A1 = 55 Hz** [cite: 3635][cite_start], ela calcula a distância em semitons de qualquer nota até essa referência, considerando a oitava, o nome da nota (e as distâncias de 1 ou 2 semitons entre elas [cite: 3636][cite_start]) e os acidentes (sustenido/bemol [cite: 3627, 3628]). [cite_start]Ao final, aplica a fórmula `Frequência = Referência * 2^(k/12)` para obter o pitch exato[cite: 3613].

### Parte 3: Efeitos Sonoros (Extra)

[cite_start]Esta parte implementa três funções de efeito de áudio[cite: 3660], conforme sugerido no enunciado. O script `script_parte3.m` demonstra esses efeitos aplicando-os aos sons de batida.

* **`overdrive.m`**: Simula uma saturação suave aplicando a função `tanh` a um sinal previamente amplificado. Isso "achata" os picos da onda de forma suave, adicionando calor e harmônicos.
* **`distorcao.m`**: Simula uma distorção pesada, cortando abruptamente (`clipping`) qualquer parte do sinal que ultrapasse os limites de +1.0 e -1.0. O resultado é um som muito mais agressivo.
* **`tremolo.m`**: Cria uma variação periódica no volume do som. Isso é feito multiplicando o sinal de áudio por uma onda senoidal de baixa frequência (LFO), criando uma pulsação.
