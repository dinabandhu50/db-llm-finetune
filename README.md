# Fine Tuning LLM Models  

## Few useful commands  
`uv` commands:  

```sh
# basic uv
uv sync
uv add -r requirements.txt
uv add --dev -r requirements-dev.txt
# linting
ruff check .
ruff check --fix .
ruff check --exclude *.ipynb --fix .
ruff check --select I --exclude '*.ipynb' --fix .
# formatting
ruff format --check .
ruff format --exclude '*.ipynb' --check .
```

`git` commands:  

```sh
# branch commands
git checkout runpod
git checkout -b new-branch

# reset commands
git reset --hard HEAD~1
```