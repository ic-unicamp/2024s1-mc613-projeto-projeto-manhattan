# Projeto final de MC613 - 2024s1

Grupo:
- 260401 - Daniel Henriques Pamplona
- 260551 - José Eduardo Santos Rabelo
- 223641 - Raphael Salles Vitor de Souza

## Descrição

O projeto consiste no desenvolvimento de um tradutor de código Morse utilizando uma FPGA. O objetivo é receber inputs de pontos (.) e traços (-) a partir do botão key[0] da FPGA e exibir a letra correspondente no monitor, conectado via VGA. 

Para esse projeto, foram utilizados, além da própria placa FPGA, um cabo USB-B e um cabo VGA.

A temporização dos apertos do botão é gerenciada pelo módulo timing.v de forma a conseguirmos identificar o que é inputado. Para o aperto do botão e um tempo de até 1 segundo, o caracter lido é um ponto. Em um intervalo de tempo de (1,2] segurando o botão, o caracter é um traço. As variáveis interchar e interword servem para a distinção entre a continuação de uma palavra ou o início de uma nova palavra. Caso o novo input seja feito no intervalo de tempo (2,4], a próxima letra será printada do lado adjacente da anterior. Para o intervalo (4, 7], ou então não apertar o botão, significa que a próxima letra será printada do lado adjacente, mas um espaço será pulado para o início da nova palavra.

Para facilitar saber qual caractere está sendo visto naquele momento, utilizamos o módulo bin2display.v, sendo exibido no display (HEX4 e HEX5), bem como um timer no display (HEX0) implementado pelo timer.v.

A parte de exibição na tela é gerenciada pelos módulos vga.v, receiving.v, screen.v e image.v. O módulo vga é responsável pelo recurso de exibição, controlando o RGB em uma tela de 640x480 pixels. Já o módulo receiving é onde é implementado a árvore de máquina de estados para que seja encontrado qual caractere que está sendo inputado e passar essa informação adiante. Depois disso, o módulo screen recebe a codificação do módulo anterior e associa à um caractere alfanumérico e define a região a ser preenchida na tela através de um vetor dividido em 30 pedaços (um para cada caractere), controlando as regiões. Finalmente, o módulo image printa a letra no local passado pelo módulo screen, utilizando o módulo vga mencionado anteriormente.
 
Dessa maneira, ao instanciar todos os módulos no módulo principal morse.v, conseguimos fazer com que nosso projeto funcione como esperado.

Tabela de tradução Morse:

| Caractere | Código Morse | Caractere | Código Morse | Caractere | Código Morse |
|:---------:|:------------:|:---------:|:------------:|:---------:|:------------:|
|     A     |      .-      |     M     |      --      |     Y     |     -.--     |
|     B     |     -...     |     N     |      -.      |     Z     |     --..     |
|     C     |     -.-.     |     O     |      ---     |     0     |     -----    |
|     D     |     -..      |     P     |     .--.     |     1     |     .----    |
|     E     |      .       |     Q     |     --.-     |     2     |     ..---    |
|     F     |     ..-.     |     R     |      .-.     |     3     |     ...--    |
|     G     |     --.      |     S     |      ...     |     4     |     ....-    |
|     H     |     ....     |     T     |       -      |     5     |     .....    |
|     I     |      ..      |     U     |     ..-      |     6     |    -....     |
|     J     |     .---     |     V     |     ...-     |     7     |    --...     |
|     K     |      -.-     |     W     |     .--      |     8     |    ---..     |
|     L     |     .-..     |     X     |     -..-     |     9     |    ----.     |


