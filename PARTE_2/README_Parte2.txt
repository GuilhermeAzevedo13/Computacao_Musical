======================================================================
PROJETO DE COMPUTAÇÃO MUSICAL - PARTE 2: PARSER DE STRING MUSICAL
======================================================================

Este diretório contém a solução para a Parte 2 da atividade. O objetivo desta parte é desenvolver um programa capaz de ler uma "partitura" em formato de texto (string) e sintetizar o áudio correspondente, utilizando os instrumentos criados na Parte 1.

----------------------------------------------------------------------
OBJETIVO
----------------------------------------------------------------------

O programa implementa um "maestro digital" que interpreta uma sequência de comandos e notas musicais. Ele é capaz de:
* Alterar o instrumento musical (corda, sopro ou percussão) no meio da execução.
* Ajustar a duração padrão das notas (o "tempo" da música).
* Converter a notação musical padrão (ex: 'Cn3' para Dó na 3ª oitava) para a frequência correta em Hertz.
* Gerar o som de cada nota com sua respectiva duração, intensidade e timbre.
* Concatenar todas as notas para formar a música completa.

----------------------------------------------------------------------
ESTRUTURA DOS ARQUIVOS
----------------------------------------------------------------------

Para executar esta parte, os seguintes arquivos são necessários nesta pasta:

1.  **SCRIPT PRINCIPAL:**
    * `script_parte2.m`: Script que contém as strings de exemplo da música "Asa Branca" e chama a função principal para gerar e tocar as diferentes versões (com corda, sopro e batida).

2.  **FUNÇÕES PRINCIPAIS (PARTE 2):**
    * `toca_string.m`: A função central do programa. Ela recebe a string musical, a processa bloco por bloco, e coordena a geração do áudio.
    * `nota_para_freq.m`: Uma função auxiliar essencial que traduz a notação de uma nota (ex: 'As4') para sua frequência exata em Hz, baseada na referência de A1 = 55 Hz.

3.  **FUNÇÕES DE SÍNTESE (DEPENDÊNCIAS DA PARTE 1):**
    * `fm_corda.m`, `fm_sopro.m`, `fm_bate.m`: Os "patches" de instrumento criados na Parte 1.
    * `fm_synth.m`, `envelope.m`, `resolve_env.m`: As funções de base para a síntese FM.

----------------------------------------------------------------------
COMO EXECUTAR
----------------------------------------------------------------------

1.  Abra o Octave.
2.  Navegue até a pasta que contém todos os arquivos listados acima.
3.  Na Janela de Comandos, digite `script_parte2` e pressione Enter.
4.  O script irá gerar, tocar e salvar três arquivos de áudio (.wav): a melodia de "Asa Branca" tocada com o instrumento de corda, de sopro e com a batida aguda.

----------------------------------------------------------------------
EXPLICAÇÃO PASSO A PASSO DO CÓDIGO (`toca_string.m`)
----------------------------------------------------------------------

O funcionamento do programa segue o roteiro sugerido no enunciado da atividade:

1.  **Processamento por Blocos:** A função `toca_string` inicia dividindo a string de entrada em blocos, usando a vírgula como separador.

2.  **Loop de Interpretação:** O código então passa por cada bloco para identificar seu tipo:
    * **Comando de Duração (Tx):** Se o bloco começa com 'T', o número que o segue é lido e armazenado como a nova `duracao_padrao` em segundos.
    * **Comando de Instrumento (Ix):** Se o bloco começa com 'I', o caractere seguinte ('c', 's' ou 'p') é usado para atualizar a variável `instrumento_atual`, que armazena qual função de síntese (`@fm_corda`, `@fm_sopro` ou `@fm_bate`) será usada para as próximas notas.

3.  **Processamento de Nota:** Se o bloco não é um comando, ele é tratado como uma nota de 5 caracteres.
    * **Cálculo da Frequência:** Os 3 primeiros caracteres (ex: 'Cn3') são enviados para a função `nota_para_freq.m`. Esta função calcula a distância exata em semitons da nota de referência (A1=55Hz) e aplica a fórmula `Freq = 55 * 2^(k/12)` para encontrar a frequência correta.
    * **Cálculo da Duração:** O 4º caractere é lido como o denominador `d`. A duração da nota é calculada como `duracao_padrao / d`. Conforme a regra, se o instrumento for de percussão (`fm_bate`), este valor é ignorado e a `duracao_padrao` é usada.
    * **Definição da Intensidade:** O 5º caractere ('F' ou 'f') determina a amplitude da nota (1.0 ou 0.5).

4.  **Geração e Concatenação:**
    * A função do `instrumento_atual` é chamada com a frequência e duração calculadas para gerar o áudio da nota.
    * O áudio resultante é multiplicado pela amplitude definida.
    * Finalmente, este novo trecho de áudio é concatenado ao final do vetor `som_final`.

5.  **Repetição:** O processo se repete para todos os blocos da string, construindo a música nota por nota até o final.