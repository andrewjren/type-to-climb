import io
import re 

words_3 = []
csv_text = ""

# statistics 
num_words = 0


with open("words_all.txt","r") as words_all:

    lines = words_all.read().splitlines()
    
    for line in lines:
        line_length = len(line)
        
        # ignore words with less than 3 characters
        if line_length < 3: # include newline
            continue

        if re.search(r"[-\(\)\{\}]",line):
            continue

        csv_text = csv_text + f"{line},{line_length}\n"
        num_words = num_words + 1


for idx in range(1,40):
    count = len(re.findall(f",{idx}\n", csv_text))
    print(f"{count} words with {idx} letters")

print(f"{num_words} total")

with open("dict_1.dat","w") as csv_out:
    csv_out.write("word,length\n")
    csv_out.write(csv_text)
