### helm commands ###

# creating helm chart
helm create hello=world

# to check chart is well-formed
helm lint ./hello-world

# to render the template locally for quick review
helm template ./hello-world

# install hello-world helm
helm install hello-world ./hello-world

# checking deployed 
helm ls --all

# upgrade release after some modification
helm upgrade hello-world ./hello-world

# rollback 
helm rollback hello-world 1

# check all revision history
helm history hello-world

# check values, manifest
helm get values hello-world
helm get manifest hello-world

# package your helm, generate .tgz file
helm package ./hello-world

# create index file
helm repo index --url https://yewintaung.github.io/hello-word ./hello-world

# add helm chart into local repository
helm repo add helloworld https://yewintaung.github.io/hello-word

# search helm repo details
helm search repo hellocloud

# helm chart pull from repo
helm pull metallb/metallb --version {chart-version} --untar

# directly install helm
helm install metallb/metallb --version {chart-version} --untar

# helm diff plugin install
helm plugin install https://github.com/databus23/helm-diff

# check helm