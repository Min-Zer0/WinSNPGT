��    j      l  �   �      	  �   	  �   �	  �  �
    �  �   �  �  �  U  t  �  �  �  �  F  +     r     �     �  &   �     �  -        1  !   N     p     �     �  ,   �     �  .   
  '   9  (   a     �  %   �     �     �     �  *   �  �     &   �     �     �     �       $   2     W     i     �  �   �     F     W     `          �  <   �  #   �                7  "   K     n     v  &   �     �     �     �     �       )        ?  �   T     N  ;   e  3   �  /   �  +     '   1  #   Y     }     �     �  \   �     &      (   4   E      z   !   �   -   �   .   �      !     4!     O!     g!     !     �!     �!     �!     �!     �!     �!     "  ,   !"  *   N"     y"     �"     �"     �"     �"     �"  -   �"     #  �  #  �   �$    �%    �&  A  �(    �)  �  �*  x  �,    !.  �  )0  [  $2     �3  +   �3     �3  )   �3  #   
4  ;   .4      j4  *   �4     �4     �4     �4  .   5     35  .   S5  0   �5  /   �5  '   �5  &   6     26     46     86  3   I6  �   }6  2   7     B7  !   Z7      |7     �7      �7     �7     �7     8  �   8     �8     �8     9     !9     <9  E   \9     �9     �9  %   �9     :     ":     @:     L:  ,   g:     �:     �:     �:  #   �:     ;  2   ;     F;  �   \;      Y<  H   z<  <   �<  8    =  4   9=  0   n=  ,   �=  (   �=  $   �=     >  q   5>     �>  %   �>  >   �>  1   ?  (   @?  -   i?  6   �?  "   �?  $   �?     @     3@  !   L@     n@     �@     �@     �@     �@     �@     �@  1   A  )   =A     gA     yA     �A     �A     �A     �A  7   �A     +B                ;       C   .   /   M                     a           T      Z      L   f   =   J          >      G   \       b   _   O          @                 h            ?           %          1   
           +   <      	       !   (           U   d          E   3   j   *   7   6   8          0   Y   i       K      2      9       [   P          ,   c      N       F   R       $           D   "      W       5       &   ]          X      V   4   '   S   #   ^   B                   A       H       -      `       g       I         :       )   Q              e    
Context control:
  -B, --before-context=NUM  print NUM lines of leading context
  -A, --after-context=NUM   print NUM lines of trailing context
  -C, --context=NUM         print NUM lines of output context
 
Miscellaneous:
  -s, --no-messages         suppress error messages
  -v, --invert-match        select non-matching lines
  -V, --version             display version information and exit
      --help                display this help text and exit
 
Output control:
  -m, --max-count=NUM       stop after NUM selected lines
  -b, --byte-offset         print the byte offset with output lines
  -n, --line-number         print line number with output lines
      --line-buffered       flush output on every line
  -H, --with-filename       print file name with output lines
  -h, --no-filename         suppress the file name prefix on output
      --label=LABEL         use LABEL as the standard input file name prefix
       --include=GLOB        search only files that match GLOB (a file pattern)
      --exclude=GLOB        skip files that match GLOB
      --exclude-from=FILE   skip files that match any file pattern from FILE
      --exclude-dir=GLOB    skip directories that match GLOB
   -E, --extended-regexp     PATTERNS are extended regular expressions
  -F, --fixed-strings       PATTERNS are strings
  -G, --basic-regexp        PATTERNS are basic regular expressions
  -P, --perl-regexp         PATTERNS are Perl regular expressions
   -I                        equivalent to --binary-files=without-match
  -d, --directories=ACTION  how to handle directories;
                            ACTION is 'read', 'recurse', or 'skip'
  -D, --devices=ACTION      how to handle devices, FIFOs and sockets;
                            ACTION is 'read' or 'skip'
  -r, --recursive           like --directories=recurse
  -R, --dereference-recursive  likewise, but follow all symlinks
   -L, --files-without-match  print only names of FILEs with no selected lines
  -l, --files-with-matches  print only names of FILEs with selected lines
  -c, --count               print only a count of selected lines per FILE
  -T, --initial-tab         make tabs line up (if needed)
  -Z, --null                print 0 byte after FILE name
   -NUM                      same as --context=NUM
      --group-separator=SEP  print SEP on line between matches with context
      --no-group-separator  do not print separator for matches with context
      --color[=WHEN],
      --colour[=WHEN]       use markers to highlight the matching strings;
                            WHEN is 'always', 'never', or 'auto'
  -U, --binary              do not strip CR characters at EOL (MSDOS/Windows)

   -e, --regexp=PATTERNS     use PATTERNS for matching
  -f, --file=FILE           take PATTERNS from FILE
  -i, --ignore-case         ignore case distinctions in patterns and data
      --no-ignore-case      do not ignore case distinctions (default)
  -w, --word-regexp         match only whole words
  -x, --line-regexp         match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline
   -o, --only-matching       show only nonempty parts of lines that match
  -q, --quiet, --silent     suppress all normal output
      --binary-files=TYPE   assume that binary files are TYPE;
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                equivalent to --binary-files=text
 %s home page: <%s>
 %s: PCRE detected recurse loop %s: binary file matches %s: exceeded PCRE's backtracking limit %s: exceeded PCRE's heap limit %s: exceeded PCRE's nested backtracking limit %s: exhausted PCRE JIT stack %s: input file is also the output %s: internal PCRE error: %d %s: invalid option -- '%c'
 %s: memory exhausted %s: option '%s%s' doesn't allow an argument
 %s: option '%s%s' is ambiguous
 %s: option '%s%s' is ambiguous; possibilities: %s: option '%s%s' requires an argument
 %s: option requires an argument -- '%c'
 %s: unrecognized option '%s%s'
 %s: warning: recursive directory loop ' (C) (standard input) -P supports only unibyte and UTF-8 locales Example: %s -i 'hello world' menu.h main.c
PATTERNS can contain multiple patterns separated by newlines.

Pattern selection and interpretation:
 General help using GNU software: <%s>
 Invalid back reference Invalid character class name Invalid collation character Invalid content of \{\} Invalid preceding regular expression Invalid range end Invalid regular expression JIT internal error: %d License GPLv3+: GNU GPL version 3 or later <%s>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
 Memory exhausted No match No previous regular expression Packaged by %s
 Packaged by %s (%s)
 Perl matching not supported in a --disable-perl-regexp build Premature end of regular expression Regular expression too big Report %s bugs to: %s
 Report bugs to: %s
 Search for PATTERNS in each FILE.
 Success Trailing backslash Try '%s --help' for more information.
 Unknown system error Unmatched ( or \( Unmatched ) or \) Unmatched [, [^, [:, [., or [= Unmatched \{ Usage: %s [OPTION]... PATTERNS [FILE]...
 Valid arguments are: When FILE is '-', read standard input.  With no FILE, read '.' if
recursive, '-' otherwise.  With fewer than two FILEs, assume -h.
Exit status is 0 if any line is selected, 1 otherwise;
if any error occurs and -q is not given, the exit status is 2.
 Written by %s and %s.
 Written by %s, %s, %s,
%s, %s, %s, %s,
%s, %s, and others.
 Written by %s, %s, %s,
%s, %s, %s, %s,
%s, and %s.
 Written by %s, %s, %s,
%s, %s, %s, %s,
and %s.
 Written by %s, %s, %s,
%s, %s, %s, and %s.
 Written by %s, %s, %s,
%s, %s, and %s.
 Written by %s, %s, %s,
%s, and %s.
 Written by %s, %s, %s,
and %s.
 Written by %s, %s, and %s.
 Written by %s.
 Written by Mike Haertel and others; see
<https://git.sv.gnu.org/cgit/grep.git/tree/AUTHORS>. ` ambiguous argument %s for %s character class syntax is [[:space:]], not [:space:] conflicting matchers specified exceeded PCRE's line length limit failed to return to initial working directory failed to set file descriptor text/binary mode input is too large to count invalid argument %s for %s invalid character class invalid content of \{\} invalid context length argument invalid matcher %s invalid max count memory exhausted no syntax specified program error regular expression too big stack overflow the -P option only supports a single pattern unable to record current working directory unbalanced ( unbalanced ) unbalanced [ unfinished \ escape unknown binary-files type unknown devices method warning: --unix-byte-offsets (-u) is obsolete write error Project-Id-Version: grep-3.7.62
Report-Msgid-Bugs-To: bug-grep@gnu.org
PO-Revision-Date: 2022-04-27 15:00+0300
Last-Translator: Emir SARI <emir_sari@icloud.com>
Language-Team: Turkish <gnome-turk@gnome.org>
Language: tr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
X-Generator: KBabel 1.0
 
Bağlam denetimi:
  -B, --before-context=NUM  öncü NUM satır bağlam yazdır
  -A, --after-context=NUM   izleyen NUM satır bağlam yazdır
  -C, --context=NUM         NUM satır çıktı bağlamı yazdır
 
Çeşitli:
  -s, --no-messages         hata iletilerini sustur
  -v, --invert-match        eşleşmeyen satırları seç
  -V, --version             sürüm bilgisini görüntüle ve çık
      --help                bu yardım metnini görüntüle ve çık
 
Çıktı denetimi::
  -m, --max-count=NUM       NUM seçili satırdan sonra dur
  -b, --byte-offset         bayt ofsetini çıktı satırlarıyla yazdır
  -n, --line-number         çıktı satırlarıyla satır numarasını yazdır
      --line-buffered       her satırda çıktıyı boşalt
  -H, --with-filename       çıktı satırlarıyla dosya adını yazdır
  -h, --no-filename         çıktıda dosya adı önekini sustur
      --label=ETİKET        standart çıktı dosya adı önekinde ETİKET kullan
       --include=GLOB        yalnızca GLOB ile eşleşen dosyaları ara (dizgi)
      --exclude=GLOB        GLOB ile eşleşen dosyaları atla
      --exclude-from=DOSYA  DOSYA'dan herhangi bir dizgiyle eşleşen dosyaları
                              atla
      --exclude-dir=GLOB    GLOB ile eşleşen dizinleri atla
   -E, --extended-regexp     DİZGİLER, genişletilmiş düzenli ifadedir
  -F, --fixed-strings       DİZGİLER, dizilerdir
  -G, --basic-regexp        DİZGİLER, yalın düzenli ifadelerdir
  -P, --perl-regexp         DİZGİLER, Perl düzenli ifadeleridir
   -I                        --binary-files=without-match eşdeğeri
  -d, --directories=EYLEM   dizinlerin nasıl işleneceği; EYLEM, 'read',
                            'recurse' veya 'skip'
  -D, --devices=EYLEM       aygıtların, FIFO'ların ve soketlerin nasıl
                              işleneceği; EYLEM, 'read' veya 'skip'
  -r, --recursive           --directories=recurse gibi
  -R, --dereference-recursive  benzer; ancak tüm sembolik bağları izle
   -L, --files-without-match seçili satır olmayan DOSYA'ların adlarını yazdır
  -l, --files-with-matches  seçili satır olan DOSYA'ların adlarını yazdır
  -c, --count               DOSYA başına seçili satır sayısını yazdır
  -T, --initial-tab         sekmelerin hizalanması sağla (gerekirse)
  -Z, --null                DOSYA adından sonra 0 bayt yazdır
   -NUM                      --context=NUM ile aynı
      --group-separator=AYI AYI'yı eşleşme-bağlam arasındaki satıra getir
      --no-group-separator  bağlamlı eşleşmeler için ayırıcı yazdırma
      --color[=NEZAMAN],
      --colour[=NEZAMAN]    eşleşen dizileri vurgulamak için imleyiciler
                              kullan; NEZAMAN, 'always', 'never' veya 'auto'
  -U, --binary              satır sonundayken satır başı karakterlerini soyma
                              (MS-DOS/Windows)

   -e, --regexp=DİZGİLER     eşleştirme için DİZGİLER kullan
  -f, --file=DOSYA          DİZGİLER'i DOSYA'dan al
  -i, --ignore-case         dizgilerde/veride BÜY./küçük harf ayrımını yok say
      --no-ignore-case      BÜYÜK/küçük harf ayrımını yok sayma (öntanımlı)
  -w, --word-regexp         yalnızca tam sözcükleri eşleştir
  -x, --line-regexp         yalnızca tam satırları eşleştir
  -z, --null-data           bir veri satırı yenisatır yerine 0 bayt ile biter
   -o, --only-matching       yalnızca satırların eşli dolu kısımlarını göster
  -q, --quiet, --silent     tüm olağan çıktıyı sustur
      --binary-files=TÜR    ikili dosyaların TÜR olduğunu varsay; TÜR,
                            'binary', 'text' veya 'without-match'
  -a, --text                --binary-files=text eşdeğeri
 %s ana sayfası: <%s>
 %s: PCRE, özyineleme döngüsü algıladı %s: İkili dosya eşleşiyor %s: PCRE'nin geri izleme limiti aşıldı %s: PCRE'nin öbek limiti aşıldı %s: PCRE'nin iç içe geçmiş geri izleme limiti aşıldı %s: PCRE JIT yığını tükendi %s: Girdi dosyası aynı zamanda çıkış %s: İç PCRE hatası: %d %s: Geçersiz seçenek -- '%c'
 %s: Bellek tükendi %s: '%s%s' seçeneği argümana izin vermiyor
 %s: '%s%s' seçeneği belirsiz
 %s: '%s%s' seçeneği belirsiz; olasılıklar: %s: '%s%s' seçeneği bir argüman gerektiriyor
 %s: Seçenek bir argüman gerektiriyor -- '%c'
 %s: '%s%s' seçeneği tanımlanamıyor
 %s: Uyarı: Özyineli dizin döngüsü ' (C) (standart girdi) -P yalnızca unibyte ve UTF-8 yerellerini destekler Örnek: %s -i 'merhaba dünya' menu.h main.c
DİZGİLER, yenisatır ile ayrılan birden çok dizgi içerebilir.

Dizgi seçimi ve yorumlanması:
 GNU yazılımı kullanımı genel yardımı: <%s>
 Geçersiz geri başvuru Geçersiz karakter sınıfı adı Geçersiz birleştirme karakteri Geçersiz \{\} içeriği Önceki düzenli ifade geçersiz Geçersiz erim sonu Geçersiz düzenli ifade JIT iç hatası: %d GPLv3+ lisansı: GNU GPL sürüm 3 veya sonrası <%s>.
Bu özgür yazılımdır; değiştirmekte ve yeniden dağıtmakta özgürsünüz.
Yasaların izin verdiği ölçüde herhangi bir GARANTİ verilmez.
 Bellek tükendi Eşleşme yok Öncesinde düzenli ifade yok %s tarafından paketlendi
 %s tarafından paketlendi (%s)
 Bir --disable-perl-regexp yapısında Perl eşleşmesi desteklenmiyor Düzenli ifade erken sonlandı Düzenli ifade pek büyük %s hatalarını şuraya bildirin: %s
 Hataları şuraya bildirin: %s
 Her DOSYA'da DİZGİLER ara.
 Başarılı İzleyen ters eğik çizgi Daha fazla bilgi için '%s --help' deneyin.
 Bilinmeyen sistem hatası Eşleşmemiş ( veya \( Eşleşmemiş ) veya \) Eşleşmemiş [, [^, [:, [. veya [= Eşleşmemiş \{ Kullanım: %s [SEÇENEK]... DİZGİLER [DOSYA]...
 Geçerli argümanlar: DOSYA '-' iken, standart girdiyi oku. DOSYA olmadan, özyineliyse '.', değilse
'-' oku. İkiden daha az DOSYA ile, -h varsay. Herhangi bir satır seçiliyse
çıkış kodu 0, değilse 1'dir; bir hata oluştur ve -q verilmemişse çıkış
kodu 2'dir.
 %s ve %s tarafından yazıldı.
 %s, %s, %s, %s, %s, %s,
%s, %s, %s ve diğerleri
tarafından yazıldı.
 %s, %s, %s, %s, %s, %s,
%s, %s ve %s tarafından
yazıldı.
 %s, %s, %s, %s,
%s, %s, %s ve %s
tarafından yazıldı.
 %s, %s, %s,
%s, %s, %s ve %s tarafından yazıldı.
 %s, %s, %s,
%s, %s ve %s tarafından yazıldı.
 %s, %s, %s,
%s ve %s tarafından yazıldı.
 %s, %s, %s
ve %s tarafından yazıldı.
 %s, %s ve %s tarafından yazıldı.
 %s tarafından yazıldı.
 Mike Haertel ve diğerleri tarafından yazılmıştır; bkz.
<https://git.sv.gnu.org/cgit/grep.git/tree/AUTHORS>. ` `%2$s' için %1$s argümanı belirsiz karakter sınıfı sözdizimi [[:boşluk:]], [:boşluk] değil birbiriyle çatışan eşleştiriciler belirtildi PCRE's satır uzunluğu limiti aşıldı başlangıç çalışma dizinine dönülemedi dosya tanımlayıcısı metin/ikili kipi ayarlanamadı girdi sayılamayacak kadar büyük %2$s için %1$s argümanı geçersiz geçersiz karakter sınıfı geçersiz \{\} içeriği geçersiz bağlam uzunluk değeri geçersiz eşleştirici %s en çok sayısı geçersiz bellek tükendi sözdizim belirtilmemiş program hatası düzenli ifade pek büyük yığın taşması -P seçeneği yalnızca tek bir dizgiyi destekler geçerli çalışma dizini kaydedilemiyor karşılıksız ( karşılıksız ) karşılıksız [ tamamlanmamış \ kaçışı bilinmeyen ikili dosya türü bilinmeyen aygıt yöntemi uyarı: --unix-byte-offsets (-u) artık kullanılmıyor yazma hatası 