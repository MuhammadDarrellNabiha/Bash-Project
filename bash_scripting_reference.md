# Bash Scripting & Linux Command Reference

---

## 📑 Daftar Isi

**Bagian A — Command Line Utilities**
A1. Navigasi & Manajemen File · A2. Text Processing · A3. Permission & Ownership · A4. Pencarian (Search) · A5. Process Management · A6. Archive & Compression · A7. System Info · A8. Networking Dasar · A9. Command Lain-Lain

**Bagian B — Bash Scripting Fundamentals**
B1. Struktur Dasar · B2. Variabel & Special Variables · B3. Quoting & Escaping · B4. Operator · B5. Conditional · B6. Looping · B7. Function · B8. Array · B9. String Manipulation · B10. I/O Redirection & Pipe · B11. Command & Process Substitution · B12. Input Handling · B13. Error Handling & Debugging · B14. Topik Advanced Lainnya


# BAGIAN A — COMMAND LINE UTILITIES

## A1. Navigasi & Manajemen File

#### `pwd` — Print Working Directory
```bash
pwd        # tampilkan path direktori saat ini
pwd -P     # physical path (resolve symlink)
```

#### `cd` — Change Directory
| Command | Keterangan |
|---|---|
| `cd folder` | Pindah ke folder |
| `cd ..` | Naik satu level |
| `cd ~` / `cd` | Kembali ke home directory |
| `cd -` | Kembali ke direktori sebelumnya |
| `cd /` | Ke root directory |

#### `ls` — List Directory Contents
| Flag | Keterangan |
|---|---|
| `-l` | Format panjang (permission, owner, size, date) |
| `-a` | Tampilkan semua termasuk hidden file (dotfiles) |
| `-A` | Seperti `-a` tapi exclude `.` dan `..` |
| `-h` | Human-readable size (pakai bareng `-l`) |
| `-R` | Recursive, tampilkan subfolder juga |
| `-t` | Sort berdasarkan waktu modifikasi |
| `-S` | Sort berdasarkan ukuran |
| `-r` | Reverse order |
| `-d` | Tampilkan info folder itu sendiri, bukan isinya |
| `-1` | Satu file per baris |
| `-i` | Tampilkan inode number |

Kombinasi yang sering dipakai: `ls -lah`, `ls -lt`, `ls -lR`

#### `mkdir` — Make Directory
| Flag | Keterangan |
|---|---|
| `-p` | Buat parent directory kalau belum ada (`mkdir -p a/b/c`) |
| `-m` | Set permission langsung saat buat |
| `-v` | Verbose |

#### `rmdir` — Remove Directory (harus kosong)
`-p` → hapus parent directory juga kalau ikut kosong

#### `touch` — Buat File Kosong / Update Timestamp
| Flag | Keterangan |
|---|---|
| `-a` | Update access time saja |
| `-m` | Update modification time saja |
| `-c` | Jangan buat file baru kalau belum ada |
| `-t STAMP` | Set timestamp spesifik |

#### `cp` — Copy
| Flag | Keterangan |
|---|---|
| `-r` / `-R` | Recursive (wajib untuk copy folder) |
| `-v` | Verbose |
| `-i` | Interactive, tanya dulu sebelum overwrite |
| `-u` | Update, copy hanya kalau source lebih baru |
| `-p` | Preserve attribute (permission, timestamp) |
| `-f` | Force |
| `-a` | Archive mode (recursive + preserve semua atribut) |

#### `mv` — Move / Rename
| Flag | Keterangan |
|---|---|
| `-i` | Interactive |
| `-v` | Verbose |
| `-u` | Update saja kalau source lebih baru |
| `-n` | No-clobber, jangan overwrite |

#### `rm` — Remove
| Flag | Keterangan |
|---|---|
| `-r` / `-R` | Recursive, untuk hapus folder |
| `-f` | Force, tanpa konfirmasi & ignore file yang gak ada |
| `-i` | Interactive |
| `-v` | Verbose |
| `-d` | Hapus directory kosong |

