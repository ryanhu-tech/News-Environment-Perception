# News Environment Perception

**[Notes]** The repo may be incomplete and some of the code is a bit messy. We will improve in the near future. Readme will also include more details. Coming soon stay tuned :)

---

This is the official repository of the paper:

> **Zoom Out and Observe: News Environment Perception for Fake News Detection**
>
> Qiang Sheng, Juan Cao, Xueyao Zhang, Rundong Li, Danding Wang, and Yongchun Zhu
>
> *Proceedings of the 60th Annual Meeting of the Association for Computational Linguistics (ACL 2022)*
>
> [PDF](https://aclanthology.org/2022.acl-long.311.pdf) / [Poster](https://sheng-qiang.github.io/data/NEP-Poster.pdf) / [Code](https://github.com/ICTMCG/News-Environment-Perception) / [Chinese Video](https://www.bilibili.com/video/BV1MS4y1e7PY) / [Chinese Blog](https://mp.weixin.qq.com/s/aTFeuCYIpSoazeRi52jqew)

# Datasets

The experimental datasets where can be seen in `dataset` folder, including the [Chinese Dataset](https://github.com/ICTMCG/News-Environment-Perception/tree/main/dataset/Chinese), and the [English Dataset](https://github.com/ICTMCG/News-Environment-Perception/tree/main/dataset/English). Note that you can download the datasets only after an ["Application to Use the Datasets for XXXXXX"]() has been submitted.

# Code

## Key Requirements

```
python==3.6.10
torch==1.6.0
transformers==4.0.0
```

## Preparation

### Step 1: Obtain the representations of posts and news environment items

#### Step1.1: Prepare the SimCSE model

Due to the space limit of the GitHub, we upload the SimCSE's training data by [Google Drive](https://drive.google.com/drive/folders/1J8p6ORqOhlpjl2lWAWq43pgUdG1O0L9T?usp=sharing). You need to download the dataset file (i.e., `[dataset]_train.txt`), and move it into the `preprocess/SimCSE/train_SimCSE/data` of this repo. Then,

```
cd preprocess/SimCSE/train_SimCSE

# Configure the dataset.
sh train.sh
```

Of course, you can also prepare the SimCSE model by your custom dataset. 

#### Step1.2: Obtain the texts' representations

```
cd preprocess/SimCSE

# Configure the dataset.
sh run.sh
```

### Step 2: Construct the macro & micro environment

Get the macro environment and rank its internal items by similarites:

```
cd preprocess/NewsEnv

# Configure the specific T days of the macro environment.
sh run.sh
```

### Step 3: Prepare for the specific detectors

This step is for the preparation of the specific detectors. There are six base models in our paper, and the preparation dependencies of them are as follows: 

<table>
   <tr>
       <td colspan="2"><b>Model</b></td>
       <td><b>Input (Tokenization)</b></td>
       <td><b>Special Preparation</b></td>
   </tr>
   <tr>
       <td rowspan="4"><b>Post-Only</b></td>
       <td>Bi-LSTM</td>
      <td>Word Embeddings</td>
      <td>-</td>
   </tr>
   <tr>
      <td>EANN</td>
      <td>Word Embeddings</td>
      <td>Event Adversarial Training</td>
   </tr>
   <tr>
      <td>BERT</td>
      <td>BERT's Tokens</td>
      <td>-</td>
   </tr>
   <tr>
      <td>BERT-Emo</td>
      <td>BERT's Tokens</td>
      <td>Emotion Features</td>
   </tr>
   <tr>
       <td rowspan="2"><b>"Zoom-In"</b></td>
      <td>DeClarE</td>
      <td>Word Embeddings</td>
      <td rowspan="2">Fact-checking Articles</td>
   </tr>
   <tr>
      <td>MAC</td>
      <td>Word Embeddings</td>
   </tr>
</table>

In the table above, there are five preprocess in total: (1) Tokenization by Word Embeddings, (2) Tokenization by BERT, (3) Event Adversarial Training, (4) Emotion Features, and (5) Fact-checking Articles. We will describe the five respectively.

#### Tokenization by Word Embeddings

This tokenization is dependent on the external pretrained word embeddings. In our paper, we use the [sgns.weibo.bigram-char](<https://github.com/Embedding/Chinese-Word-Vectors>) ([Downloading URL](https://pan.baidu.com/s/1FHl_bQkYucvVk-j2KG4dxA)) for Chinese and [glove.840B.300d](https://github.com/stanfordnlp/GloVe) ([Downloading URL](https://huggingface.co/stanfordnlp/glove/resolve/main/glove.840B.300d.zip)) for English.

```
cd preprocess/WordEmbeddings

# Configure the dataset and your local word-embeddings filepath. 
sh run.sh
```

#### Tokenization by BERT

```
cd preprocess/BERT

# Configure the dataset and the pretrained model
sh run.sh
```

#### Event Adversarial Training

```
cd preprocess/EANN

# Configure the dataset and the event number
sh run.sh
```

#### Emotion Features

```
cd preprocess/Emotion/code/preprocess

# Configure the dataset
sh run.sh
```

#### Fact-checking Articles

Firstly, tokenize the fact-checking articles (by word embeddings, for DeClarE and MAC):

```
cd preprocess/WordEmbeddings

# Configure the dataset and your local word-embeddings filepath. Set the data_type as 'article'.
sh run.sh
```

Then, retrieve the most relevant 10 articles for every post (these 10 articles should be published BEFORE the post) by BM25 algorithm. Note that we have shared the retrieved results in the `preprocess/BM25/data` folder. If you want to learn about more implementation details, just refer to `preprocess/BM25/[dataset].ipynb`.

## Training and Inferring

# Citation

```
@inproceedings{NEP,
    title = "Zoom Out and Observe: News Environment Perception for Fake News Detection",
    author = "Sheng, Qiang  and
      Cao, Juan  and
      Zhang, Xueyao  and
      Li, Rundong and
      Wang, Danding  and
      Zhu, Yongchun",
    booktitle = "Proceedings of the 60th Annual Meeting of the Association for Computational Linguistics",
    month = may,
    year = "2022",
    publisher = "Association for Computational Linguistics"
}
```
