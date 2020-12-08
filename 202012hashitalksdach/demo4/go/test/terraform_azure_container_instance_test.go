package test

import (
	"context"
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/Azure/azure-sdk-for-go/services/containerinstance/mgmt/2019-12-01/containerinstance"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestTerraformAzureContainerInstance tests the container instance
func TestTerraformAzureContainerInstance(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	uniquePrefix := random.UniqueId()

	// Configure Terraform setting up a path to Terraform code.
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../..",
		Vars: map[string]interface{}{
			"prefix": uniquePrefix,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	link := terraform.Output(t, terraformOptions, "link")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	containerGroupName := terraform.Output(t, terraformOptions, "container_group_name")
	subscriptionID := terraform.Output(t, terraformOptions, "subscription_id")

	// Look up the image used in the container group and make sure it matches the expectation
	authorizer, err := auth.NewAuthorizerFromCLI()
	assert.Nil(t, err)
	containerGroupsClient := containerinstance.NewContainerGroupsClient(subscriptionID)
	containerGroupsClient.Authorizer = authorizer
	containerGroup, err := containerGroupsClient.Get(ctx, resourceGroupName, containerGroupName)
	assert.Nil(t, err)

	actualImage := (*(*containerGroup.Containers)[0].Image)
	expectedImage := "tobiasfenster/aci-helloworld:hashitalksdach-2020"
	assert.Equal(t, expectedImage, actualImage)

	// Make a call to the container instance and validate the expected outcome
	res, err := http.Get(link)
	assert.Nil(t, err)
	actualContent, err := ioutil.ReadAll(res.Body)
	res.Body.Close()
	assert.Nil(t, err)

	expectedContent, err := ioutil.ReadFile("expected.html")
	assert.Nil(t, err)
	assert.Equal(t, string(expectedContent), string(actualContent))
}
