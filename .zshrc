######
# Add this shortcut inside your existing .zshrc
#
# IMPORTANT NOTE: 
# Do not override the existing zshrc file!
# Add this shortcut to the end of the file.
######


# Shortcut Kubectl commands
kube() {
  case "$1" in
    admin)
      case "$2" in
        start)
          kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
          ;;
        token)
        if [ -z "$3" ]; then
          kubectl create token admin-user -n kubernetes-dashboard
          else
          kubectl create token $3 -n kubernetes-dashboard
          fi
          ;;
        install)
          helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/ && helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
          ;;
        user)
        if [ -z "$3" ]; then
          kubectl create serviceaccount admin-user -n kubernetes-dashboard
          else
          kubectl create serviceaccount $3 -n kubernetes-dashboard
          fi
          ;;
        fix-forbidden)
          kubectl create clusterrolebinding admin-user-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
          ;;
        *)
          echo "Usage: fk3d admin {start|token|install|user|fix-forbidden} | use the command 'fk3d help' for more information"
          ;;
      esac
      ;;
    list)
      kubectl config get-contexts
      ;;
    switch)
      kubectl config use-context "$2"
      ;;
    help|*)
      echo "Usage: fk3d {admin|list|switch|help}
	  -------
	  admin start: Start the kubernetes-dashboard service
	  
    admin token: Get a token for admin-user
	  admin token <name>: Get a token for admin-user with a custom name
	  
    admin user: Create admin-user service account
	  admin user <name>: Create admin-user service account with a custom name
	  
    admin install: Install the kubernetes-dashboard
	  admin fix-forbidden: Fix forbidden errors

    list: List all available kubectl contexts
	  switch <context>: Switch kubectl context
	  -------"
      ;;
  esac
}