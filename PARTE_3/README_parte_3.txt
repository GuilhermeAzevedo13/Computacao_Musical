======================================================================
PROJETO DE COMPUTAÇÃO MUSICAL - PARTE 3: EFEITOS SONOROS
======================================================================

Este diretório contém a solução para a Parte 3 da atividade, que consiste na criação de funções para efeitos sonoros e sua aplicação em sons gerados sinteticamente.

----------------------------------------------------------------------
OBJETIVO
----------------------------------------------------------------------

O objetivo desta parte é implementar três efeitos sonoros básicos (overdrive, distorção e tremolo) e demonstrar seu funcionamento aplicando-os em sons percussivos gerados na Parte 1.

----------------------------------------------------------------------
ESTRUTURA DOS ARQUIVOS
----------------------------------------------------------------------

Para executar esta parte, os seguintes arquivos são necessários nesta pasta:

1.  **SCRIPT PRINCIPAL:**
    * `script_parte3.m`: O script que orquestra toda a demonstração. Ele gera os sons originais, aplica os efeitos e toca os resultados em sequência.

2.  **FUNÇÕES DE EFEITOS (PARTE 3):**
    * `overdrive.m`: Aplica um efeito de saturação suave (soft clipping).
    * `distorcao.m`: Aplica um efeito de saturação pesada (hard clipping).
    * `tremolo.m`: Aplica uma modulação de amplitude (tremolo).

3.  **FUNÇÕES DE SÍNTESE (DEPENDÊNCIAS DA PARTE 1):**
    * `fm_bate.m`: Função que gera o som de percussão.
    * `fm_synth.m`: A função de síntese FM genérica.
    * `envelope.m`: Função auxiliar para criar envelopes de amplitude.
    * `resolve_env.m`: Função auxiliar para processar os envelopes.

----------------------------------------------------------------------
COMO EXECUTAR
----------------------------------------------------------------------

1.  Abra o Octave.
2.  Navegue até a pasta que contém todos os arquivos listados acima.
3.  Na Janela de Comandos, digite `script_parte3` e pressione Enter.
4.  O script executará e tocará 8 sons em sequência, exibindo mensagens no console para indicar qual som está sendo tocado.

----------------------------------------------------------------------
EXPLICAÇÃO PASSO A PASSO DO CÓDIGO (`script_parte3.m`)
----------------------------------------------------------------------

O script principal foi dividido em duas seções lógicas:

**PASSO 1: Geração dos Sons Originais**

Primeiro, o script prepara os sons que servirão de base para a aplicação dos efeitos.
* Dois sons percussivos são criados usando a função `fm_bate.m` da Parte 1.
* Um som "grave" é gerado com uma frequência baixa (60 Hz).
* Um som "agudo" é gerado com uma frequência mais alta (440 Hz).
* Ambos os sons são **normalizados** (divididos pelo seu valor máximo de amplitude) para garantir que o volume inicial seja 1. Isso é importante para que a aplicação dos efeitos de distorção seja consistente.

**PASSO 2: Aplicação e Reprodução dos Efeitos**

O script então passa por cada um dos três efeitos, aplicando-os tanto no som grave quanto no agudo.

* **Overdrive:**
    * A função `overdrive(s, ganho)` é chamada.
    * Ela multiplica o sinal por um fator de `ganho` (neste caso, 5) para aumentar a intensidade.
    * Em seguida, aplica a função matemática `tanh` (tangente hiperbólica), que "achata" suavemente os picos da onda, criando uma saturação "quente" e musical, similar a um amplificador valvulado.

* **Distorção:**
    * A função `distorcao(s, ganho)` é chamada.
    * Ela multiplica o sinal por um `ganho` bem mais alto (neste caso, 15) para levar o sinal muito além dos limites de amplitude.
    * Em seguida, ela "corta" de forma abrupta qualquer parte do sinal que passe de +1 ou -1 (hard clipping). O resultado é um som agressivo e rico em harmônicos estridentes.

* **Tremolo:**
    * A função `tremolo(s, fs)` é chamada.
    * Ela cria uma onda senoidal de baixa frequência (LFO) a 5 Hz.
    * Esta onda LFO é usada para modular (variar) a amplitude do som original, criando o efeito de pulsação de volume característico do tremolo. A `depth` de 0.5 faz com que o volume oscile entre 50% e 100% da sua intensidade original.

Após a aplicação de cada efeito em ambos os sons (grave e agudo), o script toca o resultado usando `soundsc` e uma pausa para que seja possível ouvir cada som claramente.