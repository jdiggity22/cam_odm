# cam_odm
Project to test potential CAM and ODM integratons



### Directory Structure

**CAM_service_definitions** - The source for the CAM service definitions used in the integrations

**ODM_apps** - ODM rule apps that are called by the CAM service REST hooks



### Installing the ODM container

#### 	Installing with ICP

​		ODM is available OOTB as a default container available via IBM HELM repository.

1. Make sure you have sync'ed your Helm Repository


1. - Login to ICP Management UI (https://<management IP>:8443/console)
   - Navigate to Manage -> Helm Repositories
   - Select "Sync repositories"


2. Deploy the ODM Helm chart

   - From the ICP Management interface navigate to Catalog -> Helm Charts

   - Enter "odm" intio the search bar and select the "ibm-odm-dev" Helm Chart

   - Click Configure

   - Enter the relavent parameters for your environment and click Install

     ​

   ​

#### 	Installing standalone Container



### Installing ODM Rule Builder client

1. Download the Eclipse Luna client for your platform (I used standare edition. Not sure if it matters.)
2. Install the ODM Rule Builder plugin



#### Accessing ODM interfaces

| Component                                                    | URL                                     | Username    | Password    |
| ------------------------------------------------------------ | --------------------------------------- | ----------- | ----------- |
| [Decision Server Console](http://localhost:9060/res)         | <http://localhost:9060/res>             | resAdmin    | resAdmin    |
| [Decision Server Runtime](http://localhost:9060/DecisionService) | <http://localhost:9060/DecisionService> | N/A         | N/A         |
| [Decision Center Business Console](http://localhost:9060/decisioncenter) | <http://localhost:9060/decisioncenter>  | rtsAdmin    | rtsAdmin    |
| [Decision Center Enterprise Console](http://localhost:9060/teamserver) | <http://localhost:9060/teamserver>      | rtsAdmin    | rtsAdmin    |
| [Decision Runner](http://localhost:9060/DecisionRunner)      | <http://localhost:9060/DecisionRunner>  | resDeployer | resDeployer |



#### Useful links

[IBM ODM Dockerhub image](https://hub.docker.com/r/ibmcom/odm/)

[ODM Simple Rule Tutorial](https://www.youtube.com/watch?v=dIJ-VLkuw0s)

[Additional ODM Youtube videos](https://youtu.be/otBRD6icDk0)



#### Installing ODM Rule Builder

[Eclipse Luna Download](https://www.eclipse.org/downloads/packages/release/luna/sr2)

[Rule Builder Plugin](https://marketplace.eclipse.org/content/ibm-operational-decision-manager-developers-rule-designer)