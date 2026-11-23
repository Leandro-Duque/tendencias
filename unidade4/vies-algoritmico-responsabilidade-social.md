# Viés algorítmico e responsabilidade social: impactos éticos da IA

## 1. Introdução

Sistemas de inteligência artificial podem apoiar decisões em áreas sensíveis, como emprego, crédito, saúde, educação, justiça e segurança pública. Entretanto, sua utilização nem sempre é neutra: dados históricos, objetivos mal definidos, critérios de avaliação inadequados e decisões humanas podem gerar **viés algorítmico** — isto é, diferenças sistemáticas que favorecem ou prejudicam pessoas ou grupos.

O problema não se resume à correção técnica de um modelo. O viés pode produzir exclusão, estigma e desigualdade social. Por isso, responsabilidade social em IA exige considerar impactos sobre direitos humanos, transparência, prestação de contas, participação das pessoas afetadas e possibilidade de contestação.

---

## 2. O que é viés algorítmico

Viés algorítmico é o tratamento sistematicamente desfavorável de determinadas categorias de pessoas causado por componentes de um sistema automatizado. Ele pode surgir em várias etapas:

- **Dados:** bases incompletas, desbalanceadas ou que reproduzem discriminações históricas;
- **Rotulagem:** classificações humanas preconceituosas ou inconsistentes;
- **Treinamento:** objetivos que privilegiam uma métrica sem considerar seus efeitos sociais;
- **Validação:** testes realizados apenas em populações majoritárias;
- **Implantação:** uso fora do contexto para o qual o sistema foi desenvolvido;
- **Feedback:** decisões do modelo que passam a influenciar novos dados, ampliando padrões existentes;
- **Interface:** termos confusos, falta de acessibilidade ou impossibilidade de contestar resultados.

Viés estatístico e discriminação social não são conceitos idênticos. Uma diferença entre grupos pode decorrer de uma desigualdade real do contexto; por outro lado, um modelo com alta precisão global pode distribuir erros de modo injusto. Portanto, a avaliação ética deve combinar métricas técnicas, contexto social e consequências práticas.

---

## 3. Principais tipos de viés

| Tipo | Exemplo | Risco |
|---|---|---|
| Viés histórico | Dados de contratação refletem exclusão passada de mulheres | O sistema aprende padrões discriminatórios como se fossem neutros |
| Viés de representação | Poucos registros de determinadas regiões ou etnias | Pior desempenho para grupos sub-representados |
| Viés de seleção | Dados coletados apenas de usuários de determinada plataforma | A amostra não representa a população afetada |
| Viés de medição | A variável usada como resultado não representa o fenômeno real | A métrica proxy gera decisões injustas |
| Viés de rotulagem | Avaliadores humanos reproduzem estereótipos | Os modelos consolidam classificações discriminatórias |
| Viés de implantação | Um sistema usado em contexto diferente do planejado | Resultados inadequados e danos inesperados |
| Viés de feedback | Decisões automatizadas modificam os dados futuros | O padrão inicial é reforçado |

## 4. Impactos éticos e sociais

### 4.1 Discriminação

O impacto mais evidente é a exclusão ou a classificação desfavorável de pessoas por características protegidas, como raça, gênero, deficiência, idade, origem ou condição socioeconômica.

### 4.2 Privacidade

Modelos podem inferir dados sensíveis a partir de informações aparentemente neutras. Isso pode ocorrer sem conhecimento ou consentimento efetivo da pessoa.

### 4.3 Opacidade

Quando o processo decisório não pode ser explicado, torna-se difícil identificar erros, exigir justificativas ou corrigir injustiças.

### 4.4 Responsabilização difusa

Empresas, desenvolvedores, fornecedores, gestores públicos e usuários podem atribuir responsabilidades uns aos outros. A organização que implanta o sistema precisa manter uma cadeia clara de prestação de contas.

### 4.5 Impactos econômicos e no trabalho

A automação pode aumentar produtividade, mas também pode gerar substituição de postos, vigilância intensa e desemprego desigual entre grupos profissionais. Ainda assim, os efeitos não são exclusivamente negativos: a tecnologia pode criar funções novas e ampliar o acesso a serviços. O ponto central é garantir avaliação, formação e políticas de transição.

### 4.6 Afetação de direitos fundamentais

Em decisões sobre saúde, crédito, moradia ou justiça, um erro automatizado pode afetar dignidade, liberdade, igualdade e acesso a direitos básicos.

---

## 5. Exemplos reais

### 5.1 COMPAS, Estados Unidos

