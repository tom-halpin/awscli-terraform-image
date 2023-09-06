#!/bin/sh
echo "Remember: It is essential to run 'terraform destroy' before exiting the container instance to ensure the Terraform state is not lost!"
echo ""
terraform --version
echo ""
aws --version
exec /bin/sh
