# TO INSTALL DOCKER ENGINE:
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
wait

#Post Installation steps:
groupname="docker"
sudo groupadd $groupname
if getent group "$groupname" >/dev/null; then
  echo "Group $groupname exists"
fi
sudo usermod -aG docker $USER
if id -nG "$USER" | grep -qw "$groupname"; then
    echo $USER added to $groupname successfully.
fi
echo "New group"
sudo apt-get install acl
wait
sudo setfacl -m user:$USER:rw /var/run/docker.sock
echo "Hello-world docker container"
docker run hello-world
wait
container_name=$(docker ps -a  | grep '/hello' |head -1| awk '{print $1}')
echo "THE CONTAINER NAME IS: "$container_name
if [ "$(docker inspect $container_name --format '{{.State.Status}}')" != "running" ]; then
echo 'DOCKER INSTALLED SUCCESSFULLY AND CONTAINER RUNNING!!!'
fi
sudo chmod 777 /var/run/docker.sock


# TO INSTALL JENKINS.

# To install Java.
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
wait
[[ "$(java -version)" =~ "openjdk version" ]] && echo "Java is installed"

# To install jenkins.
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

echo "THE ADMIN PASSWORD TO LOGIN TO JENKINS: "
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