> ⚠️ Hati-hati `rm -rf` — gak ada Recycle Bin di terminal!

#### `ln` — Link
```bash
ln file.txt hardlink.txt        # hard link (default)
ln -s file.txt symlink.txt      # symbolic link
ln -sf target linkname          # force overwrite link
```

#### `cat`, `tac`, `less`, `more`
| Command | Keterangan |
|---|---|
| `cat file` | Tampilkan isi file |
| `cat -n file` | Dengan nomor baris |
| `cat -A file` | Tampilkan karakter tersembunyi (tab, end of line) |
| `cat f1 f2 > gabungan` | Gabungkan file |
| `tac file` | Seperti `cat` tapi terbalik (baris terakhir duluan) |
| `less file` | Buka per halaman; `/kata` search, `n`/`N` next/prev match, `q` keluar |
| `more file` | Mirip `less`, lebih sederhana |

#### `head` / `tail`
| Command | Keterangan |
|---|---|
| `head -n 5 file` | 5 baris pertama |
| `head -c 100 file` | 100 byte pertama |
| `tail -n 5 file` | 5 baris terakhir |
| `tail -f file` | Follow, live update (buat log) |
| `tail -n +5 file` | Tampilkan dari baris ke-5 sampai akhir |

#### `wc` — Word Count
| Flag | Keterangan |
|---|---|
| `-l` | Jumlah baris |
| `-w` | Jumlah kata |
| `-c` | Jumlah byte |
| `-m` | Jumlah karakter |
| `-L` | Panjang baris terpanjang |

#### `file`, `stat`, `basename`, `dirname`
```bash
file dokumen.pdf                   # deteksi tipe file
stat dokumen.pdf                   # info detail (size, permission, timestamp)
basename /home/user/file.txt       # -> file.txt
basename /home/user/file.txt .txt  # -> file
dirname /home/user/file.txt        # -> /home/user
```

---

## A2. Text Processing

#### `grep` — Pattern Searching
| Flag | Keterangan |
|---|---|
| `-i` | Case-insensitive |
| `-v` | Invert match (yang TIDAK cocok) |
| `-r` / `-R` | Recursive ke subfolder |
| `-n` | Tampilkan nomor baris |
| `-c` | Hitung jumlah baris yang cocok |
| `-l` | Hanya nama file yang match |
| `-L` | Hanya nama file yang TIDAK match |
| `-o` | Hanya tampilkan bagian yang match |
| `-E` | Extended regex (setara `egrep`) |
| `-F` | Fixed string, bukan regex (setara `fgrep`) |
| `-w` | Match seluruh kata |
| `-x` | Match seluruh baris |
| `-A N` | N baris setelah match |
| `-B N` | N baris sebelum match |
| `-C N` | N baris sebelum+sesudah |

```bash
grep -rn "TODO" ./src
grep -Eo "[0-9]+" file.txt
ps aux | grep -v grep | grep firefox
```

#### `sed` — Stream Editor
| Flag/Sintaks | Keterangan |
|---|---|
| `-i` | Edit langsung ke file (in-place) |
| `-i.bak` | Edit in-place + backup ke `file.bak` |
| `-e` | Tambah script expression |
| `-n` | Suppress auto print (dipakai bareng `p`) |
| `-r` / `-E` | Extended regex |
| `s/pola/ganti/` | Substitusi pertama tiap baris |
| `s/pola/ganti/g` | Substitusi semua (global) |
| `s/pola/ganti/2` | Substitusi occurrence ke-2 |
| `Nd` | Hapus baris ke-N |
| `/pola/d` | Hapus baris yang match pola |
| `N,Mp` (dgn `-n`) | Print baris N sampai M |

```bash
sed 's/foo/bar/g' file.txt
sed -i 's/localhost/127.0.0.1/g' config.conf
sed -n '10,20p' file.txt
sed '/^#/d' file.txt    # hapus baris comment
```

