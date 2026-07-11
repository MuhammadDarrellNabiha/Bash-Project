# 🐧 Materi Lengkap: *Learn Linux - The Full Course* (Boot.dev)

> Sumber video: [Learn Linux - The Full Course](https://www.youtube.com/watch?v=v392lEyM29A) — channel **Boot.dev**, ~2.5 jam, 6 bab.

## Kata Pembuka (baca dulu sebelum mulai)

Gua udah cek video lo. Ini video "Learn Linux - The Full Course" dari Boot.dev, isinya 6 bab, dan strukturnya persis kayak course interaktif Boot.dev yang emang dari dulu jadi rujukan orang belajar Linux dari nol. Timestamp-nya kayak gini:

| Bab | Topik | Mulai | Estimasi Durasi |
|---|---|---|---|
| 1 | Terminals and Shells | 04:03 | ~17 menit |
| 2 | Filesystems | 20:43 | ~31 menit |
| 3 | Permissions | 51:18 | ~22 menit |
| 4 | Programs | 01:13:31 | ~25 menit |
| 5 | Input/Output | 01:38:33 | ~40 menit |
| 6 | Packages | 02:18:43 | (sampai selesai) |

Karena lo bilang lebih efektif baca daripada dengerin orang ngomong, gua susun ulang **semua 6 bab itu dalam bentuk tulisan**, tapi bukan cuma "nulis ulang" — gua bangun tiap konsep dari dasar (kenapa fitur itu ada, gimana cara kerjanya di balik layar), baru masuk ke command dan contohnya, terus gua kasih juga kesalahan umum yang biasanya bikin orang stuck, dan gua kaitin ke bash scripting yang udah lo pelajarin belakangan ini karena banyak banget yang nyambung langsung.

Materinya gua perkuat pakai referensi dari sumber lain yang kredibel — dokumentasi resmi GNU coreutils, buku gratis *The Linux Command Line* (William Shotts), dan beberapa panduan sysadmin lain — biar penjelasannya lebih dalam dari yang biasanya kekejar kalo cuma dengerin video sekali jalan. Di akhir tiap bab ada link buat baca lebih lanjut kalo mau gali lebih jauh.

**Cara pakai dokumen ini:** jangan dibaca sambil lalu kayak baca novel. Tiap ada contoh command, buka terminal lo, ketik ulang, liat hasilnya. Paham itu bukan dari baca doang, tapi dari ngerti KENAPA command itu ngasih hasil kayak gitu.

---

## 📅 Bab 0: Rencana Belajar 7 Hari

Total materi video ini padat tapi kalo dipecah per hari + praktek, gampang kekejer dalam seminggu:

| Hari | Fokus | Kenapa |
|---|---|---|
| **1** | Bab 1 — Terminal & Shell | Pemanasan, pasang mental model dasar |
| **2** | Bab 2 — Filesystem | Bab terpanjang, paling banyak command harian |
| **3** | Bab 3 — Permissions | Konsep inti buat calon sysadmin |
| **4** | Bab 4 — Programs (PATH & Proses) | Langsung nyambung ke bash scripting lo |
| **5** | Bab 5 — Input/Output | **Paling krusial** buat scripting & automasi |
| **6** | Bab 6 — Packages + mulai latihan gabungan | Ringan, sambil ngerapihin apa yang udah dipelajari |
| **7** | Review total + latihan hands-on (OverTheWire Bandit) | Ngetes beneran paham apa cuma familiar |

Oke, gas mulai.

---

## 🖥️ Bab 1: Terminal & Shell

### 1.1 CLI vs GUI — kenapa harus belajar ini

GUI (*graphical user interface*) itu yang lo klik-klik pake mouse: ikon, menu, tombol. CLI (*command line interface*) itu kebalikannya — semua interaksi lo ke komputer berupa teks yang lo ketik, dan komputer balesnya juga pake teks.

Kedengerannya CLI itu "jadul" atau "buat yang gak bisa pake GUI", padahal justru sebaliknya: CLI itu jauh lebih *powerful* buat kerjaan teknis karena dua alasan utama:

1. **Composability** — command kecil bisa digabung jadi automasi yang kompleks (ini yang bakal lo pelajarin detail di Bab 5).
2. **Bisa di-*script*-kan** — apa pun yang bisa lo ketik di terminal, bisa lo taro di file `.sh` dan dijalankan otomatis. GUI gak bisa gitu.

Makanya buat kerjaan sysadmin/network engineer, CLI itu bukan pilihan — itu keharusan. Server itu seringnya gak punya GUI sama sekali (headless), jadi satu-satunya cara ngatur dia ya lewat CLI.

### 1.2 Istilah yang sering ketuker: Terminal, Shell, Console, CLI

Ini poin yang penting banget dipahamin dari awal karena orang (termasuk banyak tutorial) suka pake istilah ini bergantian padahal artinya beda:

- **Shell** — program yang benar-benar **menjalankan** command lo. Contoh: `bash`, `zsh`, `sh`. Ini "otak"-nya.
- **Terminal (emulator)** — program yang jadi "jendela" tempat lo ngetik dan liat output. Contoh: GNOME Terminal, iTerm2, Windows Terminal. Ini cuma "wadah", dia sendiri gak ngerti command apa pun — dia cuma nerusin apa yang lo ketik ke shell yang jalan di dalemnya, dan nampilin balik hasilnya.
- **Console** — dulunya istilah buat terminal fisik yang nyambung langsung ke mesin (bukan lewat network). Sekarang sering dipake gantian sama "terminal".
- **CLI** — istilah umum/payung buat "cara berinteraksi pake teks", bisa ngerujuk ke terminal ATAU shell tergantung konteks.

Analoginya: terminal itu kayak **layar & keyboard TV**, shell itu kayak **channel yang lagi lo tonton**. Lo bisa ganti channel (ganti shell dari bash ke zsh) tapi TV-nya (terminal) tetep sama.

### 1.3 Anatomi Prompt & Command

Waktu lo buka terminal, biasanya lo liat sesuatu kayak:

```bash
darrell@laptop:~$ 
```

Itu namanya **prompt** — tanda kalo shell lagi nunggu perintah. Perhatiin karakter di ujung:
- `$` → lo login sebagai **user biasa**
- `#` → lo login sebagai **root** (superuser, akses penuh ke sistem — hati-hati banget kalo liat `#`)

Setiap command yang lo ketik punya struktur:

```bash
command  -flag  argument
   |        |       |
 program  opsi   data/target
```

Contoh: `ls -la /home` → `ls` itu command-nya, `-la` itu flag/opsi (gabungan `-l` dan `-a`), `/home` itu argument (target yang mau di-list).

### 1.4 Variabel di Shell

Shell bisa nyimpen nilai di variabel, mirip programming language biasa:

```bash
NAME="Darrell"
echo $NAME
# Darrell
```

Beberapa hal penting yang **sering bikin bug** (dan ini lo udah pernah ketemu pas debugging bash script lo):

- **Gak ada spasi** di sekitar tanda `=` waktu assign. `NAME = "Darrell"` itu **salah** — shell bakal ngira `NAME` itu command.
- **Selalu quote variabel** yang mungkin isinya ada spasi:
  ```bash
  FILE="laporan bulanan.txt"
  rm $FILE     # SALAH: rm baca ini sebagai 2 argumen terpisah: "laporan" dan "bulanan.txt"
  rm "$FILE"   # BENAR: rm baca sebagai 1 argumen
  ```
- **Double quote vs single quote**: dalam `"..."` variabel di-*expand* (diganti isinya), dalam `'...'` **tidak**:
  ```bash
  echo "$NAME"   # Darrell
  echo '$NAME'   # $NAME (literal, gak di-expand)
  ```

### 1.5 Environment Variable vs Shell Variable

Variabel biasa (`NAME="Darrell"`) cuma keliatan di shell itu sendiri. Kalo lo mau variabel itu **diwariskan** ke program lain yang lo jalanin dari shell tersebut (disebut *child process*), lo harus `export` dia jadi **environment variable**:

```bash
export NODE_ENV=development
node app.js   # app.js sekarang bisa baca NODE_ENV
```

Environment variable paling penting yang bakal lo temuin terus-terusan adalah `PATH` — ini bakal dibahas detail di Bab 4, tapi intinya dia nyimpen daftar folder tempat shell nyari program yang lo jalanin pake nama doang (misal ngetik `bash` tanpa nulis full path-nya).

### 1.6 History & Navigasi Cepat

- **Panah atas/bawah** → muter-muter command yang pernah lo ketik sebelumnya.
- **`history`** → nampilin daftar lengkap command yang udah pernah dijalanin.
- **`Ctrl+R`** → *reverse search*, ketik sebagian command lama, shell bakal nemuin otomatis. Ini penghemat waktu paling underrated.
- **Tab** → auto-complete nama command/file/folder. Tekan 2x kalo ada banyak kemungkinan buat liat semua opsinya.
- **`clear`** (atau `Ctrl+L`) → bersihin layar (bukan hapus history, cuma visual doang).
- **`Ctrl+C`** → hentiin/interrupt program yang lagi jalan (detail sinyalnya di Bab 4).
- **`Ctrl+A` / `Ctrl+E`** → loncat ke awal/akhir baris yang lagi diketik.
- **`Ctrl+U`** → hapus semua teks dari kursor ke awal baris.

### 1.7 Minta Bantuan: `man`

Lupa cara pake suatu command? Jangan buru-buru buka Google — coba dulu:

```bash
man ls
```

Ini bakal buka manual resmi command `ls`, ditampilin lewat *pager* (program yang nampilin teks selayar-selayar). Navigasinya:
- `Space` / `f` → scroll ke bawah satu layar
- `b` → scroll ke atas satu layar
- `/kata_kunci` → cari kata dalam manual, `n` buat lompat ke hasil berikutnya
- `q` → keluar

Kalo command-nya adalah *shell builtin* (bagian dari shell itu sendiri, bukan program terpisah, misal `cd`), `man` kadang gak nemu apa-apa — coba `help cd` sebagai gantinya.

### ⚠️ Kesalahan Umum di Bab Ini

- Nge-*run* command dengan asumsi dia "program eksternal", padahal dia builtin shell (atau sebaliknya) — kalo bingung, `type nama_command` bakal kasih tau statusnya.
- Lupa `export` variabel terus bingung kenapa program anak gak bisa baca variabelnya.
- Ketinggalan quote pas variabel isinya ada spasi (bug klasik banget di bash script).

### 📚 Referensi Tambahan Bab 1
- Bab "What Is the Shell?" & "Navigation" — buku gratis *The Linux Command Line* (William Shotts): https://linuxcommand.org/tlcl.php
- `man bash` di terminal lo sendiri — ini dokumentasi paling lengkap soal bash, walau padat.

---

## 📁 Bab 2: Filesystem

Ini bab terpanjang di video (~31 menit) karena emang di sinilah lo bakal ngabisin 80% waktu interaksi sehari-hari sama Linux: navigasi, baca, dan ngatur file.

### 2.1 Mental Model: Semua Itu Pohon

Di Linux, **semua** data — file dan folder — disusun dalam satu struktur pohon (*tree*) yang mulai dari satu titik tunggal: **root directory**, ditulis `/`. Beda sama Windows yang punya banyak "akar" (`C:\`, `D:\`, dst), di Linux cuma ada **satu** pohon. Drive/partisi lain di-*mount* (ditempelin) jadi folder di dalam pohon itu, bukan jadi akar baru.

- **Directory** (folder) = wadah yang isinya file dan/atau directory lain.
- **File** = kumpulan byte mentah. Isinya bisa apa aja — teks, gambar, program — semuanya cuma 1 dan 0 yang diinterpretasi beda-beda tergantung programnya.

### 2.2 Absolute Path vs Relative Path

Ini konsep yang **wajib** klik di kepala lo sebelum lanjut, karena semua command lain bakal pake ini.

- **Absolute path** — dimulai dari root `/`, jadi selalu nunjuk ke lokasi yang **sama persis** gak peduli lo lagi ada di folder mana. Contoh: `/home/darrell/scripts/backup.sh`
- **Relative path** — dihitung dari **posisi lo sekarang** (working directory). Contoh: kalo lo lagi di `/home/darrell`, maka `scripts/backup.sh` (relative) nunjuk ke tempat yang sama kayak absolute path di atas.

Alias/shortcut yang wajib dihafal:
| Simbol | Arti |
|---|---|
| `~` | Home directory lo (`/home/darrell`) |
| `.` | Directory saat ini |
| `..` | Directory **satu tingkat di atas** (parent) |
| `-` | (khusus `cd -`) directory sebelumnya |

### 2.3 Navigasi Dasar

```bash
pwd          # Print Working Directory — nunjukin lo lagi ada di mana
ls           # List — isi directory saat ini
ls -l        # long format: permission, owner, size, tanggal modif
ls -a        # all: termasuk file/folder tersembunyi (diawali titik, misal .bashrc)
ls -h        # human-readable size (KB/MB/GB, bukan raw bytes) — biasa digabung: ls -lh
ls -R        # Recursive: tampilin isi sub-folder juga
cd /path/ke/folder     # pindah directory (absolute atau relative)
cd ~         # pulang ke home
cd ..        # naik satu tingkat
cd -         # balik ke directory sebelumnya
```

**Kenapa `ls -l` penting banget**: setiap baris hasilnya itu nunjukin permission (yang bakal dibahas detail di Bab 3), jadi biasain baca output ini dari sekarang.

### 2.4 Baca Isi File

```bash
cat namafile.txt        # tampilin SELURUH isi file sekaligus (concatenate)
head namafile.txt        # 10 baris PERTAMA
head -n 20 namafile.txt  # 20 baris pertama
tail namafile.txt        # 10 baris TERAKHIR
tail -n 20 namafile.txt  # 20 baris terakhir
tail -f logfile.log       # "follow" — ikutin log yang terus nambah real-time (WAJIB tau ini buat sysadmin, biasa dipake mantengin log server)
less namafile.txt         # buka file sebagai pager (kayak man), scroll pelan-pelan
```

`cat` bagus buat file pendek, tapi kalo filenya panjang (misal log ribuan baris), layar lo bakal banjir teks. Di situasinya `less` jauh lebih enak karena lo kontrol scroll-nya sendiri (`Space`, `b`, `/cari`, `q` — sama kayak navigasi `man`).

`tail -f` ini bakal sering banget lo pake nanti pas jadi sysadmin — misal mantengin `/var/log/auth.log` buat liat percobaan login yang masuk secara real-time.

### 2.5 Bikin, Pindah, Copy, Hapus

```bash
touch file_baru.txt          # bikin file kosong (atau update timestamp kalo udah ada)
mkdir folder_baru             # bikin folder
mkdir -p a/b/c                 # bikin folder bersarang sekaligus (a, lalu a/b, lalu a/b/c) — tanpa -p bakal error kalo parent-nya belum ada

mv sumber.txt tujuan.txt       # rename (kalo tujuannya di folder yang sama)
mv sumber.txt folder_lain/     # pindahin file ke folder lain

cp sumber.txt salinan.txt      # copy file
cp -r folder_sumber folder_tujuan   # copy folder (WAJIB pake -r / --recursive, kalo enggak bakal error)

rm namafile.txt                # hapus file
rm -r nama_folder               # hapus folder beserta isinya (recursive)
rm -rf nama_folder               # sama kayak di atas, TAPI -f (force) gak akan nanya konfirmasi & gak akan error walau file gak ada
```

> ⚠️ **PERINGATAN SERIUS soal `rm -rf`**: Linux **tidak** punya recycle bin. Sekali `rm`, file itu ilang, titik. Kombinasi `rm -rf` itu paling sering jadi cerita horor sysadmin (`rm -rf /` yang gak sengaja ngehapus seluruh sistem). Kalo lo baru belajar, **biasain jalanin `ls` dulu di target sebelum `rm`**, dan hindari `rm -rf` sampe lo bener-bener yakin sama apa yang lo hapus. Kalo mau lebih aman, coba `rm -i` (interaktif, nanya konfirmasi tiap file).

### 2.6 `grep` — Cari Teks di Dalam File

`grep` itu salah satu tool paling powerful yang bakal lo pake **seumur hidup** kerja di Linux. Fungsinya: nyari baris yang cocok sama pola tertentu.

```bash
grep "error" logfile.log            # tampilin baris yang mengandung kata "error"
grep -i "error" logfile.log         # case-insensitive (ERROR, Error, error semua ke-match)
grep -n "error" logfile.log         # tampilin juga nomor barisnya
grep -v "debug" logfile.log         # kebalikan — tampilin baris yang TIDAK mengandung "debug"
grep -r "TODO" ./src                 # cari secara recursive di semua file dalam folder ./src
```

`grep` sebenernya support *regular expression* penuh (pola pencarian yang jauh lebih canggih dari sekadar kata), tapi itu topik sendiri yang gede — untuk sekarang, kuasain dulu flag-flag dasar di atas.

### 2.7 `find` — Cari File/Folder Berdasarkan Kriteria

Kalo `grep` nyari **isi** file, `find` nyari **file/foldernya sendiri** berdasarkan nama, tipe, ukuran, dll:

```bash
find . -name "*.sh"           # cari semua file berakhiran .sh, mulai dari folder saat ini
find /var/log -type f          # cari semua yang tipenya FILE (bukan folder) di /var/log
find . -type d                 # cari semua yang tipenya DIRECTORY
find . -name "backup*" -type f
```

Ini connect langsung ke apa yang udah lo pelajarin pas debugging script `find | while read` kemarin — inget kenapa lo harus proses output `find` pake `while read` (bukan `for`) buat handle nama file yang ada spasinya? Nah, materi Bab 2 ini persis yang jadi fondasi kenapa itu masalah bisa muncul: nama file itu bisa punya spasi/karakter aneh, dan `find` + pipe ke command lain harus hati-hati soal itu.

### 2.8 Wildcard / Globbing

Shell bisa nge-expand pola jadi banyak nama file sekaligus, ini disebut *globbing*:

| Pola | Arti |
|---|---|
| `*` | cocok dengan **apa aja**, termasuk kosong |
| `?` | cocok dengan **1 karakter apa aja** |
| `[abc]` | cocok dengan salah satu karakter di dalam kurung |

```bash
ls *.txt        # semua file berakhiran .txt
rm log_202?.txt # log_2021.txt, log_2022.txt, dst (? = 1 karakter)
```

### ⚠️ Kesalahan Umum di Bab Ini

- Lupa `-r` pas `cp` folder → error "omitting directory".
- Ketuker antara *relative* dan *absolute* path, jalanin script dari folder yang salah, error "No such file or directory" padahal file-nya ada (cuma beda folder).
- `rm -rf` tanpa ngecek dulu isi foldernya.
- Nama file yang ada spasinya bikin command dianggep dapet banyak argumen, bukan 1 — makanya biasain quote (`"nama file.txt"`) atau escape spasinya (`nama\ file.txt`).

### 📚 Referensi Tambahan Bab 2
- "Linux Filesystem Commands Every Beginner Should Know" — Boot.dev Blog: https://www.boot.dev/blog/devops/linux-filesystem-commands
- Bab "Exploring the System" — buku *The Linux Command Line*
- `man find` dan `man grep` — dua manual paling worth-dibaca-full di seluruh Linux, karena kedua tool ini punya jauh lebih banyak opsi dari yang dibahas di sini.

---

## 🔐 Bab 3: Permissions (Perizinan)

Ini bab yang sering bikin orang bingung pas pertama kali ketemu `Permission denied`, padahal konsepnya sebenernya cukup rapi begitu lo paham mental model-nya. Ini juga salah satu bab paling penting buat lo karena karier sysadmin/network engineer itu 24/7 bersinggungan sama "siapa boleh akses/ubah apa".

### 3.1 Kenapa Permission Ada

Linux dirancang dari awal sebagai sistem **multi-user** — banyak orang (atau proses) bisa jalan di mesin yang sama, dan sistem harus bisa ngatur siapa boleh baca/ubah/jalanin apa. Bahkan kalo laptop lo cuma dipake sendiri, di baliknya tetep ada banyak "user" sistem yang jalan (misal proses buat networking, printer, dll), makanya konsep ini tetep relevan walau lo user tunggal.

### 3.2 Baca Output `ls -l`

Coba jalanin `ls -l` dan perhatiin kolom paling kiri:

```
-rwxr-xr-x 1 darrell darrell 4096 Jul 10 09:30 deploy.sh
drwxr-x--- 2 darrell staff   4096 Jul 10 09:30 secrets/
```

Pecah karakter pertamanya:

```
- rwx r-x r-x
│ │   │   └── Others: read + execute
│ │   └────── Group: read + execute
│ └────────── Owner: read + write + execute
└──────────── Tipe: - = file biasa, d = directory, l = symlink
```

Jadi tiap file/folder punya **3 kelompok** izin: **owner** (pemilik file), **group** (grup yang ditempelin ke file), dan **others** (semua orang lain). Tiap kelompok punya sampe 3 hak: **r**ead, **w**rite, **x**ecute.

Arti r/w/x beda dikit antara file dan directory — ini yang sering kelewat:

| Hak | Di FILE | Di DIRECTORY |
|---|---|---|
| `r` | Bisa baca isi file | Bisa `ls` isi folder |
| `w` | Bisa ubah/timpa isi file | Bisa bikin/hapus/rename file DI DALAM folder |
| `x` | Bisa **jalanin** file sebagai program | Bisa **masuk** (`cd`) ke folder itu / akses file di dalamnya by name |

Poin yang sering bikin bingung: directory butuh **`x`** biar bisa di-`cd`-in, BUKAN `r`. Kalo folder cuma punya `r` tanpa `x`, lo bisa liat nama-nama filenya tapi gak bisa masuk/akses isinya sama sekali.

### 3.3 Mengubah Izin: `chmod` Mode Simbolik

```bash
chmod u+x script.sh        # tambahin execute buat owner (user)
chmod g-w file.txt          # hapus write dari group
chmod o=r README.md         # SET others jadi read-only persis (bukan tambah/kurang, tapi set ulang)
chmod a+r public.html       # tambahin read buat semua (a = all = u+g+o)
chmod -R 755 folder/         # -R = recursive, terapin ke semua isi folder juga
```

Yang perlu diinget: `u`/`g`/`o`/`a` itu **siapa**, `+`/`-`/`=` itu **aksinya** (tambah/kurang/set-persis), dan `r`/`w`/`x` itu **hak apa**.

### 3.4 Mengubah Izin: `chmod` Mode Oktal (Angka)

Ini yang paling sering lo liat di tutorial/script (`chmod 755`, `chmod 644`) — dan ini juga yang paling powerful begitu lo hafal logikanya.

Tiap hak punya nilai:

| Hak | Nilai |
|---|---|
| `r` | 4 |
| `w` | 2 |
| `x` | 1 |
| (gak ada) | 0 |

Tinggal jumlahin nilai yang mau di-*enable* per kelompok:

| Kombinasi | Hitungan | Digit |
|---|---|---|
| `rwx` | 4+2+1 | **7** |
| `rw-` | 4+2+0 | **6** |
| `r-x` | 4+0+1 | **5** |
| `r--` | 4+0+0 | **4** |
| `---` | 0+0+0 | **0** |

Jadi angka 3 digit itu = owner, group, others, berurutan. Contoh yang paling umum:

```bash
chmod 755 script.sh   # rwxr-xr-x → owner full akses, yang lain cuma baca+jalanin
chmod 644 data.txt     # rw-r--r-- → owner baca-tulis, yang lain baca doang
chmod 600 kunci.pem    # rw------- → CUMA owner yang bisa akses sama sekali (umum buat file rahasia/kunci SSH)
```

> 💡 Kalo script bash lo kena error `Permission denied` pas dijalanin `./script.sh`, 90% kasusnya karena lupa `chmod +x script.sh`. Ini kesalahan #1 pemula yang paling sering ketemu.

### 3.5 Ganti Kepemilikan: `chown` & `chgrp`

`chmod` ngubah **hak akses**, `chown` ngubah **siapa pemiliknya**:

```bash
chown darrell file.txt          # ganti owner jadi darrell
chown darrell:staff file.txt    # ganti owner JADI darrell DAN group jadi staff sekaligus
chown :staff file.txt           # ganti group doang (sama efeknya kayak chgrp staff file.txt)
chgrp staff file.txt            # ganti group doang (command khusus)
```

### 3.6 `root` & `sudo`

**`root`** adalah user dengan akses **tak terbatas** ke seluruh sistem — bisa baca/ubah/hapus apa aja, termasuk file punya user lain, termasuk file sistem inti. Karena powernya segede itu, jarang banget kita login LANGSUNG sebagai root sehari-hari (kalo salah ketik command dikit aja, efeknya bisa fatal).

**`sudo`** ("**s**uper **u**ser **do**") adalah cara buat jalanin **satu command doang** sebagai root, tanpa perlu login penuh sebagai root:

```bash
sudo apt install neovim     # install software system-wide (butuh akses root)
sudo chown root:root file    # ganti owner jadi root (cuma root yang boleh)
```

**Kapan butuh `sudo`, kapan enggak?** Aturan sederhananya:
- File/folder itu **punya lo sendiri** → lo bisa `chmod`/edit/hapus tanpa `sudo` sama sekali.
- File/folder itu **punya user lain** (termasuk root/sistem) → butuh `sudo`.
- Install package system-wide (`apt install`) → hampir selalu butuh `sudo` karena nulis ke folder sistem.

Kalo command biasa (tanpa `sudo`) udah jalan lancar, **jangan** tambahin `sudo` "buat jaga-jaga" — itu praktik yang gak sehat karena ngebiasain jalanin hal-hal dengan power lebih dari yang dibutuhkan, dan kalo ada typo di command-nya, dampaknya bisa lebih parah.

### 3.7 Bonus Lanjutan (opsional, buat nanti kalo udah nyaman sama dasar-dasarnya)

- **`umask`** — nilai yang nentuin izin default file/folder BARU yang lo bikin (default file biasanya 644, folder 755, dikurangin sesuai umask).
- **setuid/setgid/sticky bit** — izin spesial tambahan. Contoh paling terkenal: command `passwd` punya setuid supaya user biasa bisa ganti password sendiri walau file `/etc/shadow` sebenarnya cuma bisa ditulis root.
- **ACL (Access Control List)** — kalo model owner/group/others kerasa kurang fleksibel (misal butuh kasih akses ke 1 user spesifik doang tanpa ganti grup), ada `setfacl`/`getfacl` buat kontrol lebih detail.

Ini gak wajib dikuasain sekarang, tapi worth tau **istilahnya doang dulu** biar kalo ketemu di dokumentasi/kerjaan nanti gak asing.

### ⚠️ Kesalahan Umum di Bab Ini

- `chmod 777` ke sembarang file — ini ngasih akses TULIS ke **siapa aja** yang bisa login/akses sistem itu, termasuk potensi attacker. Jangan pernah jadiin `777` sebagai "solusi cepet" buat masalah permission denied.
- Lupa `-R` pas mau ubah permission seluruh isi folder.
- Ketuker `chmod` (izin) sama `chown` (kepemilikan) — dua hal beda yang sering ketuker karena sama-sama diawali "ch".
- Pake `sudo` buat semua hal padahal gak perlu.

### 📚 Referensi Tambahan Bab 3
- "Linux File Permissions Explained: chmod, chown, and sudo" — Boot.dev Blog: https://www.boot.dev/blog/devops/linux-file-permissions
- `man chmod`, `man chown` — detail lengkap semua opsi yang gak sempet dibahas di sini.

---

## ⚙️ Bab 4: Programs (Menjalankan & Mengelola Program)

Bab ini kebagi 2 topik besar: (A) gimana program dijalanin dari command line, dan (B) gimana ngatur program yang **lagi** jalan. Bagian A ini fondasi yang langsung nyambung ke bash scripting yang lo lagi geluti — shebang line yang lo tulis di baris pertama tiap script itu, sumbernya persis dari sini.

### 4A. Menjalankan Program

#### 4.1 Compiled vs Interpreted

Ada dua jenis program dilihat dari cara dia dijalanin:

- **Compiled program** — source code diterjemahin dulu jadi *machine code* (bahasa mentah yang CPU ngerti langsung), baru bisa dijalanin. Bahasa kayak Go, C, Rust kerja gini. Hasil compile-nya adalah file binary yang kalo lo `cat` isinya bakal keliatan kayak sampah karakter aneh (karena memang bukan teks, itu instruksi mesin mentah).
- **Interpreted program** — source code-nya **tetap teks biasa**, dan dijalanin oleh program lain (interpreter) yang baca dan eksekusi baris demi baris. Python, Ruby, JavaScript, dan **shell script (`.sh`)** semuanya interpreted. Makanya kalo lo `cat script.sh`, lo bisa baca isinya — karena memang cuma teks yang nanti "dibacain" sama program `bash`.

#### 4.2 Menjalankan File yang Executable

Kalo suatu file punya izin execute (`x`) — inget Bab 3 — lo bisa jalanin dia dengan nulis path-nya:

```bash
/home/darrell/scripts/backup.sh
./backup.sh      # kalo lo lagi ADA di folder yang sama (relative path)
```

Kenapa harus pake `./` kalo file-nya ada di folder saat ini? Karena demi keamanan, folder saat ini (`.`) **sengaja tidak** dimasukin ke `PATH` secara default (nanti dijelasin apa itu PATH). Jadi shell gak otomatis nyari command di folder saat ini kecuali lo eksplisit bilang "ini di folder saat ini" pake `./`.

#### 4.3 Shebang — Baris Sakti di Awal Script

Ini yang bakal lo liat di **setiap** bash script yang lo tulis:

```bash
#!/bin/bash
```

Baris ini disebut **shebang** (dari "hash-bang", `#!`). Fungsinya: kasih tau sistem **interpreter mana** yang harus dipake buat ngejalanin file ini. Tanpa shebang, sistem gak tau file `.sh` itu harus "dibacain" pake `bash`, `sh`, `zsh`, atau yang lain.

Contoh lain:
```bash
#!/usr/bin/env python3
#!/usr/bin/env node
```

Perhatiin pola `#!/usr/bin/env NAMA_PROGRAM` — ini dipake supaya script-nya **portable**. Bedanya sama nulis langsung `#!/usr/bin/python3`:
- `#!/usr/bin/python3` → hardcode lokasi persis, kalo di sistem lain python3-nya ada di lokasi beda, script langsung gagal.
- `#!/usr/bin/env python3` → `env` bakal nyari `python3` lewat `PATH` milik user yang jalanin, jadi lebih fleksibel lintas sistem/virtual environment.

Untuk `bash` sendiri, karena hampir selalu ada di lokasi yang sama (`/bin/bash`) di semua sistem Linux, banyak yang tetep pake `#!/bin/bash` langsung (bukan lewat `env`) karena sedikit lebih aman dari isu "PATH hijacking" (kalo ada yang taro program jahat bernama `bash` di folder yang kebetulan lebih dulu di PATH lo).

#### 4.4 `PATH` — Kenapa "Command Not Found" Muncul

`PATH` adalah environment variable (inget Bab 1) yang isinya **daftar folder**, dipisah tanda titik dua (`:`), yang bakal dicek shell **secara berurutan** setiap kali lo ngetik nama command:

```bash
echo $PATH
# /usr/local/bin:/usr/bin:/bin:/home/darrell/.local/bin
```

Waktu lo ngetik `bash namafile`, shell bakal nyari file `bash` di tiap folder itu **satu-satu dari kiri ke kanan**, dan make yang PERTAMA ketemu. Kalo gak ketemu di folder mana pun → `command not found`.

Ini juga jawaban kenapa kadang lo install sesuatu tapi command-nya "gak kedetect": program itu ke-install di folder yang **gak ada** di `PATH` lo.

Cara ngecek folder mana yang lagi dipake buat command tertentu:
```bash
which python3
# /usr/bin/python3
```

Cara nambahin folder baru ke `PATH` (sementara, cuma berlaku di sesi terminal itu):
```bash
export PATH="$PATH:/folder/baru/gua"
```

Perhatiin `$PATH` di awal — itu penting banget, itu artinya "PATH yang lama, PLUS folder baru". Kalo lo lupa nulis `$PATH` di situ, lo bakal **nimpa habis** seluruh PATH lama, dan tiba-tiba semua command basic (`ls`, `cd`, dll) ilang dari jangkauan shell sampe lo buka terminal baru.

Supaya perubahan ini **permanen** (gak ilang tiap buka terminal baru), baris `export PATH=...` itu ditaro di file konfigurasi shell (`~/.bashrc` buat bash) — ini topik shell config yang bisa lo eksplor lebih lanjut kalo mau setup environment development lo sendiri.

### 4B. Mengelola Proses yang Berjalan

#### 4.5 Apa Itu Proses?

Setiap kali program dijalanin, sistem operasi kasih dia identitas unik disebut **PID** (Process ID). Lo bisa liat semua proses yang lagi jalan pake:

```bash
ps aux
```

`a` = tampilin punya semua user, `u` = format detail (user, %CPU, %MEM), `x` = termasuk proses yang gak nempel ke terminal.

#### 4.6 Foreground vs Background

Normalnya, waktu lo jalanin command, shell **nunggu** sampe command itu selesai baru ngasih prompt lagi — ini disebut proses **foreground**, dan dia "nyekel" terminal lo.

Kalo lo mau proses itu jalan **tanpa** ngeblok terminal, tambahin `&` di akhir:

```bash
./long_running_script.sh &
# [1] 12345   <- job number & PID langsung ditampilin
```

Sekarang lo bisa lanjut ngetik command lain sambil script itu tetep jalan di belakang.

Kalo lo udah kadung jalanin sesuatu **tanpa** `&` dan baru sadar mau dijadiin background:
1. Tekan **`Ctrl+Z`** → ini nge-*suspend* (pause) proses itu, bukan ngehentiin.
2. Ketik `bg` → lanjutin proses yang tadi di-suspend, tapi sekarang jalan di background.

Command buat ngatur proses-proses ini:
```bash
jobs        # liat daftar job yang lagi jalan/suspended di sesi terminal ini
fg %1        # bawa job nomor 1 balik ke foreground
bg %1        # lanjutin job nomor 1 di background
```

#### 4.7 Menghentikan Proses: Sinyal

`Ctrl+C` dan `Ctrl+Z` itu sebenernya cara terminal ngirim **sinyal** ke proses:

| Shortcut/Command | Sinyal | Efek |
|---|---|---|
| `Ctrl+C` | `SIGINT` | Minta proses berhenti (proses BOLEH nolak/handle sendiri) |
| `Ctrl+Z` | `SIGTSTP` | Pause/suspend proses (bukan hentiin) |
| `kill PID` | `SIGTERM` (default) | Minta proses berhenti dengan sopan (dikasih kesempatan beres-beres dulu) |
| `kill -9 PID` | `SIGKILL` | **Paksa** hentiin proses, gak bisa ditolak/diabaikan sama sekali |

Urutan yang disaranin kalo mau hentiin proses yang bandel: coba `Ctrl+C`/`kill` biasa dulu (kasih kesempatan proses beres-beres), dan `kill -9` cuma dipake sebagai **opsi terakhir** kalo proses itu bener-bener gak merespon, karena `SIGKILL` gak ngasih proses itu kesempatan nutup file/koneksi dengan bersih.

> 💡 **Koneksi ke script backup router SSH yang lo bikin kemarin**: kalo lo mau script kayak gitu jalan lama di background dan gak mati pas lo nutup terminal/SSH session, ini nyambung ke konsep `nohup` dan `disown` — dua command yang bikin proses "kebal" dari sinyal `SIGHUP` (sinyal yang otomatis dikirim ke semua proses anak pas terminal/koneksi SSH ditutup). Worth dieksplor lebih lanjut kalo lo mulai bikin script automasi yang harus jalan lama tanpa lo pantengin terus.

### ⚠️ Kesalahan Umum di Bab Ini

- Lupa `chmod +x` sebelum nyoba jalanin `./script.sh`.
- Salah nulis `export PATH=/folder/baru` (nimpa habis PATH lama) padahal maksudnya `export PATH="$PATH:/folder/baru"`.
- Panik pake `kill -9` buat semua kasus, padahal `kill` biasa (SIGTERM) itu pilihan lebih sopan buat dicoba duluan.
- Nutup terminal pas ada script penting lagi jalan di background tanpa `nohup`, terus kaget kenapa prosesnya ikut mati.

### 📚 Referensi Tambahan Bab 4
- "The PATH Environment Variable in Linux, Explained" — Boot.dev Blog: https://www.boot.dev/blog/devops/linux-path-variable
- `man signal` — daftar lengkap semua sinyal Unix beserta nomornya.
- `man ps` — `ps` punya BANYAK banget opsi/kolom yang gak sempet dibahas di sini.

---

## 🔀 Bab 5: Input/Output (Redirection & Pipes)

Ini bab **paling penting** dari seluruh video buat lo secara spesifik, karena ini fondasi dari HAMPIR SEMUA bash script yang bakal lo tulis buat kompetisi maupun kerjaan sysadmin nanti. Video ngasih porsi 40 menit ke bab ini — paling panjang kedua setelah Filesystem — dan itu masuk akal karena konsepnya emang padat.

### 5.1 Mental Model: 3 "Pipa" Bawaan Tiap Program

Anggep tiap kali lo jalanin program, dia otomatis dikasih **3 saluran data** yang nempel ke terminal lo:

```
                ┌─────────────┐
  keyboard ───► │             │ ───► layar (normal output)
   (stdin)      │   PROGRAM   │        (stdout)
                │             │ ───► layar (pesan error)
                └─────────────┘        (stderr)
```

| Nama | Nomor (file descriptor) | Fungsi | Default |
|---|---|---|---|
| **stdin** (standard input) | `0` | Tempat program **baca** input | Keyboard |
| **stdout** (standard output) | `1` | Tempat program nulis output **normal** | Layar terminal |
| **stderr** (standard error) | `2` | Tempat program nulis **pesan error** | Layar terminal |

Nomor 0/1/2 itu bukan asal — itu standar POSIX yang dipake semua Unix-like OS, dan bakal muncul lagi pas lo pake operator redirect (`2>` misalnya, angka 2 di situ ya literally merujuk ke stderr).

**Kenapa stdout dan stderr dipisah**, padahal keduanya sama-sama nongol di layar? Karena kalo digabung, lo gak bisa milih mau nyimpen yang mana. Coba bayangin script yang jalan tanpa pengawasan (misal cron job tengah malam) — lo pengen semua ERROR ke-log ke file supaya bisa dicek besok, tapi output normalnya gak perlu disimpen. Itu cuma mungkin kalo dua stream itu terpisah dari awal.

### 5.2 Redirection: Ngalihin Stream ke File

```bash
command > output.txt      # stdout ditulis ke file (TIMPA/overwrite isi lama)
command >> output.txt     # stdout ditambahin ke AKHIR file (append, gak timpa)
command 2> error.txt       # stderr ditulis ke file
command 2>> error.txt      # stderr di-append ke file
command < input.txt        # stdin diambil dari isi file (bukan keyboard)
```

Poin krusial soal `>`: dia **langsung menimpa** file tujuan **sebelum** command-nya bahkan mulai jalan. Jadi hati-hati kalo nulis `cat file.txt > file.txt` — itu bakal ngosongin file-nya duluan sebelum sempet dibaca, hasilnya file kosong!

Menggabungkan stdout DAN stderr ke tempat yang sama:
```bash
command > semua.txt 2>&1     # urutan ini PENTING: redirect stdout dulu ke file, BARU redirect stderr ke "tempat stdout sekarang nunjuk"
command &> semua.txt          # shortcut versi bash buat hal yang sama
```

**Kenapa urutannya penting?** `2>&1` itu artinya "arahin stderr ke tempat stdout LAGI nunjuk SEKARANG (saat baris ini dieksekusi)", bukan "ikutin stdout kemanapun dia pergi nanti". Makanya kalo lo nulis kebalik (`2>&1 > semua.txt`), stderr bakal tetep ke layar dan cuma stdout doang yang ke file — karena pas `2>&1` dieksekusi, stdout MASIH nunjuk ke layar (belum dialihin), jadi stderr ikut nunjuk ke layar juga.

### 5.3 `/dev/null` — Si Tempat Sampah

`/dev/null` itu file spesial yang "makan" apa pun yang ditulis ke dia dan gak nyimpen apa-apa. Berguna kalo lo emang gak butuh output-nya sama sekali:

```bash
command > /dev/null 2>&1     # buang SEMUA output (stdout & stderr), diem total
command 2> /dev/null          # buang error doang, stdout tetep keliatan
```

Pola ini SANGAT umum di script automasi/cron job yang jalan tanpa pengawasan manusia.

### 5.4 `<` vs Argumen File — Ini Beda!

Ini poin halus yang sering ketuker:

```bash
wc -l input.txt      # wc BUKA SENDIRI file input.txt (dia tau namanya lewat argumen)
wc -l < input.txt     # wc GAK TAU ada file bernama input.txt — dia cuma nerima ISI-nya doang lewat stdin
```

Bedanya keliatan pas liat output: cara pertama nampilin nama file di hasilnya, cara kedua enggak (karena `wc` di skenario kedua gak tau nama file sama sekali, cuma terima aliran teks).

### 5.5 Pipe (`|`) — Menyambungkan Program

Ini "lem" yang bikin filosofi Unix ("bikin tool kecil yang masing-masing jago 1 hal, terus sambungin") jadi kenyataan. Pipe ngambil **stdout** program di kiri, dan nyambungin jadi **stdin** program di kanan:

```bash
ls -la | grep ".sh"              # list file, terus filter yang ada ".sh"-nya doang
cat access.log | grep "404" | wc -l    # baca log → filter baris ber-404 → hitung berapa baris
ps aux | grep nginx | grep -v grep      # cari proses nginx (grep -v grep buangin baris grep-nya sendiri dari hasil)
```

**Penting**: pipe **cuma** nyalurin stdout, **bukan** stderr. Jadi kalo command kiri error, pesan errornya tetep nongol langsung ke layar (gak ikut lewat pipe) — ini justru desain yang disengaja, supaya error tetep keliatan walau lo lagi nyalurin output normal ke command lain.

### 5.6 Argumen, Flag, dan Exit Code

**Argumen** adalah data yang lo kasih ke program (`cp SUMBER TUJUAN` — `SUMBER` dan `TUJUAN` itu argumen). **Flag/opsi** adalah cara ngasih instruksi tambahan ke program (`-l`, `--verbose`, dll), biasanya bisa digabung kalo versi pendek (`-la` = `-l` + `-a`).

Yang **paling krusial** buat lo sebagai calon jago bash scripting adalah **exit code**:

```bash
mkdir folder_baru
echo $?      # 0 = SUKSES
mkdir folder_yang_sudah_ada    # (kalo emang udah ada sebelumnya)
echo $?      # non-zero (biasanya 1) = GAGAL
```

Setiap command, begitu selesai jalan, ninggalin **exit code**: `0` selalu berarti sukses, angka apa pun selain `0` berarti ada masalah (macem-macem angkanya tergantung jenis errornya, tapi yang penting: cek `== 0` atau `!= 0`).

Ini fondasi dari HAMPIR SEMUA `if` statement di bash script buat error handling:

```bash
if ssh user@router "show running-config" > backup.txt 2>&1; then
    echo "Backup berhasil"
else
    echo "Backup gagal, exit code: $?"
fi
```

(Familiar? Ini persis pola yang relevan buat script backup config router yang lo kerjain kemarin — `if` di situ sebenernya lagi ngecek exit code dari command SSH-nya.)

### 5.7 Bonus: Here-String & Heredoc

Dua pola redirection lanjutan yang sering muncul di script:

```bash
# Here-string: kasih 1 baris teks langsung sebagai stdin
grep "cari" <<< "ini teks yang mau dicari kata 'cari'"

# Heredoc: kasih BLOK teks multi-baris sebagai stdin, sampe ketemu penanda (EOF)
cat << EOF
Baris pertama
Baris kedua, $NAME juga bisa di-expand di sini
EOF
```

### ⚠️ Kesalahan Umum di Bab Ini

- Lupa urutan `2>&1` harus **setelah** `>file`, bukan sebelum.
- Nulis `cat file > file` (nimpa file yang lagi dibaca sendiri).
- Ngirim command yang butuh **nama file** (bukan stdin) lewat pipe — misal `echo "/var/log" | ls` itu SALAH karena `ls` gak baca stdin sama sekali, dia butuh argumen. Solusinya pake `xargs`: `echo "/var/log" | xargs ls`.
- Lupa ngecek exit code (`$?`) di script, jadinya script "keliatan jalan" padahal command di dalemnya diem-diem gagal.

### 📚 Referensi Tambahan Bab 5
- "Stdin, Stdout, and Stderr: Linux I/O Streams Explained" — Boot.dev Blog: https://www.boot.dev/blog/devops/stdin-stdout-stderr
- Bab "I/O Redirection" — buku *The Linux Command Line* (bagian ini termasuk salah satu bab terbaik di buku itu)
- `man bash`, cari section "REDIRECTION" — referensi lengkap semua operator redirect yang ada.

---

## 📦 Bab 6: Packages (Package Manager)

Bab penutup video, relatif lebih ringan — tapi tetep penting karena "install software" itu salah satu hal pertama yang bakal lo lakuin di sistem manapun.

### 6.1 Kenapa Butuh Package Manager

Bayangin kalo install software harus manual: download source code, compile sendiri, cari & install semua dependency-nya satu-satu, terus kalo mau uninstall harus inget file apa aja yang ke-copy kemana. Ribet dan gampang berantakan.

**Package manager** ngurusin semua itu otomatis: nyari software yang lo minta, install dependency yang dia butuhin, nyimpen catatan file apa aja yang ke-install biar bisa di-uninstall bersih, dan biasanya juga urus update version.

### 6.2 `apt` (Debian/Ubuntu)

Ini package manager bawaan distro berbasis Debian (termasuk Ubuntu — yang paling umum dipake pemula & server). Dua command yang **wajib** dibedain:

```bash
sudo apt update      # update DAFTAR/KATALOG package yang tersedia (belum install apa-apa!)
sudo apt upgrade      # upgrade package yang UDAH ke-install ke versi terbaru
sudo apt install neovim    # install package baru
sudo apt remove neovim      # uninstall (tapi file config-nya kadang masih nyisa)
sudo apt purge neovim        # uninstall LEBIH bersih, termasuk file config
apt search neovim              # cari package (gak butuh sudo, cuma nyari doang)
```

**Kesalahan pemula paling umum**: jalanin `apt install` doang tanpa `apt update` dulu, sehingga sistem masih pake catalog lama dan bisa gagal nemuin package/versi yang lo mau. Biasain selalu `sudo apt update` dulu sebelum install apapun.

Kenapa hampir semua command `apt` butuh `sudo`? Karena dia nulis ke folder-folder sistem (`/usr`, `/etc`, dll) yang cuma root yang boleh ubah — ini nyambung langsung ke konsep Permission di Bab 3.

Di baliknya, `apt` sebenernya "wrapper" yang lebih ramah dari tool level-lebih-rendah bernama `dpkg` (yang ngurus file `.deb` individual) — gak wajib dikuasain sekarang, tapi worth tau nama itu ada.

### 6.3 Homebrew (`brew`)

Awalnya buat macOS, tapi sekarang jalan juga di Linux. Bedanya sama `apt`: Homebrew install semua package ke folder **milik user sendiri** (bukan folder sistem), jadi biasanya **gak butuh `sudo`** sama sekali:

```bash
brew install htop
brew uninstall htop
brew search htop
brew list                 # semua package yang ke-install
brew upgrade                # upgrade semua package
```

Ini enak buat dev tools yang pengen lo kontrol sendiri versinya tanpa nyampur ke package sistem.

### 6.4 Webi

Ini pendekatan yang lain lagi: gak ada "program webi" yang perlu di-install duluan. Lo langsung jalanin 1 command (biasanya `curl ... | bash`) yang didapet dari situs webinstall.dev, dan itu bakal download+install tool yang lo mau langsung dari sumbernya.

> ⚠️ **Catatan keamanan**: pola "download script dari internet terus langsung `| bash`" itu SECARA UMUM berisiko (lo ngejalanin kode dari internet tanpa baca dulu). Tapi kalo itu dilakuin lewat **HTTPS** dan dari sumber yang lo **percaya** (situs resmi tool-nya, bukan link random), risikonya jauh lebih kecil. Tetep, kalo lo lagi belajar, gak ada salahnya buka dulu URL script-nya di browser buat liat isinya sebelum di-pipe ke bash.

### 6.5 Kapan Pake yang Mana

| Situasi | Pilihan |
|---|---|
| Software sistem inti / butuh integrasi dalam ke OS | `apt` (perlu `sudo`) |
| Dev tools yang lo mau kontrol versi sendiri, gak mau ganggu sistem | `brew` |
| Tool spesifik yang cuma ada instalasi resmi via webi | Webi |

### ⚠️ Kesalahan Umum di Bab Ini

- Install (`apt install`) tanpa `apt update` duluan.
- Lupa `sudo` di depan command `apt` (walau errornya biasanya jelas: "permission denied" / minta jalanin sebagai root).
- `| bash` dari sumber yang gak jelas asal-usulnya.

### 📚 Referensi Tambahan Bab 6
- Boot.dev Blog soal package manager (apt & brew): https://www.boot.dev/blog
- Situs resmi Homebrew: https://brew.sh/
- Situs resmi Webi: https://webinstall.dev/

---

## 🎯 Penutup: Latihan & Sumber Belajar Tambahan

### Kenapa Materi Ini Nyambung Banget ke Roadmap Lo

Linux fundamentals ini literally jadi **fondasi** dari hampir semua yang ada di roadmap belajar lo (networking → bash → Python → Ansible → MySQL). Bash scripting yang lagi lo tekunin sekarang itu **adalah** aplikasi langsung dari Bab 4 (shebang, exit code) dan Bab 5 (redirection, pipe) di atas. Dan pas nanti lo masuk PKL / kerja beneran sebagai sysadmin/network engineer, hampir semua server yang bakal lo pegang itu jalan di atas Linux — jadi materi ini bukan "pengetahuan tambahan", ini **alat kerja harian**.

### Latihan Hands-On yang Disaranin

Baca doang gak akan cukup buat bikin ini "nempel" — otot jari lo juga harus ikut belajar. Dua rekomendasi konkret:

1. **OverTheWire: Bandit** (https://overthewire.org/wargames/bandit/) — ini "wargame" gratis berbasis SSH yang ngajarin command line Linux lewat serangkaian level puzzle (tiap level, lo cari "password" buat masuk ke level berikutnya, dan buat nemuinnya lo harus pake command yang persis lo pelajarin di atas: `ls`, `find`, `grep`, permission, dll). Cocok banget karena **langsung praktek**, bukan cuma baca teori, dan levelnya makin lama makin nantang.
2. **Buat 1 script kecil per bab** — misal setelah baca Bab 5, coba bikin script yang baca log file, filter baris tertentu pake `grep`, terus hitung jumlahnya pake `wc -l`, simpen hasilnya ke file. Latihan kecil kayak gini jauh lebih efektif dari sekadar ngetik ulang contoh di atas.

### Sumber Belajar Tambahan (Kalau Mau Gali Lebih Dalam)

| Sumber | Kenapa Worth Dicek |
|---|---|
| **The Linux Command Line** (William Shotts) — gratis, lisensi Creative Commons: https://linuxcommand.org/tlcl.php | Buku paling lengkap & paling sering direkomendasiin buat belajar CLI dari nol sampe scripting lumayan advance. Bahasa Inggris tapi ditulis santai & jelas. |
| Boot.dev — course interaktif "Learn Linux" (versi lengkap dari video ini): https://www.boot.dev/courses/learn-linux | Kalo lo suka format latihan interaktif (bukan cuma baca), course aslinya ada exercise yang dinilai otomatis. |
| GNU Coreutils Manual: https://www.gnu.org/software/coreutils/manual/ | Dokumentasi RESMI buat command dasar (`ls`, `cp`, `mv`, dll) — bagus buat ngecek detail opsi yang gak sempet dibahas di sini. |
| `man` page command apa pun di terminal lo sendiri | Selalu ada, selalu akurat buat versi command yang lo pake persis. Biasain jadiin refleks pertama sebelum googling. |

### Rangkuman Jadwal 7 Hari (recap)

| Hari | Bab |
|---|---|
| 1 | Terminal & Shell |
| 2 | Filesystem |
| 3 | Permissions |
| 4 | Programs (PATH & Proses) |
| 5 | Input/Output |
| 6 | Packages + mulai latihan gabungan |
| 7 | Review total + OverTheWire Bandit level-level awal |

Semangat, Darrell. Kalo pas praktek ketemu error yang bikin bingung atau ada bagian yang masih ngambang, tinggal balik lagi ke sini — gua bisa bantu bedah lebih detail bagian mana pun.