O sistema COMPAS apoiava avaliações de risco de reincidência no sistema judicial norte-americano. Análises públicas apontaram que o modelo apresentava taxas diferentes de falsos positivos entre pessoas negras e brancas. O caso tornou-se emblemático porque um indicador técnico globalmente utilizado pode ocultar desigualdades relevantes entre grupos.

**Lições:**

- Precisão geral não garante justiça;
- A métrica de risco precisa corresponder a um objetivo legítimo;
- As pessoas afetadas devem ter acesso à revisão;
- Um sistema assistivo não deveria transferir integralmente a decisão para uma pontuação técnica.

Fonte: ProPublica, “Machine Bias”, 2016.

### 5.2 Recrutamento da Amazon

Em meados da década de 2010, a Amazon desenvolveu uma ferramenta experimental para classificar currículos. Como o treinamento refletia contratações históricas majoritariamente masculinas, o sistema passou a penalizar características associadas a candidatas mulheres. O projeto foi abandonado.

**Lições:**

- Dados históricos podem incorporar exclusões já existentes;
- Currículos não são neutros como representação de competência;
- É necessário auditar modelos por gênero e outras características protegidas;
- Impedir que o sistema faça uma decisão automática não elimina o risco de influenciar avaliadores humanos.

Fonte: Reuters, 2018.

### 5.3 Sistemas de saúde

Pesquisas identificaram modelos em que uma medida de custo ou gasto era usada como proxy de necessidade médica. Como pessoas de grupos historicamente desfavorecidos enfrentavam menos gastos no sistema, o modelo subestimava suas necessidades de cuidado.

**Lições:**

- A métrica utilizada deve representar diretamente o objetivo;
- Uma proxy aparente pode transmitir desigualdades estruturais;
- É necessário validar resultados em diferentes grupos e contextos;
- A governança deve envolver profissionais da área afetada.

Fonte: Obermeyer et al., “Dissecting racial bias in an algorithm used to manage the health of populations”, Science, 2019.

### 5.4 Educação

No contexto educacional, algoritmos podem influenciar seleção, monitoramento de estudantes, recomendação de conteúdos e detecção de fraude. Quando a aplicação considera dados históricos ou padrões culturais estreitos, pode reforçar estigmas ou atribuir maior probabilidade de risco a determinados grupos.

**Lições:**

- Sistemas educativos devem preservar autonomia e dignidade;
- Indicadores estatísticos não substituem avaliação pedagógica;
- A IA pode apoiar o ensino sem se tornar mecanismo de exclusão;
- É essencial garantir revisão humana e canais de contestação.

### 5.5 Contexto brasileiro

No Brasil, decisões automatizadas podem afetar diferentes grupos por desigualdades regionais, raciais, econômicas e digitais. Sistemas utilizados em órgãos públicos, bancos, seguros, educação ou saúde precisam considerar a LGPD, princípios constitucionais e vulnerabilidades locais.

Também é necessário observar a qualidade e representatividade dos dados. Uma população historicamente sub-representada em registros institucionais pode receber classificações menos precisas ou ser tratada com base em indicadores inadequados.

---

## 6. Responsabilidade social

Responsabilidade social em IA envolve a prevenção de danos ao longo de todo o ciclo de vida do sistema:

1. **Finalidade legítima:** definir para qual problema a IA será usada;
2. **Participação:** consultar usuários e comunidades potencialmente afetadas;
3. **Proporcionalidade:** avaliar se a tecnologia é adequada ao objetivo e aos riscos;
4. **Justiça:** verificar efeitos distributivos em diferentes grupos;
5. **Transparência:** informar quando uma IA participa de uma decisão;
6. **Explicabilidade:** fornecer justificativas proporcionais à criticidade da decisão;
7. **Prestação de contas:** identificar responsáveis por aprovação, operação e correção;
8. **Contestação:** permitir revisão humana rápida e acessível;
9. **Interrupção:** suspender sistemas que causem dano ou deixem de ser confiáveis;
10. **Monitoramento:** acompanhar métricas técnicas e impactos sociais após a implantação.

A responsabilidade não pode ser reduzida a um aviso ao usuário. O participante deve ter meios reais de compreender, questionar e modificar uma decisão prejudicial.

---

## 7. Marcos normativos e frameworks

### 7.1 Brasil

#### LGPD — Lei nº 13.709/2018

A Lei Geral de Proteção de Dados Pessoais estabelece princípios como finalidade, adequação, necessidade, transparência e segurança. Em decisões exclusivamente automatizadas que produzam efeitos sobre interesses dos titulares, o artigo 20 prevê direito à revisão. A LGPD também exige base adequada para tratamento de dados pessoais e, em alguns casos, tratamento especial de dados sensíveis.

#### Projeto de Lei nº 2.338/2023

