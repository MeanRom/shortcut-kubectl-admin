######
# Add this shortcut inside your existing .zshrc
#
# IMPORTANT NOTE: 
# Do not override the existing zshrc file!
# Add this shortcut to the end of the file.
######


# Shortcut Kubectl commands
kubectl-admin() {
  case "$1" in
    start)
      kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
      echo "Starting..."
      ;;
    token)
      kubectl create token admin-user -n kubernetes-dashboard
      ;;
    install)
      helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/ && helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
      ;;
    fix-forbidden)
      kubectl create clusterrolebinding admin-user-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
      ;;
    help)
      echo "Usage: kubectl-admin {start|token|install|fix-forbidden|help}
	  -------
	  start: Start the kubernetes-dashboard-kong-proxy service
	  token: Get a token for the admin-user service account
	  install: Install the kubernetes-dashboard
	  fix-forbidden: Fix the forbidden error
	  help: Show this help message
	  -------"
      ;;
    *)
      echo "Usage: kubectl-admin {start|token|install|fix-forbidden|help}
	  -------
	  start: Start the kubernetes-dashboard-kong-proxy service
	  token: Get a token for the admin-user service account
	  install: Install the kubernetes-dashboard
	  fix-forbidden: Fix the forbidden error
	  help: Show this help message
	  -------"
      ;;
  esac
}