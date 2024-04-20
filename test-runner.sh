# helm install
helm install echoapp . -n default

sleep 3


MAX=15
for i in $(seq 2 $MAX)
do
  echo "Running version $i"
  sleep 0.5

  # helm upgrade
  helm upgrade echoapp . -n default --set deployment.echo="HelloCloud Version $i"
  sleep 2
done

