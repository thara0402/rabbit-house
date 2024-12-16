# Streamlit

## Create an environment using venv
```shell-session
$ cd myproject
$ python -m venv .venv
```

## Activate your environment
```shell-session
$ .venv\Scripts\activate.bat
```

## Install Streamlit in your environment
```shell-session
$ pip install streamlit
```

## Create a "Hello World" app
```shell-session
$ touch app.py
```
```python
import streamlit as st

st.write("Hello world")
```

## Run your Streamlit app
```shell-session
$ streamlit run app.py
```

## return to your normal shell
```shell-session
$ deactivate
```

