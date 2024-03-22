export TS-AUTH-KEY=""
tailscale login authkey=${TS-AUTH-KEY} 
tailscale up
tailscale serve 80
tailscale down