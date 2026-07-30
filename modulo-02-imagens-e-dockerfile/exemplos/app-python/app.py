import time

contador = 1
while True:
    print(f"[{contador}] Container vivo! O processo principal sou eu, o Python.", flush=True)
    contador += 1
    time.sleep(5)
