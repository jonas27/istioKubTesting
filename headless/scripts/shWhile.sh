cat <<EOF >> test.sh
#!/bin/bash
c=0
while [ \$c -lt 10 ]
do
echo "hello"
curl google.de
c=\$[\$c + 1]
done
EOF