O texto sobre inteligência artificial tramita no Congresso Nacional e adota uma abordagem baseada em risco. Ele busca estabelecer deveres de transparência, segurança e governança para sistemas de IA, com atenção especial a riscos e sistemas de alto impacto. Como o texto pode ser alterado durante o processo legislativo, organizações devem acompanhar sua versão vigente.

#### Direitos constitucionais

A Constituição Federal protege dignidade humana, igualdade, privacidade e defesa do consumidor. Casos públicos ou privados devem ser analisados também à luz de normas de discriminação e proteção de direitos humanos.

### 7.2 União Europeia

O **AI Act** adota uma classificação por níveis de risco. Sistemas considerados inaceitáveis podem ser proibidos; sistemas de alto risco precisam atender requisitos como gestão de risco, qualidade de dados, documentação, supervisão humana, robustez e monitoramento.

### 7.3 Estados Unidos

Nos Estados Unidos, não há um único marco federal equivalente ao AI Act europeu. Existem normas federais e estaduais, recomendações técnicas e exigências específicas para setores como crédito, emprego, saúde e habitação. O **AI Risk Management Framework**, publicado pelo NIST, fornece orientação técnica para identificar, medir, gerenciar e comunicar riscos.

### 7.4 UNESCO

A recomendação da UNESCO sobre a Ética da Inteligência Artificial, aprovada em 2021, apresenta princípios como dignidade humana, diversidade, inclusão, transparência, privacidade e responsabilidade.

### 7.5 OCDE

Os princípios da OCDE sobre IA ressaltam sistemas inclusivos, transparentes, seguros, robustos e responsabilizáveis.

---

## 8. Estratégias de mitigação

### 8.1 Antes do treinamento

- Documentar o propósito e os usuários afetados;
- Mapear direitos e interesses envolvidos;
- Avaliar a representatividade dos dados;
- Identificar dados sensíveis e possíveis proxies;
- Definir limites de uso;
- Consultar comunidades e especialistas;
- Definir critérios mínimos de justiça;
- Realizar avaliação de impacto algorítmico.

### 8.2 Durante o desenvolvimento

- Usar amostras representativas;
- Corrigir dados inconsistentes sem apagar contexto relevante;
- Validar rótulos humanos;
- Testar o modelo por grupos;
- Comparar diferentes métricas de justiça;
- Utilizar técnicas pré-processamento, em-processamento ou pós-processamento;
- Registrar versões, decisões e justificativas;
- Evitar treinamento em dados obtidos sem base adequada.

### 8.3 Após a implantação

- Monitorar erros por grupo;
- Investigar reclamações;
- Auditar o uso real;
- Implementar canais de contestação;
- Atualizar o sistema sem deixar vulnerabilidades;
- Registrar incidentes e aplicar planos de resposta;
- Suspender o sistema quando os danos superarem benefícios.

### 8.4 Métricas úteis

- **Demographic Parity:** distribuição semelhante de resultados entre grupos;
- **Equal Opportunity:** taxas semelhantes de acerto para aqueles que deveriam receber uma decisão positiva;
- **Equalized Odds:** taxas semelhantes de falsos positivos e falsos negativos;
- **Calibração:** a probabilidade prevista corresponde à frequência observada;
- **Erro por subgrupo:** compara precisão entre grupos;
- **Índices de representação:** verificam cobertura dos dados;
- **Taxas de escalonamento:** medem a transferência de casos para revisão humana.

Nenhuma métrica resolve sozinha o problema. Algumas definições de justiça são incompatíveis matematicamente em determinadas situações. A escolha deve considerar o contexto e seus riscos.

---

## 9. Auditoria e governança

Uma estrutura de governança recomendada pode incluir:

| Área | Responsabilidade |
|---|---|
| Diretoria/proprietário do sistema | Aprovar finalidade, riscos e limites |
| Engenharia | Construir e testar o sistema |
| Dados | Verificar qualidade, origem e retenção |
| Jurídico/compliance | Avaliar conformidade e direitos |
| Ética/social | Identificar impactos sobre grupos |
| Segurança | Proteger dados e impedir abusos |
| Operações | Monitorar falhas e incidentes |
| Auditoria | Testar controles e registrar evidências |
| Usuários afetados | Participar, reclamar e solicitar revisão |

O modelo organizacional deve definir:

- Quem pode aprovar ou alterar o sistema;
- Quem responde por erros;
- Como incidentes são classificados;
- Quando uma implantação deve ser interrompida;
- Como as pessoas podem solicitar explicações;
- Como a documentação será preservada;
- Como auditorias independentes serão realizadas.

A auditoria pode ser interna ou externa e deve cobrir dados, modelo, implementação, operação e impactos. Não é suficiente auditar o código: é preciso analisar o uso real e os danos potenciais.

