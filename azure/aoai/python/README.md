# Python

## PDF をテキストに変換する
```Python
from pypdf import PdfReader

reader = PdfReader(".\就業規則.pdf")

with open('就業規則.txt', 'w', encoding='utf-8') as f:
    for page in reader.pages:
        text = page.extract_text()
        f.write(text)
        f.write('\n')
```

