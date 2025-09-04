======================================================================
PROJETO DE COMPUTAÇÃO MUSICAL - PARTE 1: SÍNTESE DE INSTRUMENTOS FM
======================================================================

Este diretório contém a solução para a Parte 1 da atividade, que consiste na criação de três "patches" de instrumentos (sopro, corda e batida) utilizando a técnica de Síntese por Modulação de Frequência (FM).

----------------------------------------------------------------------
OBJETIVO
----------------------------------------------------------------------

O objetivo é criar funções que gerem sons com características tímbricas específicas, conforme descrito no enunciado, manipulando os parâmetros da síntese FM. Para cada tipo de som, foi criada uma função dedicada que encapsula os parâmetros ideais encontrados.

----------------------------------------------------------------------
ESTRUTURA DOS ARQUIVOS
----------------------------------------------------------------------

Para executar esta parte, os seguintes arquivos são necessários nesta pasta:

1.  **SCRIPT PRINCIPAL:**
    * `script_parte1.m`: O script que demonstra o funcionamento de cada instrumento. Ele gera e toca um som de exemplo para o sopro, a corda, e as batidas aguda e grave.

2.  **FUNÇÕES DE INSTRUMENTOS (PARTE 1):**
    * `fm_sopro.m`: Gera um som similar a um instrumento de sopro.
    * `fm_corda.m`: Gera um som similar a um instrumento de corda percutida.
    * `fm_bate.m`: Gera um som de percussão inarmônico.

3.  **FUNÇÕES DE BASE (DEPENDÊNCIAS):**
    * `fm_synth.m`: A função de síntese FM genérica que serve de base para todos os instrumentos.
    * `envelope.m`: Função auxiliar para criar os envelopes de ataque e decaimento.
    * `resolve_env.m`: Função auxiliar para processar e interpolar os envelopes.

----------------------------------------------------------------------
COMO EXECUTAR
----------------------------------------------------------------------

1.  Abra o Octave.
2.  Navegue até a pasta que contém todos os arquivos listados acima.
3.  Na Janela de Comandos, digite `script_parte1` e pressione Enter.
4.  O script executará e tocará quatro sons em sequência, com mensagens no console indicando qual instrumento está sendo testado.

----------------------------------------------------------------------
EXPLICAÇÃO PASSO A PASSO (LÓGICA DOS INSTRUMENTOS)
----------------------------------------------------------------------

Todos os instrumentos foram criados a partir da função `fm_synth.m`, que implementa a fórmula clássica de síntese FM. A diferenciação de cada timbre foi obtida através da cuidadosa manipulação dos seus parâmetros, especialmente os envelopes e a relação entre as frequências da portadora e da modulante.

**a) Instrumento de Sopro (`fm_sopro.m`)**

* **Objetivo:** Um som contínuo com dinâmica suave e timbre que acompanha a amplitude.
* **Implementação:**
    * **Timbre Harmônico:** A frequência da modulante é igual à da portadora (`f_mod = frequencia`) para criar um som rico e harmônico.
    * **Envelope de Amplitude:** Foi configurado um ataque e um decaimento longos (respectivamente 20% e 80% da duração total) para criar a subida e descida suaves.
    * **Timbre Dinâmico:** O envelope da modulante (que controla o "brilho"/quantidade de harmônicos) foi definido como o próprio envelope de amplitude multiplicado por um `índice_brilho`. Isso faz com que, quando o som está baixo (no início e no fim), haja poucos harmônicos, e quando está alto (no meio), o som se torne mais brilhante, cumprindo o requisito da questão.

**b) Instrumento de Corda (`fm_corda.m`)**

* **Objetivo:** Um som percussivo com decaimento exponencial e timbre que se torna mais suave com o tempo.
* **Implementação:**
    * **Timbre Harmônico:** A relação de frequências também é de 1:1 (`f_mod = frequencia`) para um som afinado.
    * **Envelope de Amplitude:** O ataque é quase instantâneo (`0.01s`) para simular a "palhetada" ou o "dedilhado" na corda. O decaimento é longo e com uma curvatura exponencial (`n2 = 3.0`) para simular a vibração da corda perdendo energia lentamente.
    * **Timbre Dinâmico:** O envelope da modulante foi configurado para ter um brilho inicial muito alto (`indice_brilho_inicial = 15`), mas com um decaimento bem mais rápido que o da amplitude (40% da duração total). Isso simula o comportamento real de uma corda, onde os harmônicos agudos (o brilho) se dissipam rapidamente, enquanto a nota fundamental continua soando.

**c) Instrumento de Batida (`fm_bate.m`)**

* **Objetivo:** Um som percussivo, inarmônico, com decaimento rápido e que possa gerar tons graves e agudos.
* **Implementação:**
    * **Timbre Inarmônico:** Esta é a característica principal. Foi obtida usando uma razão irracional entre as frequências: a frequência da modulante é a da portadora multiplicada pela raiz de 2 (`f_mod = frequencia * 1.4142`). Isso gera um espectro de frequências não harmônicas, típico de sons metálicos ou de tambores.
    * **Envelope de Amplitude:** O envelope possui um ataque instantâneo e um decaimento exponencial muito rápido, caracterizando um som de batida curta e percussiva.
    * **Variação de Tom:** A função recebe o parâmetro `frequencia`, que define diretamente a frequência da portadora. Ao passar um valor baixo (ex: 60 Hz), obtém-se uma batida "fechada" (grave). Ao passar um valor alto (ex: 440 Hz), obtém-se uma batida "aberta" (aguda), conforme demonstrado no script de teste.