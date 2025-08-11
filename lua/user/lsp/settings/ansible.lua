return {
  -- This is the default configuration for ansiblels, you might not need to specify much
  -- It automatically targets 'yaml.ansible' filetypes
  filetypes = { 'yaml.ansible' },
  -- Optional: Configure settings for the Ansible Language Server
  settings = {
    ansible = {
      -- Path to your ansible executable (useful if using a virtualenv)
      path = 'ansible',
      -- Path to your ansible-lint executable
      ansibleLint = {
        enabled = true,
        path = 'ansible-lint',
        -- Optional: Add arguments to ansible-lint
        -- arguments = { '--parseable', '--strict' },
      },
      python = {
        -- Path to your Python interpreter (important if using a virtualenv)
        interpreterPath = 'python',
      },
      -- Enable/disable execution environment support (usually not needed for local dev)
      executionEnvironment = {
        enabled = false,
      },
      -- Toggle usage of fully qualified collection names
      useFullyQualifiedCollectionNames = true,
      -- ... other settings, refer to ansible-language-server documentation for all options
    },
  }
}
