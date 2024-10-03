# dbt-duckdb

ローカルで完結する dbt のチュートリアル。

データベースには、 DuckDB を使用する。

環境構築およびパッケージ管理は uv で行う。

## 1. セットアップ

### 1.1. uv のインストール

[Getting started | uv](https://docs.astral.sh/uv/#getting-started) を参考に、uv をローカル環境にインストールする。

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### 1.2. Python と依存関係のインストール

`pyproject.toml`に記載しているように、このチュートリアルでは、uv が管理している Python ランタイムを使用する。

ランライムバージョンは、`3.12`としている。

この辺りは適宜変更してください。

Python と依存関係のインストールを行うには下記コマンドを実行してください。

```bash
uv venv
source .venv/bin/activate
uv sync
```

### 1.3. dbt プロファイルの作成

`$HOME/.dbt/profiles.yml`などに下記プロファイルを追加してください。

プロファイル名を変える場合は、`dbt_project.yml`内の値も合わせて変更してください。

```$HOME/.dbt/profiles.yml
dbt_duckdb_uv:
  target: local
  outputs:
    local:
      type: duckdb
      path: local.duckdb
      threads: 1
      extensions:
        - parquet
```

## 2. 開発

TBD

## 3. 実行

以降の手順は、`main.ipynb`を確認してください。

## 4. 参考

- [uv](https://docs.astral.sh/uv/)
- [duckdb/dbt-duckdb | GitHub](https://github.com/duckdb/dbt-duckdb)
