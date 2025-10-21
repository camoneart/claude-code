# Claude Code Skills

このディレクトリには、Claude Codeの動作を拡張するSkillsが含まれています。

## Skills一覧

### 開発ワークフロー

#### Managing Timecard
**ディレクトリ**: `managing-timecard/`

勤怠打刻機能（`/dakoku` コマンド）を管理するスキル。TIME MCP Serverを優先した日時取得、Markdown/JSON形式での保存、フォールバック処理の自動実行。

#### Logging Implementation
**ディレクトリ**: `logging-implementation/`

プロジェクト全体で一貫した実装ログ管理を行うスキル。`_docs/templates/`への自動保存、統一フォーマットでのログ作成、過去の実装履歴の参照。

#### Enforcing Git Commit Workflow
**ディレクトリ**: `enforcing-git-commit-workflow/`

意味のあるコミット履歴を保つための厳格なGitワークフロー管理スキル。Semantic Commit Prefixの強制、`git add -A`の禁止（例外あり）、個別ファイルステージングの徹底。

#### Enforcing pnpm
**ディレクトリ**: `enforcing-pnpm/`

プロジェクトでpnpmを統一的に使用するための強制スキル。npm/yarnコマンドの自動検知、pnpmへの自動置き換え、CI/CD設定の検証。

### テスト駆動開発（TDD）

#### Practicing TDD
**ディレクトリ**: `practicing-tdd/`

テスト駆動開発（TDD）のベストプラクティスに従った開発フローを管理するスキル。Red-Green-Refactorサイクルの徹底、80%以上のコードカバレッジ維持、品質ゲートの自動実行。

#### JavaScript Testing Patterns
**ディレクトリ**: `javascript-testing-patterns/`

Jest、Vitest、Testing Libraryを使用した包括的なテスト戦略の実装。ユニットテスト、統合テスト、E2Eテスト、モック、フィクスチャ、TDD/BDDワークフロー。

#### Web3 Testing
**ディレクトリ**: `web3-testing/`

スマートコントラクトとWeb3アプリケーションのテスト戦略。Hardhat、Foundry、Waffleを使用したコントラクトテスト、ガス最適化テスト。

### API・バックエンド開発

#### API Design Principles
**ディレクトリ**: `api-design-principles/`

RESTおよびGraphQL APIの設計原則をマスターし、直感的でスケーラブルなAPIを構築。新しいAPIの設計、API仕様のレビュー、API設計標準の確立時に使用。

#### FastAPI Templates
**ディレクトリ**: `fastapi-templates/`

非同期パターン、依存性注入、包括的なエラーハンドリングを備えた本番環境対応のFastAPIプロジェクトを作成。新しいFastAPIアプリケーションやバックエンドAPIプロジェクトのセットアップ時に使用。

#### Node.js Backend Patterns
**ディレクトリ**: `nodejs-backend-patterns/`

Express/Fastifyを使用した本番環境対応のNode.jsバックエンドサービスを構築。ミドルウェアパターン、エラーハンドリング、認証、データベース統合、API設計のベストプラクティス。

### アーキテクチャ・設計パターン

#### Architecture Patterns
**ディレクトリ**: `architecture-patterns/`

Clean Architecture、Hexagonal Architecture、Domain-Driven Designを含む実証済みのバックエンドアーキテクチャパターンを実装。複雑なバックエンドシステムの設計や既存アプリケーションのリファクタリング時に使用。

#### Microservices Patterns
**ディレクトリ**: `microservices-patterns/`

サービス境界、イベント駆動通信、レジリエンスパターンを持つマイクロサービスアーキテクチャを設計。分散システム、モノリス分解、マイクロサービス実装時に使用。

### インフラ・DevOps・Kubernetes

#### GitOps Workflow
**ディレクトリ**: `gitops-workflow/`

ArgoCDとFluxを使用したGitOpsワークフローを実装し、自動化された宣言的なKubernetesデプロイと継続的な調整を実現。GitOpsプラクティス、Kubernetesデプロイの自動化、宣言的インフラ管理のセットアップ時に使用。

#### K8s Manifest Generator
**ディレクトリ**: `k8s-manifest-generator/`

Deployment、Service、ConfigMap、Secretのための本番環境対応のKubernetesマニフェストを作成。ベストプラクティスとセキュリティ標準に従ってKubernetes YAMLマニフェスト、K8sリソースを生成、本番グレードのKubernetes設定を実装時に使用。

