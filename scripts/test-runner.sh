NAMESPACE=echoapp

# helm install
helm install echoapp . -n $NAMESPACE

sleep 3
echo


MAX=3
for i in $(seq 2 $MAX)
do
  echo "Running version $i"
  sleep 0.5

  # helm upgrade
  helm upgrade echoapp . -n $NAMESPACE --set echo="HelloCloud Version $i"
  sleep 2
  echo
done

