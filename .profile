export SSH_AGENT_SOCK=~/.1password/agent.sock

if uwsm check may-start && uwsm select; then
  exec uwsm start default
fi