#### `awk` — Text Processing Language
| Konsep | Keterangan |
|---|---|
| `$0` | Seluruh baris |
| `$1, $2, ...` | Field/kolom ke-1, ke-2, dst |
| `NR` | Nomor baris saat ini |
| `NF` | Jumlah field di baris saat ini |
| `-F` | Set delimiter/field separator |
| `BEGIN{}` | Dieksekusi sebelum baca input |
| `END{}` | Dieksekusi setelah selesai baca input |

```bash
awk '{print $1}' file.txt              # print kolom pertama
awk -F: '{print $1}' /etc/passwd       # delimiter custom
awk '{sum+=$3} END{print sum}' file    # total kolom 3
awk '$3 > 50' file.txt                 # filter baris
awk 'NR==3' file.txt                   # print baris ke-3
```

#### `cut`, `sort`, `uniq`, `tr`

**cut**
| Flag | Keterangan |
|---|---|
| `-d` | Delimiter |
| `-f` | Pilih field (`-f1,3` atau `-f1-3`) |
| `-c` | Pilih posisi karakter |

**sort**
| Flag | Keterangan |
|---|---|
| `-n` | Sort numerik |
| `-r` | Reverse |
| `-k N` | Sort berdasarkan kolom N |
| `-t` | Delimiter field |
| `-u` | Unik (hapus duplikat) |
| `-f` | Case-insensitive |
| `-h` | Human numeric (1K, 2M, dst) |

**uniq** (perlu di-`sort` dulu, cuma cek baris berdekatan)
| Flag | Keterangan |
|---|---|
| `-c` | Tampilkan jumlah kemunculan |
| `-d` | Hanya yang duplikat |
| `-u` | Hanya yang unik |
| `-i` | Case-insensitive |

```bash
cut -d',' -f1,3 data.csv
sort -t',' -k2,2n data.csv
sort file.txt | uniq -c | sort -nr   # hitung & ranking kata terbanyak
```

**tr** — Translate Characters
```bash
tr 'a-z' 'A-Z' < file.txt     # lowercase ke uppercase
tr -d '0-9' < file.txt        # hapus semua digit
tr -s ' ' < file.txt          # squeeze multiple space jadi satu
```

#### Command Pendukung Lainnya
| Command | Keterangan |
|---|---|
| `paste file1 file2` | Gabungkan baris dari beberapa file secara horizontal |
| `join file1 file2` | Join berdasarkan field yang sama |
| `split -l 100 file` | Pecah file jadi beberapa bagian (100 baris/file) |
| `column -t file` | Format jadi tabel rapi |
| `rev` | Balik urutan karakter tiap baris |
| `fold -w 40` | Wrap baris di lebar 40 karakter |
| `xargs` | Bangun & eksekusi command dari input |

```bash
find . -name "*.log" | xargs rm
cat files.txt | xargs -I {} cp {} /backup/
echo "a b c" | xargs -n1     # satu argumen per baris
```

#### Quick Reference Regex (untuk grep/sed/awk)
| Simbol | Arti |
|---|---|
| `.` | Karakter apa saja |
| `*` | 0+ dari karakter sebelumnya |
| `+` | 1+ (perlu extended/-E) |
| `?` | 0 atau 1 (perlu extended/-E) |
| `^` | Awal baris |
| `$` | Akhir baris |
| `[abc]` | Salah satu dari a, b, c |
| `[^abc]` | Bukan a, b, atau c |
| `[a-z]` | Range a sampai z |
| `()` | Grouping (perlu extended/-E) |
| `\|` | Alternation/atau (perlu extended/-E) |
| `{n,m}` | Repetisi n sampai m kali |

---

## A3. Permission & Ownership

