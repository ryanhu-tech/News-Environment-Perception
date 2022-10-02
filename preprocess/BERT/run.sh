# ===================== Configuration =====================
# 'Chinese' or 'English'
dataset_name='English'
# 'bert-base-chinese' or 'bert-base-uncased'
pretrained_model='bert-base-uncased'

# ===================== Tokenization by BERT =====================
python get_bert_tokens.py --dataset ${dataset_name} --pretrained_model ${pretrained_model}