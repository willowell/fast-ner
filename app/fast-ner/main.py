from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import spacy
from spacy import displacy

app = FastAPI()

import spacy

nlp = spacy.load("en_core_web_lg")


@app.get("/")
def get_index():
    return {
        "Bonjour": "tout le monde !"
    }


@app.get("/nlp/ents/{corpus}")
def get_entities(corpus: str):
    doc = nlp(corpus)

    entities = [{
        "text": ent.text,
        "start": ent.start_char,
        "end": ent.end_char,
        "label": ent.label_,
    }
    for ent in doc.ents]

    return {
        "entities": entities,
    }


@app.get("/nlp/ents/pretty/{corpus}", response_class=HTMLResponse)
def get_entities_as_rendered_pretty_html(corpus: str):
    doc = nlp(corpus)

    html = displacy.render(doc, style="ent", page=True)
        
    return HTMLResponse(content=html)


@app.get("/nlp/tokens/{corpus}")
def get_tokens(corpus: str):
    doc = nlp(corpus)

    tokens = [{
        "text": token.text,
        "lemma": token.lemma_,
        "pos": token.pos_,
        "tag": token.tag_,
        "dep": token.dep_,
        "shape": token.shape_,
    }
    for token in doc]

    return {
        "tokens": tokens,
    }
