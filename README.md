# ASH
Pokémon trainer's toolbox :dragon_face:

### Encryption
```
7z a \
  -t7z -m0=lzma2 -mx=9 -mfb=64 \
  -md=32m -ms=on -mhe=on -p \
  -x!.git -x!submodules \
   ../ash.7z .
```
### Decryption
```
7z x ash.7z
```
