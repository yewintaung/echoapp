NAMESPACE=default
MAX_RELEASE=3
RELEASE_NAME=echoapp

# helm install
helm install $RELEASE_NAME ../ -n $NAMESPACE
sleep 3
echo

# helm upgrade
for i in $(seq 2 $MAX_RELEASE)
do
  echo "Running version $i"
  sleep 0.5

  helm upgrade $RELEASE_NAME ../ -n $NAMESPACE --set echo="HelloCloud Version $i"
  sleep 2
  echo
done