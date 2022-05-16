#!/bin/bash

# Dependencies: https://github.com/ericchiang/pup
#               html2markdown
#               java
#               yettoyes2.jar

# https://www.textusreceptusbibles.com/JPGreen

USER_AGENT='Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0'

URL='https://www.textusreceptusbibles.com/KJV1611/1/1'
NAME='kjv1611'


# --> Download Bible
install -dv 'processing'
pushd 'processing'
for NUM in {0001..1189}; do
  echo -n "Downloading: ${URL}"
  HTML="$(curl -sA "${USER_AGENT}" "${URL}")" || exit 1
  BOOK="$(awk -F'/' '{print $5}' <<<"${URL}")"
  TEXT="$(pup 'tbody' <<<"${HTML}" | sed "/class=\"ref\">/a $BOOK")" || exit 1
  cat <<< "${TEXT}" >> "${NAME}.html"
  URL="https://www.textusreceptusbibles.com$(pup '.navnext attr{href}' <<<"${HTML}")" || exit 1
  echo '   DONE'
done


# --> Process Bible
html2markdown -b0 "${NAME}.html" > "${NAME}.txt"
sed -i 's/[[:blank:]]*$//' "${NAME}.txt"  # Remove trailing whitespace
sed -i 's/  |  /\t/;s/ /\t/;s/:/\t/' "${NAME}.txt"  # Add tabs
sed -i -e 's/^/verse\t/' "${NAME}.txt"  # Add "verse" string
sed -i 's/  / /g' "${NAME}.txt"  # Remove double spaces
popd


# --> Make Quick Bible files
install -dv 'quick-bible'
cp "processing/${NAME}.txt" "quick-bible/en-${NAME}--1.yet"
pushd 'quick-bible'
# NOTE: Prepend file info
java -jar yettoyes2.jar "en-${NAME}--1.yet"
popd


