@echo off
setlocal

if "%1"=="admin" (
    if "%2"=="start" (
        kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
    ) else if "%2"=="token" (
        if "%3"=="" (
            kubectl create token admin-user -n kubernetes-dashboard
        ) else (
            kubectl create token %3 -n kubernetes-dashboard
        )
    ) else if "%2"=="install" (
        helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/ && helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
    ) else if "%2"=="user" (
        if "%3"=="" (
            kubectl create serviceaccount admin-user -n kubernetes-dashboard
        ) else (
            kubectl create serviceaccount %3 -n kubernetes-dashboard
        )
    ) else if "%2"=="fix-forbidden" (
        kubectl create clusterrolebinding admin-user-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
    ) else (
        echo Usage: %~n0 admin {start^|token^|install^|user^|fix-forbidden} ^| use the command '%~n0 help' for more information
    )
) else if "%1"=="switch" (
    if not "%2"=="" (
        kubectl config use-context "%2"
    ) else (
        echo Usage: %~n0 switch ^<context^>
    )
) else (
    echo Usage: %~n0 {admin^|switch^|help}
    echo.
    echo -------
    echo    admin start: Start the kubernetes-dashboard service
    echo    admin token: Get a token for admin-user
    echo    admin token ^<name^>: Get a token for admin-user with a custom name
    echo    admin user: Create admin-user service account
    echo    admin user ^<name^>: Create admin-user service account with a custom name
    echo    admin install: Install the kubernetes-dashboard
    echo    admin fix-forbidden: Fix forbidden errors
    echo    switch ^<context^>: Switch kubectl context
    echo -------
)

endlocal