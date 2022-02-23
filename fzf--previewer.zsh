#!/usr/bin/env zsh

FILE_PATH=$1

bat=`/usr/bin/which bat || echo batcat`

if [ -d "$1" ]; then
	tree --du -C -L 2 "$FILE_PATH"
elif ! [ -f "$1" ]; then
    echo $1 | read -A tokens
    for token in $tokens; do
        if [ -f $token ]; then
            $bat --style=numbers --color=always --line-range :222 $token
        fi
    done
else
	FILE_MIME=$(file --mime "$FILE_PATH")
    filename=$(basename -- "$FILE_PATH")
    FILE_EXT="${filename##*.}"

    case $FILE_EXT in
        # This is copyed from my ~/.config/ranger/scope.sh
        # Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|rar)
            atool --list -- "${FILE_PATH}" && exit 0
            exit 1;;
        7z)
            # Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 0
            exit 1;;

        # PDF
        pdf)
            # Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w ${PV_WIDTH} && exit 0
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w ${PV_WIDTH} && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 1;;


        # OpenDocument
        odt|ods|odp|sxw)
            # Preview as text conversion
            odt2txt "${FILE_PATH}" && exit 0
            exit 1;;

        doc)
            # Preview as text conversion
            catdoc "${FILE_PATH}" && exit 0
            exit 1;;
        docx)
            # Preview as text conversion
            docx2txt "${FILE_PATH}" - && exit 0
            exit 1;;

        # HTML
        htm|html|xhtml)
            # Preview as text conversion
            w3m -dump "${FILE_PATH}" && exit 0
            lynx -dump -- "${FILE_PATH}" && exit 0
            elinks -dump "${FILE_PATH}" && exit 0
            ;; # Continue with next handler on failure

        [jJ][pP][gG]|[jJ][pP][eE][gG]|[gG][iI][fF]|[bB][mM][pP]|webp|[pP][nN][gG]|\
        [tT][iI][fF]|[tT][iI][fF][fF])
            ascii-image-converter --width $[$COLUMNS - 20] --braille --color "${FILE_PATH}" && exit 0
            exit 1;;

        *)
            if [[ $FILE_MIME == *binary ]] ; then
                echo "$FILE_MIME" 
                hexyl -n 4kB "$FILE_PATH" && exit 0
            else
                $bat --style=numbers --color=always --line-range :222 $1 && exit 0
            fi
            exit 1;;
    esac

fi