# --> Make tsv file for command line bible
install -dv 'terminal-program'
pushd 'terminal-program'
grep -Irl 'KJV' . | xargs sed -i 's/KJV/KJV1611/g'
grep -Irl 'kjv' . | xargs sed -i 's/kjv/kjv1611/g'
find . -name "kjv*" -exec rename -v 's/kjv/kjv1611/' {} ";"
cp "../quick-bible/en-${NAME}--1.yet" "${NAME}.tsv"
sed -i 's/^verse\t1\t/Genesis\tGe\t1\t/' "${NAME}.tsv"
sed -i 's/^verse\t2\t/Exodus\tExo\t2\t/' "${NAME}.tsv"
sed -i 's/^verse\t3\t/Leviticus\tLev\t3\t/' "${NAME}.tsv"
sed -i 's/^verse\t4\t/Numbers\tNum\t4\t/' "${NAME}.tsv"
sed -i 's/^verse\t5\t/Deuteronomy\tDeu\t5\t/' "${NAME}.tsv"
sed -i 's/^verse\t6\t/Joshua\tJosh\t6\t/' "${NAME}.tsv"
sed -i 's/^verse\t7\t/Judges\tJdgs\t7\t/' "${NAME}.tsv"
sed -i 's/^verse\t8\t/Ruth\tRuth\t8\t/' "${NAME}.tsv"
sed -i 's/^verse\t9\t/1 Samuel\t1Sm\t9\t/' "${NAME}.tsv"
sed -i 's/^verse\t10/2 Samuel\t2Sm\t10/' "${NAME}.tsv"
sed -i 's/^verse\t11/1 Kings\t1Ki\t11/' "${NAME}.tsv"
sed -i 's/^verse\t12/2 Kings\t2Ki\t12/' "${NAME}.tsv"
sed -i 's/^verse\t13/1 Chronicles\t1Chr\t13/' "${NAME}.tsv"
sed -i 's/^verse\t14/2 Chronicles\t2Chr\t14/' "${NAME}.tsv"
sed -i 's/^verse\t15/Ezra\tEzra\t15/' "${NAME}.tsv"
sed -i 's/^verse\t16/Nehemiah\tNeh\t16/' "${NAME}.tsv"
sed -i 's/^verse\t17/Esther\tEst\t17/' "${NAME}.tsv"
sed -i 's/^verse\t18/Job\tJob\t18/' "${NAME}.tsv"
sed -i 's/^verse\t19/Psalms\tPsa\t19/' "${NAME}.tsv"
sed -i 's/^verse\t20/Proverbs\tPrv\t20/' "${NAME}.tsv"
sed -i 's/^verse\t21/Ecclesiastes\tEccl\t21/' "${NAME}.tsv"
sed -i 's/^verse\t22/Song of Solomon\tSSol\t22/' "${NAME}.tsv"
sed -i 's/^verse\t23/Isaiah\tIsa\t23/' "${NAME}.tsv"
sed -i 's/^verse\t24/Jeremiah\tJer\t24/' "${NAME}.tsv"
sed -i 's/^verse\t25/Lamentations\tLam\t25/' "${NAME}.tsv"
sed -i 's/^verse\t26/Ezekiel\tEze\t26/' "${NAME}.tsv"
sed -i 's/^verse\t27/Daniel\tDan\t27/' "${NAME}.tsv"
sed -i 's/^verse\t28/Hosea\tHos\t28/' "${NAME}.tsv"
sed -i 's/^verse\t29/Joel\tJoel\t29/' "${NAME}.tsv"
sed -i 's/^verse\t30/Amos\tAmos\t30/' "${NAME}.tsv"
sed -i 's/^verse\t31/Obadiah\tObad\t31/' "${NAME}.tsv"
sed -i 's/^verse\t32/Jonah\tJonah\t32/' "${NAME}.tsv"
sed -i 's/^verse\t33/Micah\tMic\t33/' "${NAME}.tsv"
sed -i 's/^verse\t34/Nahum\tNahum\t34/' "${NAME}.tsv"
sed -i 's/^verse\t35/Habakkuk\tHab\t35/' "${NAME}.tsv"
sed -i 's/^verse\t36/Zephaniah\tZep\t36/' "${NAME}.tsv"
sed -i 's/^verse\t37/Haggai\tHag\t37/' "${NAME}.tsv"
sed -i 's/^verse\t38/Zechariah\tZec\t38/' "${NAME}.tsv"
sed -i 's/^verse\t39/Malachi\tMal\t39/' "${NAME}.tsv"
sed -i 's/^verse\t40/Matthew\tMat\t40/' "${NAME}.tsv"
sed -i 's/^verse\t41/Mark\tMark\t41/' "${NAME}.tsv"
sed -i 's/^verse\t42/Luke\tLuke\t42/' "${NAME}.tsv"
sed -i 's/^verse\t43/John\tJohn\t43/' "${NAME}.tsv"
sed -i 's/^verse\t44/The Acts\tActs\t44/' "${NAME}.tsv"
sed -i 's/^verse\t45/Romans\tRom\t45/' "${NAME}.tsv"
sed -i 's/^verse\t46/1 Corinthians\t1Cor\t46/' "${NAME}.tsv"
sed -i 's/^verse\t47/2 Corinthians\t2Cor\t47/' "${NAME}.tsv"
sed -i 's/^verse\t48/Galatians\tGal\t48/' "${NAME}.tsv"
sed -i 's/^verse\t49/Ephesians\tEph\t49/' "${NAME}.tsv"
sed -i 's/^verse\t50/Philippians\tPhi\t50/' "${NAME}.tsv"
sed -i 's/^verse\t51/Colossians\tCol\t51/' "${NAME}.tsv"
sed -i 's/^verse\t52/1 Thessalonians\t1Th\t52/' "${NAME}.tsv"
sed -i 's/^verse\t53/2 Thessalonians\t2Th\t53/' "${NAME}.tsv"
sed -i 's/^verse\t54/1 Timothy\t1Tim\t54/' "${NAME}.tsv"
sed -i 's/^verse\t55/2 Timothy\t2Tim\t55/' "${NAME}.tsv"
sed -i 's/^verse\t56/Titus\tTitus\t56/' "${NAME}.tsv"
sed -i 's/^verse\t57/Philemon\tPhmn\t57/' "${NAME}.tsv"
sed -i 's/^verse\t58/Hebrews\tHeb\t58/' "${NAME}.tsv"
sed -i 's/^verse\t59/James\tJas\t59/' "${NAME}.tsv"
sed -i 's/^verse\t60/1 Peter\t1Pet\t60/' "${NAME}.tsv"
sed -i 's/^verse\t61/2 Peter\t2Pet\t61/' "${NAME}.tsv"
sed -i 's/^verse\t62/1 John\t1Jn\t62/' "${NAME}.tsv"
sed -i 's/^verse\t63/2 John\t2Jn\t63/' "${NAME}.tsv"
sed -i 's/^verse\t64/3 John\t3Jn\t64/' "${NAME}.tsv"
sed -i 's/^verse\t65/Jude\tJude\t65/' "${NAME}.tsv"
sed -i 's/^verse\t66/Revelation\tRev\t66/' "${NAME}.tsv"
sed -i '1,35d' "${NAME}.tsv"
make
./"${NAME}" 2 pet 3:9 | cat
popd