#### `chmod` — Change Mode
Numeric: read=4, write=2, execute=1 → jumlahkan untuk kombinasi
```bash
chmod 755 script.sh     # rwxr-xr-x
chmod 644 file.txt      # rw-r--r--
chmod -R 755 folder/    # recursive
chmod u+x script.sh     # tambah execute untuk owner
chmod g-w file.txt      # hapus write untuk group
chmod o=r file.txt      # set permission other jadi read-only
```
`u`=user/owner, `g`=group, `o`=other, `a`=all · `+` tambah, `-` hapus, `=` set persis

#### `chown` / `chgrp`
```bash
chown user:group file.txt
chown -R user:group folder/
chgrp group file.txt
```

#### `umask`
```bash
umask        # tampilkan default mask
umask 022    # file baru jadi 644, folder jadi 755
```

---

## A4. Pencarian (Search)

#### `find`
| Opsi | Keterangan |
|---|---|
| `-name "pola"` | Cari berdasarkan nama (case-sensitive) |
| `-iname "pola"` | Case-insensitive |
| `-type f/d/l` | File / directory / symlink |
| `-size +10M` | Lebih besar dari 10MB |
| `-size -1k` | Lebih kecil dari 1KB |
| `-mtime -7` | Dimodifikasi dalam 7 hari terakhir |
| `-mtime +30` | Dimodifikasi lebih dari 30 hari lalu |
| `-newer file` | Lebih baru dari file tertentu |
| `-empty` | File/folder kosong |
| `-maxdepth N` | Batasi kedalaman folder |
| `-perm 644` | Match permission tertentu |
| `-exec cmd {} \;` | Jalankan command tiap hasil satu-satu |
| `-exec cmd {} +` | Jalankan command dengan batch (lebih efisien) |
| `-delete` | Hapus hasil yang match |

```bash
find . -name "*.log" -mtime +30 -delete
find /var -type f -size +100M
find . -name "*.sh" -exec chmod +x {} \;
```

#### `which`, `whereis`, `type`, `locate`
| Command | Keterangan |
|---|---|
| `which cmd` | Lokasi executable dari command |
| `whereis cmd` | Lokasi binary, source, manual |
| `type cmd` | Builtin / alias / function / file? |
| `locate nama` | Cari pakai database (cepat, butuh `updatedb`) |

---

## A5. Process Management

| Command | Keterangan |
|---|---|
| `ps aux` | Semua proses (format BSD) |
| `ps -ef` | Semua proses (format System V) |
| `top` / `htop` | Monitor proses interaktif real-time |
| `kill PID` | Kirim SIGTERM (15) ke proses |
| `kill -9 PID` | Kirim SIGKILL (paksa, gak bisa di-ignore) |
| `kill -l` | List semua nama signal |
| `killall nama` | Kill berdasarkan nama proses |
| `pkill pola` | Kill berdasarkan pattern |
| `jobs` | List background job di shell saat ini |
| `bg` / `fg` | Lanjutkan job di background / bawa ke foreground |
| `cmd &` | Jalankan command di background |
| `nohup cmd &` | Tetap jalan walau terminal ditutup |
| `wait` | Tunggu semua background job selesai |
| `disown` | Lepas job dari job table shell |

Signal penting: `SIGHUP(1)`, `SIGINT(2)` (Ctrl+C), `SIGKILL(9)`, `SIGTERM(15)`, `SIGTSTP(20)` (Ctrl+Z)

---

## A6. Archive & Compression

#### `tar`
| Flag | Keterangan |
|---|---|
| `-c` | Create archive |
| `-x` | Extract |
| `-v` | Verbose |
| `-f` | Nama file archive |
| `-z` | Gunakan gzip (`.tar.gz`) |
| `-j` | Gunakan bzip2 (`.tar.bz2`) |
| `-t` | List isi archive tanpa extract |

```bash
tar -czvf archive.tar.gz folder/       # compress
tar -xzvf archive.tar.gz               # extract
tar -tzvf archive.tar.gz               # lihat isi
tar -xzvf archive.tar.gz -C /tujuan/   # extract ke folder tertentu
```