#### K8s Security Policies
**ディレクトリ**: `k8s-security-policies/`

NetworkPolicy、PodSecurityPolicy、RBACを含むKubernetesセキュリティポリシーを実装。本番グレードのセキュリティ向けにKubernetesクラスターの保護、ネットワーク分離の実装、Podセキュリティ標準の強制時に使用。

#### Helm Chart Scaffolding
**ディレクトリ**: `helm-chart-scaffolding/`

再利用可能な設定でKubernetesアプリケーションをテンプレート化およびパッケージ化するためのHelmチャートを設計、整理、管理。Helmチャートの作成、Kubernetesアプリケーションのパッケージング、テンプレート化されたデプロイの実装時に使用。

#### Terraform Module Library
**ディレクトリ**: `terraform-module-library/`

再利用可能なTerraform/OpenTofuモジュールのライブラリ。マルチクラウドインフラ、ネットワーク、セキュリティ、データベースモジュール。IaCのモジュール化、再利用可能なインフラコンポーネントの構築時に使用。

#### Distributed Tracing
**ディレクトリ**: `distributed-tracing/`

JaegerとTempoを使用した分散トレーシングを実装し、マイクロサービス全体でリクエストを追跡してパフォーマンスのボトルネックを特定。マイクロサービスのデバッグ、リクエストフローの分析、分散システムのオブザーバビリティ実装時に使用。

#### Prometheus Configuration
**ディレクトリ**: `prometheus-configuration/`

インフラとアプリケーションの包括的なメトリック収集、ストレージ、モニタリングのためのPrometheusをセットアップ。メトリック収集の実装、モニタリングインフラのセットアップ、アラートシステムの設定時に使用。

#### Grafana Dashboards
**ディレクトリ**: `grafana-dashboards/`

システムとアプリケーションメトリックのリアルタイム可視化のための本番環境Grafanaダッシュボードを作成・管理。モニタリングダッシュボードの構築、メトリックの可視化、運用オブザーバビリティインターフェースの作成時に使用。

#### SLO Implementation
**ディレクトリ**: `slo-implementation/`

Service Level Objectives（SLO）とエラーバジェットの実装。SLI定義、SLO追跡、アラート設定。サービス信頼性目標の設定、SRE プラクティスの実装時に使用。

#### Monitoring Setup
**ディレクトリ**: `monitor-setup/`（commands配下を参照）

本番環境対応のモニタリング、ロギング、トレーシングシステムのセットアップ。

### クラウド・マルチクラウド

#### Multi-Cloud Architecture
**ディレクトリ**: `multi-cloud-architecture/`

AWS、Azure、GCPからサービスを選択・統合するための意思決定フレームワークを使用したマルチクラウドアーキテクチャを設計。マルチクラウドシステムの構築、ベンダーロックインの回避、複数プロバイダーからのベストオブブリードサービスの活用時に使用。

#### Hybrid Cloud Networking
**ディレクトリ**: `hybrid-cloud-networking/`

VPNと専用接続を使用してオンプレミスインフラとクラウドプラットフォーム間の安全で高性能な接続を設定。ハイブリッドクラウドアーキテクチャの構築、データセンターとクラウドの接続、安全なクロスプレミスネットワーキングの実装時に使用。

#### Cost Optimization
**ディレクトリ**: `cost-optimization/`

リソースの適正化、タグ付け戦略、予約インスタンス、支出分析を通じてクラウドコストを最適化。クラウド費用の削減、インフラコストの分析、コストガバナンスポリシーの実装時に使用。

### AI・機械学習

#### LangChain Architecture
**ディレクトリ**: `langchain-architecture/`

エージェント、メモリ、ツール統合パターンを使用したLangChainフレームワークでLLMアプリケーションを設計。LangChainアプリケーションの構築、AIエージェントの実装、複雑なLLMワークフローの作成時に使用。

#### LLM Evaluation
**ディレクトリ**: `llm-evaluation/`

自動化されたメトリック、人間のフィードバック、ベンチマークを使用したLLMアプリケーションの包括的な評価戦略を実装。LLMパフォーマンスのテスト、AIアプリケーション品質の測定、評価フレームワークの確立時に使用。

#### RAG Implementation
**ディレクトリ**: `rag-implementation/`

