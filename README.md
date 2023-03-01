# DevOps

> Para crear toda la infraestructura, se recomienda primero crear un par de claves que utilizamos para probar nuestra identidad cuando nos conectamos a una instancia de Amazon EC2. [Link](https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#CreateKeyPair:) 

URL del proyecto funcionando:
http://nginx-alb-848141766.us-east-1.elb.amazonaws.com:8080/

# Archivos Terraform...
* main.tf: En este es el archivo principal donde definimos la mayoria de los recursos. En este archivo se va a crear la instancia EC2
* variables.tf En este archivo definimos las variables que vamos a utilizar al momento de crear la infraestructura.
* outputs.tf: En este archivo lo utilizamos para definir las salidas que se mostraran cuando terraform aplique los cambios sobre la infraestructura creada.
* roles.tf: En este archivo definimos los roles con sus politicas para los logs con `CloudWatchAgent`.
* providers.tf En este archivo definimos el proveedor cloud que vamos a usar. En este caso, espeficiamos AWS
* alb.tf En este archivo usamos un módulo de Terraform para crear un Application Load Balancer (alb), permitiendo crearlo de manera rápida y fácil, además de que proporciona opciones avanzadas de configuración.
* cloudwatch.tf En este archivo creamos la configuracion para la parte de los logs del sistema y medir metricas con CloudAgent
* configuration.sh: En este archivo realizamos la actualización de paquetes, instalar CloudAgent y cambiar el puerto 80 que usa nginx por defecto al puerto 8080.
* aws-credentials.sh: Este archivo exporta las credenciales temporales que se asumen con un rol con los permisos necesarios para levantar la infraestructura, de manera que evitamos la creación de un usuario IAM que haga uso de `aws_access_key_id` y `aws_secret_access_key`.
* cw_agent_config.json: Este archivo contiene la configuración para `cloudwatch-agent`.
* nginx.conf: Este archivo contiene la configuración para cambiar el puerto que escucha nginx por uno personalizado. En este caso usamos el puerto `8080`.


# Terraform
Inicializamos el directorio de trabajo de Terraform y la descarga de las dependencias necesarias para crear la infraestructura. Se recomienda ejecutar el siguiente comando cuando se realicen ajustes con los proveedores cloud o se agreguen más módulos.
```shell
    terraform init
```

Con este comando nos apoyamos para verificar la sintaxis de los archivos terraform que creamos para la infraestructura.
```shell
    terraform validate
```

Este comando muestra nuestro plan de ejecución que describe los cambios que se van a realizar en la nueva infraestructura.
```shell
    terraform plan
```
Este comando crea todos los recursos por Terraform. Si pasamos el flag ` -auto-approve` creara los recursos sin preguntar si estamos seguros de continuar.
```shell
    terraform apply
    terraform apply -auto-approve
```

Este comando elimina todos los recursos por Terraform. Si pasamos el flag ` -auto-approve` eliminara los recursos sin preguntar si estamos seguros de continuar.
```shell
    terraform destroy -auto-approve
```

# Estructura del proyecto
```shell
|   alb.tf                      # AWS Balanceador
|   aws-credentials.sh          # Credenciales AWS
|   cloudwatch.tf               # CloudWatchAgent
|   configuration.sh            # Configuración para CloudWatchAgent
|   cw_agent_config.json        # Configuración JSON para el Agent
|   devops-pulpo.pem            # Archivo PEM para conectarnos al EC2
|   main.tf                     # Archivo principal donde se crea la instancia EC2
|   Makefile
|   monitoring.tf               # Archivo para crear un Dashboard en CloudWatch
|   nginx.conf                  # Configuración de Nginx para usar un puerto diferente al 80
|   output.tf                   # Salida de configuraciones
|   providers.tf                # Archivo para configurar el proveedor cloud
|   roles.tf                    # Archivo para crear los roles para los logs y CloudWatchAgent
|   variables.tf                # Archivo donde leemos las credenciales y otros secretos para levantar la infraestructura.
```