#### `gzip` / `zip`
```bash
gzip file.txt          # jadi file.txt.gz (file asli hilang)
gzip -k file.txt       # keep file asli
gunzip file.txt.gz
zip -r archive.zip folder/
unzip archive.zip
unzip -l archive.zip   # list isi tanpa extract
```

---

## A7. System Info

| Command | Keterangan |
|---|---|
| `uname -a` | Info sistem lengkap |
| `df -h` | Disk usage (human-readable) |
| `du -sh folder/` | Total ukuran folder |
| `du -h --max-depth=1` | Ukuran tiap subfolder |
| `free -h` | Info RAM |
| `uptime` | Lama sistem nyala + load average |
| `whoami` | User saat ini |
| `who` / `w` | User yang sedang login |
| `hostname` | Nama host |
| `id` | UID, GID, group |
| `date +"%Y-%m-%d"` | Tanggal format custom |

---

## A8. Networking Dasar

#### `curl`
| Flag | Keterangan |
|---|---|
| `-O` | Simpan dengan nama file dari URL |
| `-o file` | Simpan dengan nama custom |
| `-X METHOD` | HTTP method (GET, POST, dll) |
| `-H "header"` | Tambah header |
| `-d "data"` | Kirim data (POST) |
| `-I` | Hanya tampilkan header response |
| `-L` | Ikuti redirect |
| `-s` | Silent mode |

#### Lainnya
| Command | Keterangan |
|---|---|
| `wget -O file URL` | Download file |
| `wget -c URL` | Lanjutkan download yang terputus |
| `ping -c 4 host` | Ping 4 kali lalu berhenti |
| `ssh user@host` | Remote login |
| `scp file user@host:path` | Copy file lewat SSH |

---

## A9. Command Lain-Lain yang Wajib Tahu

| Command | Keterangan |
|---|---|
| `echo "teks"` | Cetak teks; `-e` enable escape (`\n`,`\t`); `-n` tanpa newline |
| `printf "%s\n" "teks"` | Cetak dengan format spesifik (lebih predictable dari echo) |
| `sleep 5` | Tunda 5 detik |
| `history` | Lihat riwayat command |
| `alias ll='ls -la'` | Buat shortcut command |
| `env` | Tampilkan environment variable |
| `man command` | Buka manual |
| `diff -u file1 file2` | Bandingkan dua file (unified format) |
| `tee file` | Tulis ke file SEKALIGUS tampilkan ke stdout |
| `seq 1 10` | Generate angka 1 sampai 10 |
| `shuf` | Acak urutan baris |
| `bc -l` | Kalkulator desimal (beda dengan `$(())` yang integer-only) |
| `watch -n 2 cmd` | Jalankan command tiap 2 detik |

```bash
echo $((10/3)) ; echo "10/3" | bc -l   # integer vs float division
command1 | tee output.txt | command2
```

---

# BAGIAN B — BASH SCRIPTING FUNDAMENTALS

## B1. Struktur Dasar Script
```bash
#!/bin/bash
# ini comment
echo "Hello World"
```
- Shebang wajib ada kalau mau dijalankan langsung (`./script.sh`)
- Beri permission execute: `chmod +x script.sh`
- Jalankan: `./script.sh` atau `bash script.sh`
- Cek syntax tanpa eksekusi: `bash -n script.sh`
- Debug mode (print tiap command sebelum jalan): `bash -x script.sh`
- `source script.sh` atau `. script.sh` → jalankan di shell YANG SAMA (variabel tetap ada setelah selesai, beda dengan `./script.sh` yang jalan di subshell terpisah)

## B2. Variabel & Special Variables
```bash
NAMA="Budi"           # TIDAK BOLEH ada spasi di sekitar =
echo "$NAMA"
echo "${NAMA}"        # kurawal disarankan, terutama digabung string lain
readonly PI=3.14      # konstanta, gak bisa diubah
export NAMA           # supaya bisa diakses child process/script lain
unset NAMA            # hapus variabel
```