ベクトルデータベースとセマンティック検索を使用したLLMアプリケーション用のRetrieval-Augmented Generation（RAG）システムを構築。知識基盤AI、ドキュメントQ&Aシステムの実装、外部知識ベースとのLLM統合時に使用。

#### ML Pipeline Workflow
**ディレクトリ**: `ml-pipeline-workflow/`

データ準備からモデルトレーニング、検証、本番デプロイまでのエンドツーエンドMLOpsパイプラインを構築。MLパイプラインの作成、MLOpsプラクティスの実装、モデルトレーニングとデプロイワークフローの自動化時に使用。

#### Prompt Engineering Patterns
**ディレクトリ**: `prompt-engineering-patterns/`

本番環境でのLLMパフォーマンス、信頼性、制御性を最大化するための高度なプロンプトエンジニアリング技術をマスター。プロンプトの最適化、LLM出力の改善、本番プロンプトテンプレートの設計時に使用。

### セキュリティ・コンプライアンス

#### SAST Configuration
**ディレクトリ**: `sast-configuration/`

アプリケーションコードの自動化された脆弱性検出のためのStatic Application Security Testing（SAST）ツールを設定。セキュリティスキャンのセットアップ、DevSecOpsプラクティスの実装、コード脆弱性検出の自動化時に使用。

#### PCI Compliance
**ディレクトリ**: `pci-compliance/`

決済カードデータと決済システムの安全な取り扱いのためのPCI DSS準拠要件を実装。決済処理の保護、PCIコンプライアンスの達成、決済カードセキュリティ対策の実装時に使用。

#### Solidity Security
**ディレクトリ**: `solidity-security/`

Solidityスマートコントラクトのセキュリティベストプラクティス。再入攻撃、整数オーバーフロー、アクセス制御の脆弱性対策。安全なスマートコントラクト開発、セキュリティ監査時に使用。

### 決済・課金

#### Billing Automation
**ディレクトリ**: `billing-automation/`

定期支払い、請求書発行、サブスクリプションライフサイクル、滞納管理のための自動化された課金システムを構築。サブスクリプション課金の実装、請求書発行の自動化、定期支払いシステムの管理時に使用。

#### Stripe Integration
**ディレクトリ**: `stripe-integration/`

Stripe決済処理の統合。チェックアウトフロー、サブスクリプション、Webhook、SCA対応。決済実装、サブスクリプション課金、オンライン取引処理時に使用。

#### PayPal Integration
**ディレクトリ**: `paypal-integration/`

エクスプレスチェックアウト、サブスクリプション、返金管理をサポートするPayPal決済処理を統合。PayPal決済の実装、オンライン取引の処理、eコマースチェックアウトフローの構築時に使用。

### Web3・ブロックチェーン

#### DeFi Protocol Templates
**ディレクトリ**: `defi-protocol-templates/`

ステーキング、AMM、ガバナンス、レンディングシステムのための本番環境対応テンプレートでDeFiプロトコルを実装。分散型金融アプリケーションやスマートコントラクトプロトコルの構築時に使用。

#### NFT Standards
**ディレクトリ**: `nft-standards/`

適切なメタデータ処理、ミント戦略、マーケットプレイス統合でNFT標準（ERC-721、ERC-1155）を実装。NFTコントラクトの作成、NFTマーケットプレイスの構築、デジタルアセットシステムの実装時に使用。

### フロントエンド・モダナイゼーション

#### React Modernization
**ディレクトリ**: `react-modernization/`

Reactアプリケーションを最新バージョンにアップグレードし、クラスコンポーネントからフックへの移行、並行機能の採用。Reactコードベースのモダナイゼーション、React Hooksへの移行、最新Reactバージョンへのアップグレード時に使用。

#### Angular Migration
**ディレクトリ**: `angular-migration/`

ハイブリッドモード、インクリメンタルコンポーネント書き換え、依存性注入更新を使用してAngularJSからAngularへ移行。AngularJSアプリケーションのアップグレード、フレームワーク移行の計画、レガシーAngularコードのモダナイゼーション時に使用。

#### TypeScript Advanced Types
**ディレクトリ**: `typescript-advanced-types/`

TypeScriptの高度な型システム機能。ジェネリクス、条件型、Mapped Types、Template Literal Typesなどの高度なパターン。

#### Modern JavaScript Patterns
**ディレクトリ**: `modern-javascript-patterns/`

