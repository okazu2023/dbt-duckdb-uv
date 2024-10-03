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

### 2.1. データの準備

[Python and Data Science Tutorial in Visual Studio Code](https://code.visualstudio.com/docs/datascience/data-science-tutorial#_prepare-the-data)に記載されている手順で Titanic データをダウンロードしています。

> This tutorial uses the Titanic dataset available on OpenML.org, which is obtained from Vanderbilt University's Department of Biostatistics at https://hbiostat.org/data. The Titanic data provides information about the survival of passengers on the Titanic and characteristics about the passengers such as age and ticket class. Using this data, the tutorial will establish a model for predicting whether a given passenger would have survived the sinking of the Titanic. This section shows how to load and manipulate data in your Jupyter notebook.

### 2.2. モデル定義

`models/`配下にYAMLやSQLファイルを作成する。

各レイヤーの意味については、下記を参照

|      Name      | Description                                                                                                                                            | Path                                                           | File Naming Pattern                                                   | test required(Y/N) | Recommended materialization | Reference                                                                                                  |
| :------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------- | :-------------------------------------------------------------------- | :----------------: | :-------------------------: | :--------------------------------------------------------------------------------------------------------- |
|     Source     | データベース内の raw データ(テーブル)。                                                                                                                | models/source/*                                                | src_[source].yml                                                      |         N          |              -              | -                                                                                                          |
|    Staging     | 唯一ソースデータを直接読み込む層。カラム名の変更、型キャスト、基本的な計算、分類などの軽微な変換はここで行う。ソースと1対1になる。                     | /models/staging/[source]/*                                     | stg_[source]__[entity].sql                                            |         N          |            view             | [Staging Layer Design](https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging)           |
| (Intermediate) | 特定のマートモデルをサポートするための層。モデルを適切な複合粒度に展開または縮小したいときに使用。特に複雑なロジック部分を独自の中間モデルに移動する。 | /models/[layer]/[data_project]/intermediate/[business_group]/* | int_[entity]_[verb].sql                                               |         N          |          ephemeral          | [Intermediate Layer Design](https://docs.getdbt.com/guides/best-practices/how-we-structure/3-intermediate) |
|   Data Mart    | ビジネスデータを保存する層。                                                                                                                           | /model/marts/[business_group]/*                                | dm_[entity]__[mini time grain]_[mini org grain]_[mini item_graim].sql |         Y          |         incremental         | [mart Layer Design](https://docs.getdbt.com/guides/best-practices/how-we-structure/4-marts)                |

## 3. 実行

以降の手順は、`main.ipynb`を確認してください。

## 4. 参考

- [uv](https://docs.astral.sh/uv/)
- [duckdb/dbt-duckdb | GitHub](https://github.com/duckdb/dbt-duckdb)
