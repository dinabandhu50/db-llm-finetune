import os

from dotenv import load_dotenv
from huggingface_hub import snapshot_download

load_dotenv()

MODEL_DIR = os.path.join("/Users", "dina", "models")
HF_TOKEN = os.getenv("HF_TOKEN")


all_model = {
    "models-gguf": [],
    "models-tgi": ["meta-llama/Llama-3.2-1B-Instruct"],
    "models-embd": [],
    "models-reranker": [],
}


def download_model(repo_id: str, local_dir: str):
    snapshot_download(
        repo_id=repo_id,
        local_dir=local_dir,
        local_dir_use_symlinks=False,
        revision="main",
        token=HF_TOKEN,
        # allow_patterns="*Q5_K_M"
        # allow_patterns="*Q8*"
        ignore_patterns="*bin*",
    )


for folder_name, repo_ids in all_model.items():
    for repo_id in repo_ids:
        local_dir = os.path.join(MODEL_DIR, f"{folder_name}", repo_id)
        print(f"Downloading {repo_id} into {local_dir} folder ...")
        download_model(repo_id=repo_id, local_dir=local_dir)
