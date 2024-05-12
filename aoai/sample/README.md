# Sample Chat App with AOAI
https://github.com/microsoft/sample-app-aoai-chatGPT/tree/main


## Scripts の実行
### 事前準備
```Shell
$ git clone https://github.com/microsoft/sample-app-aoai-chatGPT.git
$ pip install --user -r requirements.txt

# 下記も必要？
$ pip install azure.ai.formrecognizer
$ pip install markdown
$ pip install tiktoken
$ pip install bs4
$ pip install langchain
```

### テキストを AI Search のインデックスに登録する
config.json を編集する
```Json
[
    {
        "data_path": "C:\\develop\\demo\\data",
        "location": "japaneast",
        "subscription_id": "xxx",
        "resource_group": "xxx",
        "search_service_name": "xxx",
        "index_name": "index01",
        "chunk_size": 1024,
        "token_overlap": 128,
        "semantic_config_name": "default",
        "language": "ja"
    }
]
```
data_preparation.py を実行する
```Shell
$ python data_preparation.py --config config.json --njobs=4
```

### PDF を AI Search のインデックスに登録する（Document Intelligence）
config.json を編集する
```Json
[
    {
        "data_path": "C:\\develop\\demo\\data",
        "location": "japaneast",
        "subscription_id": "xxx",
        "resource_group": "xxx",
        "search_service_name": "xxx",
        "index_name": "index01",
        "chunk_size": 1024,
        "token_overlap": 128,
        "semantic_config_name": "default",
        "language": "ja"
    }
]
```
Document Intelligence の情報を指定して、data_preparation.py を実行する
```Shell
$ python data_preparation.py --config config.json --njobs=1 --form-rec-resource xxx --form-rec-key xxx
```

### ベクトルで AI Search のインデックスに登録する（AOAI の Embedding Model）
config.json を編集する
```Json
[
    {
        "data_path": "C:\\develop\\demo\\data",
        "location": "japaneast",
        "subscription_id": "xxx",
        "resource_group": "xxx",
        "search_service_name": "xxx",
        "index_name": "index01",
        "chunk_size": 1024,
        "token_overlap": 128,
        "semantic_config_name": "default",
        "language": "ja",
        "vector_config_name": "vector-config"
    }
]
```
AOAI の Embedding Model の情報を指定して、data_preparation.py を実行する
```Shell
$ python data_preparation.py --config config.json --embedding-model-endpoint https://xxx.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15 --embedding-model-key xxx
```

401 エラーが発生してしまい、未解決
```Shell
Error getting embedding for chunk with error=Error getting embeddings with endpoint=https://xxx.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15 with error=Error code: 401 - {'error': {'code': 'PermissionDenied', 'message': 'Principal does not have access to API/Operation.'}}, retrying, current at 1 retry, 4 retries left
```