クリーンで効率的なJavaScriptコードを書くためのES6+機能（async/await、分割代入、スプレッド演算子、アロー関数、Promise、モジュール、イテレータ、ジェネレータ、関数型プログラミングパターン）をマスター。レガシーコードのリファクタリング、モダンパターンの実装、JavaScriptアプリケーションの最適化時に使用。

### データベース・移行

#### Database Migration
**ディレクトリ**: `database-migration/`

ゼロダウンタイム戦略、データ変換、ロールバック手順でORM全体およびプラットフォーム全体でデータベース移行を実行。データベースの移行、スキーマの変更、データ変換の実行、ゼロダウンタイムデプロイ戦略の実装時に使用。

### 依存関係管理

#### Dependency Upgrade
**ディレクトリ**: `dependency-upgrade/`

互換性分析、段階的ロールアウト、包括的なテストで主要な依存関係バージョンのアップグレードを管理。フレームワークバージョンのアップグレード、主要な依存関係の更新、ライブラリの破壊的変更の管理時に使用。

### 検索・情報収集

#### Searcher
**ディレクトリ**: `searcher/`

検索意図に基づいて最適な検索ツールをインテリジェントに選択・使用。情報検索時に、Webコンテンツ、ローカルファイル、場所、特定のデータなど、検索対象に応じて自動的にWebSearch、Brave Search、Firecrawl、Desktop Commander、その他の検索MCPから選択。

#### Searching Web
**ディレクトリ**: `searching-web/`

優先順位付きMCPサーバー戦略（Brave-Search → WebFetch）でWeb検索を実行。Web検索、ドキュメントの調査時に使用。

### プロジェクトセットアップ

#### Setting up Next.js Project
**ディレクトリ**: `setting-up-nextjs-project/`

Next.jsプロジェクトのセットアップ時に必要な設定を自動化するスキル。ESLint + Prettierの自動インストール、設定ファイルの自動作成、VS Code設定の推奨。

### 翻訳・記事

#### Translate Article
**ディレクトリ**: `translate-article/`

英語技術記事を日本語Markdownに翻訳。技術用語の適切な処理、コードブロックの保持、リンクとフォーマットの維持。

### メタスキル

#### Creating Skills
**ディレクトリ**: `creating-skills/`

ベストプラクティスに従って新しいAgent Skillsを作成するためのガイドとワークフロー。新しいSkillsの作成、SKILL.mdファイルの作成、Claude Code用のSkillの構築時に使用。

#### Plugin Fallback Installer
**ディレクトリ**: `plugin-fallback-installer/`

公式プラグインのインストールが失敗した場合にClaude Codeプラグインコンポーネントを手動でインストール。`/plugin install`が成功してもプラグインが読み込まれない場合、プラグインのインストール確認時、プラグインのインストール問題時に使用。

## Skillsの仕組み

### 自動発動
各Skillは、ユーザーのリクエストやコンテキストに基づいて**自動的に発動**します。

例：
- ユーザーが「Next.jsプロジェクトをセットアップして」と言う → `Setting up Next.js Project` が発動
- `/dakoku in` を実行 → `Managing Timecard` が発動
- コミット操作を行う → `Enforcing Git Commit Workflow` が発動

### Progressive Disclosure
詳細な情報は別ファイルに分離されており、必要に応じて参照されます。

例：
- `enforcing-git-commit-workflow/SKILL.md` - 基本ルール
- `enforcing-git-commit-workflow/prefix-reference.md` - Prefix一覧の詳細

## Skillsの作成

新しいSkillを作成する場合は、`creating-skills/` Skillを参照してください。

### 基本構造
```
skill-name/
├── SKILL.md              # メインファイル（YAMLフロントマター必須）
├── reference.md          # 詳細リファレンス（オプション）
├── examples.md           # 使用例（オプション）
└── templates/            # テンプレートファイル（オプション）
```

### YAMLフロントマター
```yaml
---
name: Skill Name (動名詞形)
description: 具体的な説明。何をするか + いつ使うか。
allowed-tools: Read, Write, Edit  # オプション
---
```

## ベストプラクティス

1. **SKILL.mdは500行以下に保つ**
2. **descriptionに発動トリガーを明記**
3. **Progressive Disclosureパターンを使用**
4. **動名詞形（verb + -ing）で命名**
5. **具体的な例を含める**

## 参考リンク

- [Claude Code Skills公式ドキュメント](https://docs.claude.com/en/docs/agents-and-tools/agent-skills)
- [Skills Best Practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