# --> Make vpl file
install -dv 'vpl'
pushd 'vpl'
cp "../terminal-program/${NAME}.tsv" "${NAME}.vpl"
sed -i 's/\tGe\t1\t/ /' "${NAME}.vpl"
sed -i 's/\tExo\t2\t/ /' "${NAME}.vpl"
sed -i 's/\tLev\t3\t/ /' "${NAME}.vpl"
sed -i 's/\tNum\t4\t/ /' "${NAME}.vpl"
sed -i 's/\tDeu\t5\t/ /' "${NAME}.vpl"
sed -i 's/\tJosh\t6\t/ /' "${NAME}.vpl"
sed -i 's/\tJdgs\t7\t/ /' "${NAME}.vpl"
sed -i 's/\tRuth\t8\t/ /' "${NAME}.vpl"
sed -i 's/\t1Sm\t9\t/ /' "${NAME}.vpl"
sed -i 's/\t2Sm\t10\t/ /' "${NAME}.vpl"
sed -i 's/\t1Ki\t11\t/ /' "${NAME}.vpl"
sed -i 's/\t2Ki\t12\t/ /' "${NAME}.vpl"
sed -i 's/\t1Chr\t13\t/ /' "${NAME}.vpl"
sed -i 's/\t2Chr\t14\t/ /' "${NAME}.vpl"
sed -i 's/\tEzra\t15\t/ /' "${NAME}.vpl"
sed -i 's/\tNeh\t16\t/ /' "${NAME}.vpl"
sed -i 's/\tEst\t17\t/ /' "${NAME}.vpl"
sed -i 's/\tJob\t18\t/ /' "${NAME}.vpl"
sed -i 's/\tPsa\t19\t/ /' "${NAME}.vpl"
sed -i 's/\tPrv\t20\t/ /' "${NAME}.vpl"
sed -i 's/\tEccl\t21\t/ /' "${NAME}.vpl"
sed -i 's/\tSSol\t22\t/ /' "${NAME}.vpl"
sed -i 's/\tIsa\t23\t/ /' "${NAME}.vpl"
sed -i 's/\tJer\t24\t/ /' "${NAME}.vpl"
sed -i 's/\tLam\t25\t/ /' "${NAME}.vpl"
sed -i 's/\tEze\t26\t/ /' "${NAME}.vpl"
sed -i 's/\tDan\t27\t/ /' "${NAME}.vpl"
sed -i 's/\tHos\t28\t/ /' "${NAME}.vpl"
sed -i 's/\tJoel\t29\t/ /' "${NAME}.vpl"
sed -i 's/\tAmos\t30\t/ /' "${NAME}.vpl"
sed -i 's/\tObad\t31\t/ /' "${NAME}.vpl"
sed -i 's/\tJonah\t32\t/ /' "${NAME}.vpl"
sed -i 's/\tMic\t33\t/ /' "${NAME}.vpl"
sed -i 's/\tNahum\t34\t/ /' "${NAME}.vpl"
sed -i 's/\tHab\t35\t/ /' "${NAME}.vpl"
sed -i 's/\tZep\t36\t/ /' "${NAME}.vpl"
sed -i 's/\tHag\t37\t/ /' "${NAME}.vpl"
sed -i 's/\tZec\t38\t/ /' "${NAME}.vpl"
sed -i 's/\tMal\t39\t/ /' "${NAME}.vpl"
sed -i 's/\tMat\t40\t/ /' "${NAME}.vpl"
sed -i 's/\tMark\t41\t/ /' "${NAME}.vpl"
sed -i 's/\tLuke\t42\t/ /' "${NAME}.vpl"
sed -i 's/\tJohn\t43\t/ /' "${NAME}.vpl"
sed -i 's/\tActs\t44\t/ /' "${NAME}.vpl"
sed -i 's/\tRom\t45\t/ /' "${NAME}.vpl"
sed -i 's/\t1Cor\t46\t/ /' "${NAME}.vpl"
sed -i 's/\t2Cor\t47\t/ /' "${NAME}.vpl"
sed -i 's/\tGal\t48\t/ /' "${NAME}.vpl"
sed -i 's/\tEph\t49\t/ /' "${NAME}.vpl"
sed -i 's/\tPhi\t50\t/ /' "${NAME}.vpl"
sed -i 's/\tCol\t51\t/ /' "${NAME}.vpl"
sed -i 's/\t1Th\t52\t/ /' "${NAME}.vpl"
sed -i 's/\t2Th\t53\t/ /' "${NAME}.vpl"
sed -i 's/\t1Tim\t54\t/ /' "${NAME}.vpl"
sed -i 's/\t2Tim\t55\t/ /' "${NAME}.vpl"
sed -i 's/\tTitus\t56\t/ /' "${NAME}.vpl"
sed -i 's/\tPhmn\t57\t/ /' "${NAME}.vpl"
sed -i 's/\tHeb\t58\t/ /' "${NAME}.vpl"
sed -i 's/\tJas\t59\t/ /' "${NAME}.vpl"
sed -i 's/\t1Pet\t60\t/ /' "${NAME}.vpl"
sed -i 's/\t2Pet\t61\t/ /' "${NAME}.vpl"
sed -i 's/\t1Jn\t62\t/ /' "${NAME}.vpl"
sed -i 's/\t2Jn\t63\t/ /' "${NAME}.vpl"
sed -i 's/\t3Jn\t64\t/ /' "${NAME}.vpl"
sed -i 's/\tJude\t65\t/ /' "${NAME}.vpl"
sed -i 's/\tRev\t66\t/ /' "${NAME}.vpl"

sed -i 's/\t/:/' "${NAME}.vpl"
sed -i 's/\t/ /' "${NAME}.vpl"
popd
