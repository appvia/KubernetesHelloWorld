# Your first Kubernetes cluster

You've heard of kubernets, but you have never used it and dont know what it can do? Then start here, in this article we will step through setting up your first cluster on your own computer (laptop or desktop computer), and deploy a simple application into the cluster. 

Setting a local Kubernetes cluster is made extremely simple today with the wide availability of tools like minikube, mikrok8s, kind and many others besides these, so for this tutorial we'll use kind, as it is the fastest to setup with minimal dependencies as long as you can run docker on your machine.

To make things easier you can clone the exmples and this article in our public git repository here https://github.com/appvia/KubernetesHelloWorld

## KIND setup

### Requirements (dependencies)

#### Docker

To get kind working you will need docker installed.X
 * On linux it is best to use your operating system package manager, `apt` on ubuntu or debian, `yum` or `dnf` on fedora/centos/rhel and `pacman` or `yay` on archlinux.
 * on Mac or windows use the instructions for your platform here https://docs.docker.com/get-docker/

#### Kubectl

You will also need the `kubectl` command to interact with the cluster once it's up and running.
 * On linux install it ...*TODO*
 * On a mac, it should be easy if you use the `brew` package manager, just run `brew install kubectl`
 * On windows ... *TODO*  _Does it come with the windows docker installer?_

#### KIND

Finally, you will need to get the `kind` command. 
 * On linux install it ...*TODO*
 * on a mac, it should be easy to use the `brew` command again, with `brew install kind`
 * On windows .. *TODO* _maybe use chocolatey choco command ? see here https://kind.sigs.k8s.io/docs/user/quick-start/_

## Create the cluster

Once all these components are installed, we are ready to create our local kubernetes cluster.

```kind create cluster --name mycluster --wait 5m```

It only takes a few minutes, and after this runs you should see  a friendly message telling you your cluster is ready

![image created cluster](/image images/1_created_cluster.png)

as the output says, the cluster is up and your kubectl command configuration is already set to talk to the cluster.

## Deploy an application

Now that we have a cluster up and running, we can run something. We will run a simple webserver wih a "hellow world" message of our own creation.

Kubernetes describes all workloads through a simple yaml format file called a "manifest". So to setup somethiign on our cluster we need to write a yaml file to describe what we want to run. 

All the manifests for this example deployment can be found in the repository under the manifests folder.

First lets describe a workload deployment

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: example1
  name: example1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: example1
  template:
    metadata:
      labels:
        app: example1
    spec:
      containers:
      - image: nginx:latest
        name: nginx
```

Write this into a yaml file, or use the file from the github repository, and use the kubectl command to apply the workload definition.

```
kubectl apply -f examples/1_helloworld_deploy.yaml
```

This will deploy the nginx docker container and run it as a process on the cluster. Confirm it's running by looking at the resulting pod that's running, `kubectl get pods`
you should see output that looks like the following

```
NAME                        READY   STATUS    RESTARTS   AGE
example1-7466b89f7c-cs4cc   1/1     Running   0          14s
```

If the "STATUS" field says "Running" it should be working as expected. So what actually happened?

When you create a deployment in kubernetes, a number of replicas is listed in the manifest, each replica is a copy of the container that was in the spec. This running instance is actually in an object called a "Pod". A Pod is one or more containers running in a logical group. This allows fora number of useful arrangements, like using a partner processes to deal with processing jobs, shipping logs or metrics, or a processes that runs once to help setup the "Pod" for operation, the latter are called "initContainers".


## expose the service

next we 
