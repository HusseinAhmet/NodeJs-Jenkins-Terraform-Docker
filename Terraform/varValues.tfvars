// Network
cidr = "10.0.0.0/16"
enviromentName= " NodeApp- "
PubSub1 = "10.0.1.0/24"
PubSub2 = "10.0.3.0/24"
PrivSub2 = "10.0.2.0/24"
PrivSub1 = "10.0.0.0/24"
// Servers
InstanceType="t2.micro"
AmiID= "ami-03b755af568109dc3"
CPUPolicyTargetValue=30
MinCapacity="2"
MaxCapacity="4"
lb-port=80
keyPair= "train-key.pem"
bucketname= "nodeapp-terraform-state-file1"
// Database Vars
db_name="mydb"
db-engine="mysql"
db-engine-version="5.7.11"
db-instance_class="db.t2.micro"
db-username="admin"
db-password="12345678"
db-publicly_accessible=true
db-port=3306
db-storage_type="gp2"
db-allocated_storage=20