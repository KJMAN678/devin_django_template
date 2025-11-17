### Command

```sh
# app 追加
$ mkdir web
$ docker compose run --rm backend uv run django-admin startapp web web
$ docker compose run --rm backend uv run ruff check . --fix
$ docker compose run --rm backend uv run ruff format .
# djlint によるフォーマット
$ docker compose run --rm backend uv run djlint templates/*/*.html --extension=html.j2 --reformat

http://localhost:8000/web/
```

### Devin

- [Devin's Machine](https://app.devin.ai/workspace) でリポジトリ追加

#### 1.Git Pull
- そのまま

#### 2.Configure Secrets
```sh
# 環境変数用のファイル作成
$ touch .envrc
$ cp .envrc.example .envrc
$ direnv allow
```

- ローカル用
```sh
$ brew install direnv
```
#### 4.Maintain Dependencies
```sh
$ docker compose up -d

# コンテナ作り直し
$ ./remake-container.sh
```

#### 5.SetUp Lint
```sh
$ docker compose run --rm backend uv run ruff check .

# mypy による型ヒントチェック
$ docker compose run --rm backend uv run mypy .

$ docker compose run --rm backend uv run djlint templates/*/*.html --extension=html.j2 --lint
```

#### 6.SetUp Tests
- no tests ran in 0.00s だと Devin の Verify が通らないっぽい
```sh
$ docker compose run --rm backend uv run pytest
```

### 7.Setup Local App

```sh
$ http://localhost:8000/ がアプリケーションのURL
```

#### 8.Additional Notes
- 必ず日本語で回答してください
- Python, Django を利用する
- データベースは Postgres
- テストは pytest を利用する
を入力

### OPENAI-API で PR-Review
- [Qodo Merge](https://qodo-merge-docs.qodo.ai/installation/github/)
  - GPT-4.1利用
  - 日本語の回答をするようプロンプト設定
- GitHub の Repository >> Settings >> Secretes and variables >> Actions の Repository secrets の New repository secret を登録
  - OPENAI_KEY という名称で OPENAI API keys の SECRET KEY を登録
    - [OPENAI API keys](https://platform.openai.com/settings/organization/api-keys) 
```sh
--- .github/
           |- workflows/
                        |-- pr_agent.yml
```