| Variabel | Arti |
|---|---|
| `$0` | Nama script |
| `$1` ... `$9` | Argumen posisi ke-1 sampai ke-9 |
| `${10}` | Argumen ke-10+ (wajib pakai kurawal) |
| `$@` | Semua argumen, sebagai list terpisah |
| `$*` | Semua argumen, sebagai satu string |
| `$#` | Jumlah argumen |
| `$?` | Exit code command terakhir |
| `$$` | PID script saat ini |
| `$!` | PID proses background terakhir |
| `$_` | Argumen terakhir dari command sebelumnya |

## B3. Quoting & Escaping
| Tipe | Contoh | Perilaku |
|---|---|---|
| Single quote | `'$NAMA'` | Literal, TIDAK ada expansion |
| Double quote | `"$NAMA"` | Variable & command substitution jalan |
| `$()` / backtick | `$(cmd)` | Command substitution — `$()` lebih disarankan (bisa nested) |
| Backslash | `\$` | Escape karakter spesial |

> ⚠️ Best practice: selalu quote variable — `"$var"` bukan `$var` — supaya gak kena word-splitting/globbing kalau isinya ada spasi atau wildcard.

## B4. Operator

**Aritmatika**
```bash
echo $((5 + 3))
echo $((10 % 3))     # modulus
echo $((2 ** 8))     # pangkat
let x=5+3
((x++))
expr 5 + 3                          # cara lama/POSIX, perlu spasi di tiap operator
echo "10.5 / 2" | bc -l             # untuk float, pakai bc
```

**Perbandingan Numerik** (dipakai di `[ ]` / `test`)
| Operator | Arti |
|---|---|
| `-eq` | sama dengan |
| `-ne` | tidak sama dengan |
| `-gt` | lebih besar |
| `-lt` | lebih kecil |
| `-ge` | lebih besar sama dengan |
| `-le` | lebih kecil sama dengan |

**Perbandingan String**
| Operator | Arti |
|---|---|
| `=` / `==` | sama (dalam `[[ ]]`, `==` support wildcard) |
| `!=` | tidak sama |
| `-z` | string kosong |
| `-n` | string tidak kosong |
| `<` / `>` | leksikografis (perlu `[[ ]]`) |

**Test File**
| Operator | Arti |
|---|---|
| `-e` | file/folder ada |
| `-f` | regular file |
| `-d` | directory |
| `-r` / `-w` / `-x` | readable / writable / executable |
| `-s` | ukuran > 0 |
| `-L` | symbolic link |

**Logical & Command Chaining**
```bash
cmd1 ; cmd2          # jalankan berurutan, gak peduli hasil cmd1
cmd1 && cmd2         # cmd2 jalan HANYA kalau cmd1 sukses
cmd1 || cmd2         # cmd2 jalan HANYA kalau cmd1 gagal
! cmd                # negasi exit code
```

## B5. Conditional Statement
```bash
if [ "$umur" -ge 18 ]; then
    echo "Dewasa"
elif [ "$umur" -ge 13 ]; then
    echo "Remaja"
else
    echo "Anak-anak"
fi
```
```bash
case "$pilihan" in
    1|satu) echo "Satu" ;;
    2) echo "Dua" ;;
    *) echo "Tidak diketahui" ;;
esac
```
> `[[ ]]` lebih disarankan daripada `[ ]` di bash: support `&&`/`||` langsung di dalam, regex match (`=~`), dan aman walau variabel kosong/belum di-quote.

## B6. Looping
```bash
# for - list style
for i in 1 2 3 4 5; do echo "$i"; done
for i in {1..10}; do echo "$i"; done
for i in {0..20..5}; do echo "$i"; done   # step 5
for file in *.txt; do echo "$file"; done

# for - C style
for ((i=0; i<10; i++)); do echo "$i"; done

# while
while [ "$i" -le 5 ]; do echo "$i"; ((i++)); done
while read -r line; do echo "$line"; done < file.txt

# until (kebalikan while, jalan sampai kondisi TRUE)
until [ "$i" -ge 5 ]; do ((i++)); done

# select (bikin menu interaktif)
select opsi in "Mulai" "Keluar"; do
    case $opsi in
        "Mulai") echo "Dimulai" ;;
        "Keluar") break ;;
    esac
done
```
`break` keluar loop, `continue` lompat ke iterasi berikutnya, `break 2` keluar 2 level nested loop