---

## 10. Checklist para implementação responsável

Antes da implantação:

- [ ] A finalidade é legítima e necessária?
- [ ] Existem alternativas menos invasivas?
- [ ] Os dados são representativos e licenciados adequadamente?
- [ ] Os resultados foram testados por grupos relevantes?
- [ ] Pessoas afetadas podem compreender e contestar a decisão?
- [ ] Existe supervisão humana suficiente?
- [ ] Os usuários sabem que estão lidando com uma IA?
- [ ] Há registro de decisões, versões e incidentes?
- [ ] A LGPD e outras regras aplicáveis foram analisadas?
- [ ] Existe um plano de suspensão e resposta a incidentes?
- [ ] O desempenho continuará sendo monitorado?

---

## 11. Conclusão

A mitigação do viés algorítmico não é uma atividade isolada realizada apenas antes da publicação de um sistema. Ela exige governança contínua, participação social, auditoria técnica, proteção jurídica e supervisão humana.

A responsabilidade social não deve limitar-se à promessa de não discriminar. Organizações precisam demonstrar que identificaram riscos, testaram o sistema em contextos reais, consideraram pessoas afetadas e ofereceram mecanismos efetivos de revisão.

Uma IA responsável combina:

- precisão e robustez técnica;
- proteção de dados e privacidade;
- justiça entre grupos;
- transparência proporcional ao contexto;
- prestação de contas;
- supervisão humana;
- capacidade de correção e contestação.

Assim, o desenvolvimento ético de IA não impede a inovação. Ele estabelece condições para que os benefícios sejam distribuídos de modo mais seguro e para que os danos sejam prevenidos ou reduzidos.

---

## 12. Referências

### Normas e documentos oficiais

- BRASIL. **Lei nº 13.709, de 14 de agosto de 2018 — Lei Geral de Proteção de Dados Pessoais (LGPD)**. https://www.planalto.gov.br/ccivil_03/_ato2015-2018/lei/l13709.htm
- BRASIL. **Projeto de Lei nº 2.338, de 2023 — disposições sobre inteligência artificial**. Câmara dos Deputados. https://www.camara.leg.br/proposicoesWeb/fichadetramitacao?idProposicao=2361797
- NIST. **AI Risk Management Framework (AI RMF 1.0)**. 2023. https://www.nist.gov/itl/ai-risk-management-framework
- UNESCO. **Recommendation on the Ethics of Artificial Intelligence**. 2021. https://unesdoc.unesco.org/ark:/48223/pf0000380455
- OCDE. **OECD Principles on Artificial Intelligence**. https://oecd.ai/en/ai-principles
- EUROPEAN UNION. **Artificial Intelligence Act**. https://artificialintelligenceact.eu/
- ISO/IEC. **ISO/IEC 42001 — Artificial intelligence management system**. https://www.iso.org/standard/81230.html

### Pesquisa e casos

- ANGLER, Julia et al. **Dissecting racial bias in an algorithm used to manage the health of populations**. *Science*, v. 366, n. 6464, 2019. https://doi.org/10.1126/science.aax2342
- ANGWIN, Julia et al. **Machine Bias**. *ProPublica*, 2016. https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing
- DASTIN, Jeffrey. **Amazon scraps secret AI recruiting tool that showed bias against women**. *Reuters*, 2018. https://www.reuters.com/article/us-amazon-com-jobs-automation-insight-idUSKCN1MK08G
- BUVOLI, R. E.; REIS, J. C. **Vieses algorítmicos da inteligência artificial e seus impactos na educação**. *Humanas — SciELO Brasil*, 2025. https://humanas.blog.scielo.org/blog/2025/05/08/vieses-algoritmicos-da-inteligencia-artificial-e-seus-impactos-na-educacao/
- HOLDEREGGER, R.; DUARTE, L. F. de A. **Inteligência artificial e desigualdades socioeconômicas: viés algorítmico, impactos no trabalho e agendas de governança para países emergentes**. 2025. https://periodicos.newsciencepubl.com/arace/pt_BR/article/view/9346
- IBM. **O que é viés algorítmico?** 2024. https://www.ibm.com/br-pt/think/topics/algorithmic-bias

### Guias complementares

- Partnership on AI. **Responsible AI resources**. https://partnershiponai.org/
- OWASP Foundation. **OWASP Top 10 for Large Language Model Applications**. https://owasp.org/www-project-top-10-for-large-language-model-applications/
- FGV Direito SP. **Pesquisa sobre vieses e algoritmos para uso responsável de sistemas de IA**. https://direitosp.fgv.br/noticias/pesquisa-traca-guia-sobre-vieses-algoritmos-para-uso-sistemas-ia-forma-responsavel
