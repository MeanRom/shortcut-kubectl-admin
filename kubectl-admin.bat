@echo off
if "%1"=="start" (
    kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
    echo Starting...
) else if "%1"=="token" (
    kubectl create token admin-user -n kubernetes-dashboard
) else if "%1"=="install" (
    helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
    helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
) else if "%1"=="fix-forbidden" (
    kubectl create clusterrolebinding admin-user-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
) else (
    echo Usage: kubectl-admin {start^|token^|install^|fix-forbidden^|help}
)