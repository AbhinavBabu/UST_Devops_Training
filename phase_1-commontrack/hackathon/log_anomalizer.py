freq = {}
#file_name = input("Enter filename: ")
tot = 0
with open("sample.log","w") as f1:
  f1.write("Practice a code every day")
  f1.write("Hello world Hello")
try:
  with open("sample.log","r") as f:
    for line in f:
      for word in line:
        freq[word] = freq.get(word,0) + 1
        tot+=1
    print(freq)
    for word in freq:
      if freq[word] < 0.01 * tot:
        for line in f:
          if word in line:
            print(line)
except FileNotFoundError:
  print("File not found")
