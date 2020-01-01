# agent-policy.hcl contains the following:
node_prefix "" {
   policy = "write"
}
service_prefix "" {
   policy = "read"
}

agent_prefix "" {
  policy = "write"
}