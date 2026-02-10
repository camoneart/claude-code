# Thresholds and Triggers

## Coverage Thresholds

| Metric | Minimum |
|--------|---------|
| Line coverage | 80% |
| Branch coverage | 75% |
| Critical path coverage | 100% |

## Refactoring Triggers

以下の閾値を超えた場合、Phase 4 のリファクタリングで対処する。

| Metric | Trigger |
|--------|---------|
| Cyclomatic complexity | > 10 |
| Method length | > 20 lines |
| Class length | > 200 lines |
| Duplicate code blocks | > 3 lines |

## Coverage Reports

各フェーズ完了時に以下を計測:

- Line coverage
- Branch coverage
- Function coverage
- Statement coverage

## Metrics Tracking

サイクル全体で追跡する指標:

- 各フェーズの所要時間 (Red/Green/Refactor)
- テスト-実装サイクル数
- カバレッジ推移
- リファクタリング頻度
