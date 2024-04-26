NAMESPACE=default
MAX_RELEASE=5
RELEASE_NAME=echoapp
CURRENT_DIR="$(dirname "$(readlink -f "$0")")"
HOME_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

# helm install
helm install $RELEASE_NAME $HOME_DIR -n $NAMESPACE
sleep 3
echo

# helm upgrade
for i in $(seq 2 $MAX_RELEASE)
do
  echo "Running version $i"
  sleep 0.5

  helm upgrade $RELEASE_NAME $HOME_DIR -n $NAMESPACE --set echo="HelloCloud Version $i"
  sleep 2
  echo
done