## B7. Function
```bash
sapa() {
    local nama=$1          # local = scope dalam fungsi saja
    echo "Halo, $nama!"
    return 0                # return cuma untuk exit code (0-255), bukan nilai
}
sapa "Budi"
hasil=$(sapa "Ani")        # ambil "nilai balik": lewat echo + command substitution
```
Fungsi harus didefinisikan SEBELUM dipanggil. Pakai `local` di dalam fungsi supaya gak bentrok dengan variabel global.

## B8. Array
```bash
arr=(apel jeruk mangga)
echo "${arr[0]}"        # apel
echo "${arr[@]}"        # semua elemen
echo "${#arr[@]}"       # jumlah elemen: 3
echo "${!arr[@]}"       # semua index: 0 1 2
arr+=("anggur")          # tambah elemen
unset 'arr[1]'            # hapus elemen index 1

# Associative array (bash 4+)
declare -A umur
umur[budi]=20
umur[ani]=22
for key in "${!umur[@]}"; do echo "$key: ${umur[$key]}"; done
```
> ⚠️ macOS default masih bash 3.2 (gak support associative array). Lomba biasanya jalan di Linux dengan bash 4+/5+, jadi aman.

## B9. String Manipulation (Parameter Expansion)
| Sintaks | Fungsi |
|---|---|
| `${#str}` | Panjang string |
| `${str:pos}` | Substring dari posisi `pos` |
| `${str:pos:len}` | Substring dari `pos` sepanjang `len` |
| `${str/lama/baru}` | Ganti kemunculan pertama |
| `${str//lama/baru}` | Ganti semua kemunculan |
| `${str^^}` | UPPERCASE semua |
| `${str,,}` | lowercase semua |
| `${str^}` | Uppercase huruf pertama saja |
| `${str#pola}` | Hapus pola tersingkat dari awal |
| `${str##pola}` | Hapus pola terpanjang dari awal |
| `${str%pola}` | Hapus pola tersingkat dari akhir |
| `${str%%pola}` | Hapus pola terpanjang dari akhir |
| `${var:-default}` | Pakai `default` kalau `var` kosong/unset (var gak berubah) |
| `${var:=default}` | Set `var` jadi `default` kalau kosong/unset |
| `${var:+ganti}` | Pakai `ganti` HANYA kalau `var` terisi |
| `${var:?pesan}` | Error `pesan` kalau `var` kosong/unset |

```bash
file="dokumen.tar.gz"
echo "${file%%.*}"     # dokumen (hapus ekstensi terpanjang dari akhir)
echo "${file#*.}"      # tar.gz (hapus prefix tersingkat sampai titik pertama)
```

## B10. I/O Redirection & Pipe
| Sintaks | Fungsi |
|---|---|
| `>` | Redirect stdout, overwrite |
| `>>` | Redirect stdout, append |
| `<` | Redirect stdin dari file |
| `2>` | Redirect stderr |
| `2>>` | Append stderr |
| `&>` atau `> file 2>&1` | Redirect stdout & stderr ke tujuan sama |
| `2>&1` | Arahkan stderr ke tujuan stdout |
| `2>/dev/null` | Buang/sembunyikan stderr |
| `\|` | Pipe, output kiri jadi input kanan |
| `<<EOF ... EOF` | Heredoc, multi-line input |
| `<<<"$var"` | Herestring, kirim string langsung sebagai stdin |

```bash
command > output.txt 2>&1
cat <<EOF
Baris satu
Baris dua $variabel
EOF
grep "kata" <<< "$teks"
```

