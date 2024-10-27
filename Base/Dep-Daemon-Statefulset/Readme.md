Ref:- https://rajeshsingamsetti.blogspot.com/2022/10/k8-session-3-replica-set-and-controller.html

Features
- Scalability
- Autoscale (Max surge/rolling update)
- Self Healing
- Load Balancing
kubectl create deployment rajdeploy --image rajeshsingam/rajesh_aws_app --replicas=1 --dry-run -o yaml

--------------------Pod controller---------------

The functionality of both Replica Controller and Replica Set is quiet the same – they are responsible to make sure that X number of pods with label that is equal to there label selector will be scheduled to different nodes on the cluster.

replication controller

replication set
deployment

1.replication controller:
it s like autoscaling which will monitor the pod depends on label which allocated to pod.

2. replications seT;
its a advance feature of replication controller which only difference is when reflection controller will manage only "single labels" by using
replication set we can manage the multiple labels in replication controller

another pont replication controller will get rollback but replication set we wont get roll back update

3.Deployment: real time all are using deployments only
we can over come above all issues using deployment
ref: https://www.mirantis.com/blog/kubernetes-replication-controller-replica-set-and-deployments-understanding-replication-options/


****************** Deployment********************************
Note when deployment will create first it will create the replication set after it will slowly move the pods one by one.

k8 deployment strategies=============
There we have 3 types of deployments
1.rolling deployment
2.recreate
3.canary deployment & blue green deployment & red & green deployment

**By default when you are creating it will create the rolling deployment.

Rolling deployment:
When a deployment create that time backend one replica set will create & after respected pods will create.
Thought rolling lets assume we have nginx1.9 we need to update 1.20 first it will create the replica set inside it will create one new pod with latest nginx version after remove old pod version after create a new pod version in new replica set.

##########################################
kubectl explain deployment.spec.strategy.rollingUpdate
DESCRIPTION:
    Rolling update config params. Present only if DeploymentStrategyType =
    RollingUpdate.
    Spec to control the desired behavior of rolling update.

FIELDS:
  maxSurge      <IntOrString>
    The maximum number of pods that can be scheduled above the desired number of
    pods. Value can be an absolute number (ex: 5) or a percentage of desired
    pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is
    calculated from percentage by rounding up. Defaults to 25%. Example: when
    this is set to 30%, the new ReplicaSet can be scaled up immediately when the
    rolling update starts, such that the total number of old and new pods do not
    exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet
    can be scaled up further, ensuring that total number of pods running at any
    time during the update is at most 130% of desired pods.

  maxUnavailable        <IntOrString>
    The maximum number of pods that can be unavailable during the update. Value
    can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
    Absolute number is calculated from percentage by rounding down. This can not
    be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%,
    the old ReplicaSet can be scaled down to 70% of desired pods immediately
    when the rolling update starts. Once new pods are ready, old ReplicaSet can
    be scaled down further, followed by scaling up the new ReplicaSet, ensuring
    that the total number of pods available at all times during the update.

    