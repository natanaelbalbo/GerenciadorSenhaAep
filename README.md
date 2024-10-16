# **Gerenciador de Senhas Seguro com Aprendizado de Máquina**

Este projeto é um **Gerenciador de Senhas Seguro** desenvolvido utilizando **Flutter**. O principal objetivo deste aplicativo é fornecer um ambiente seguro para armazenar e gerenciar senhas, com o uso de **técnicas de aprendizado de máquina** para detectar e mitigar possíveis ameaças cibernéticas.

O aplicativo oferece suporte para múltiplas plataformas (Web e Mobile) e foi desenvolvido com foco na segurança e usabilidade. As senhas são criptografadas antes de serem armazenadas, e a geração de senhas fortes é automatizada para facilitar o uso de senhas seguras pelos usuários.

---

## **Funcionalidades**

1. **Criptografia de Senhas**:
   - As senhas inseridas pelo usuário são criptografadas usando a função `encryptPassword` antes de serem armazenadas, garantindo a proteção contra vazamentos.

2. **Geração de Senhas Fortes**:
   - O aplicativo oferece uma função chamada `generateStrongPassword`, que gera senhas automaticamente seguindo critérios de segurança elevados.

3. **Armazenamento Seguro**:
   - Utilizamos o `flutter_secure_storage` para armazenar as senhas de maneira segura e criptografada no dispositivo.

4. **Compatibilidade Multiplataforma**:
   - O aplicativo é adaptado para funcionar tanto em dispositivos móveis quanto na web, utilizando verificações como `kIsWeb` para garantir que funcione corretamente em ambas as plataformas.

5. **Remoção Segura de Senhas**:
   - As senhas podem ser removidas individualmente com a função `deletePassword`, que garante que apenas a senha selecionada seja excluída, evitando a remoção indevida de todas as entradas.

6. **Algoritmos de Aprendizado de Máquina**:
   - O aplicativo implementa algoritmos para monitorar e identificar atividades suspeitas no uso de senhas, ajudando a detectar possíveis ameaças cibernéticas.

7. **Feedback ao Usuário**:
   - A interface foi projetada para fornecer feedback instantâneo aos usuários com o uso de SnackBars, exibindo notificações sobre ações como adição, exclusão ou erros.

---

## **Manutenções Realizadas**

Um arquivo chamado **`manutenção.pdf`** foi incluído na raiz do projeto, contendo a documentação completa das manutenções realizadas. O documento abrange as manutenções **corretivas**, **adaptativas**, **perfectivas** e **preditivas**, com exemplos e detalhes das melhorias implementadas no código ao longo do desenvolvimento do aplicativo.

---

## **Instalação e Execução**

### Pré-requisitos:
- Flutter SDK instalado
- Dependências instaladas via `pub get`

### Como rodar o projeto:
1. Clone o repositório:
   ```bash
   git clone https://github.com/natanaelbalbo/GerenciadorSenhaAep.git
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

## **Testes**

Os testes unitários estão implementados no diretório `/test`, e cobrem as principais funcionalidades do aplicativo, como:
- Criptografia de senhas
- Geração de senhas seguras
- Armazenamento seguro
- Exclusão de senhas

Execute os testes com o seguinte comando:
```bash
flutter test
```

---

## **Paradigmas de Programação**

O Gerenciador de Senhas Seguro pode ser descrito como um exemplo de **programação imperativa**, com alguns toques de **programação funcional**. 

- **Imperativo**:
   - O código define explicitamente o que o programa deve fazer, passo a passo, por meio de funções como salvar, excluir e criptografar senhas.
   - O estado é mantido e atualizado conforme as ações dos usuários, com variáveis e estruturas de dados sendo modificadas diretamente.

- **Funcional**:
   - Alguns elementos de programação funcional estão presentes, como as funções `encryptPassword` e `generateStrongPassword`, que são puras (sem efeitos colaterais) e retornam o mesmo resultado para os mesmos parâmetros de entrada.

Essa combinação de paradigmas torna o código mais flexível e modular, ao mesmo tempo que facilita a manutenção e adição de novas funcionalidades.

---

## **Gerenciamento de Configuração**

O projeto utiliza o **Git** como ferramenta de versionamento, seguindo uma abordagem baseada em **Git Flow** com branches específicas para desenvolvimento e produção:

- **Main**: Código estável e pronto para produção.
- **Develop**: Branch para desenvolvimento ativo.
- **Feature branches**: Usadas para o desenvolvimento de novas funcionalidades.
- **Hotfix**: É utilizada para implementar rapidamente alterações necessárias na ramificação principal. 

As mudanças são monitoradas e discutidas por meio de **pull requests**, com revisões de código para garantir a qualidade.
