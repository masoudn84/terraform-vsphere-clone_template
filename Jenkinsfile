pipeline {
    agent any
    parameters {
        booleanParam(name: "FORCE_INFRA",defaultValue: false,description: "Aviod stage from build")
    }
    stages{
        stage("load terraform repo") {
            steps {
                sh "mv config/terraform.tfvars ."
            }
        }
        stage("terraform init") {
            
            when {
                    anyOf {
                        equals(
                            actual: currentBuild.number,
                            expected: 1
                        )
                        expression {
                            return params.FORCE_INFRA
                        }
                    }
                }
                steps {
                sh """terraform init"""
                }
        }
        stage("terraform build") {
            steps {
                echo "++++++++++++++++++start build+++++++++++++++++++++++++++++++"
                withCredentials([string(credentialsId: "vcenterPass",variable: 'YOUR_PW_DEFINED')]) {
                    timeout(60) {
                        sh """
                            terraform apply -auto-approve -var vsphere_password="${YOUR_PW_DEFINED}" 
                        """
                    }
                }    
            }
        }
        stage("deploy service with ansible") {
            steps {
                echo "++++++++++++++++++start deploy+++++++++++++++++++++++++++++++"
                ansiblePlaybook(
                    inventory: "vm_ip.txt",
                    become: true,
                    playbook: "deploy.yml"
                )
            }
        }
    }
}