## B11. Command & Process Substitution
```bash
today=$(date +%Y-%m-%d)                      # command substitution
diff <(sort file1.txt) <(sort file2.txt)     # process substitution input
echo "halo" > >(cat)                          # process substitution output
```
`$()` lebih disarankan dari backtick (bisa di-nest). `<()`/`>()` bikin "file palsu" dari output/input command — berguna kalau command lain butuh nama file, bukan stdin.

## B12. Input Handling

#### `read`
| Flag | Keterangan |
|---|---|
| `-p "prompt"` | Tampilkan prompt sebelum input |
| `-s` | Silent, sembunyikan input (password) |
| `-a arr` | Simpan input ke array |
| `-t N` | Timeout N detik |
| `-n N` | Baca N karakter saja |
| `-r` | Raw, jangan treat backslash sebagai escape |

```bash
read -p "Masukkan nama: " nama
read -s -p "Password: " pass
while IFS= read -r line; do
    echo "Baris: $line"
done < file.txt
```
> Pola `while IFS= read -r line; do ... done < file` adalah cara PALING AMAN baca file baris-per-baris.

#### `getopts` — Parsing Argumen Command Line
```bash
while getopts "a:bh" opt; do
    case $opt in
        a) nilai_a="$OPTARG" ;;   # ":" setelah huruf = butuh argumen
        b) flag_b=true ;;
        h) echo "Usage: $0 -a value -b"; exit 0 ;;
        \?) echo "Opsi tidak dikenal"; exit 1 ;;
    esac
done
shift $((OPTIND -1))    # geser supaya $1 dst jadi argumen non-opsi
```

## B13. Error Handling & Debugging
```bash
command
echo $?                # cek exit code (0 = sukses)

set -e                  # exit otomatis kalau ada command gagal
set -u                  # error kalau pakai variabel yang belum di-set
set -x                  # print tiap command sebelum dieksekusi (debug)
set -o pipefail          # pipeline dianggap gagal kalau ADA SATU SAJA command di dalamnya gagal
set -euo pipefail        # kombinasi yang sering dipakai

trap 'echo "Dihentikan"; exit 1' SIGINT SIGTERM
trap 'rm -f /tmp/tempfile.$$' EXIT     # cleanup otomatis saat script selesai/exit
```

| Exit Code | Arti |
|---|---|
| 0 | Sukses |
| 1 | Error umum |
| 2 | Salah pakai shell builtin |
| 126 | File ditemukan tapi tidak bisa dieksekusi |
| 127 | Command tidak ditemukan |
| 128+n | Diterminasi signal n (130 = Ctrl+C) |

> Kalau tersedia di environment lomba, jalankan `shellcheck script.sh` — linter yang sangat membantu nemu bug sebelum runtime.

## B14. Topik Advanced Lainnya
```bash
# Brace expansion
echo {1..5}              # 1 2 3 4 5
echo {a,b,c}.txt          # a.txt b.txt c.txt
echo {01..10}             # 01 02 ... 10 (zero-padded)

# Subshell vs command group
(cd /tmp && ls)            # subshell — cd gak mempengaruhi shell luar
{ cd /tmp; ls; }           # command group — jalan di shell yang sama (perlu spasi & ; sebelum })

# mapfile / readarray (bash 4+)
mapfile -t lines < file.txt    # baca semua baris file ke array
echo "${lines[0]}"

# declare flags
declare -i angka=5         # paksa jadi integer
declare -r konstanta=10    # readonly
declare -x VAR=value       # otomatis export
declare -A map              # associative array

# Regex match langsung di [[ ]]
if [[ "$email" =~ ^[a-zA-Z0-9._]+@[a-zA-Z0-9.]+$ ]]; then
    echo "Email valid"
fi

# Default value untuk parameter posisi
nama=${1:-"Guest"}

# IFS (Internal Field Separator) untuk split string
IFS=',' read -ra parts <<< "1,2,3"
echo "${parts[1]}"   # 2
```

---
