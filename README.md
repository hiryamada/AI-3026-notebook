# AI-3026 C# Notebook

- Start your AI-3026 Lab 1 in Skillable
  - Lab 1 is ok for running all notebooks in this repository.
- Start your [GitHub Codespaces](https://github.com/features/codespaces). The environment will contain:
  - .NET 9
  - Polyglot notebook VSCode extension
  - C# VSCode extension
  - C# Dev Kit VSCode extension
  - Azure CLI (necessary for running setup.dib)
  - PowerShell (necessary for running setup.dib)
- Wait a few moments while GitHub Codespaces finishes setting up.
  - It should only take a minute or so
  - Wait until the hourglass icon on the extension's button disappears.
- Open and run [setup.dib](setup.dib) in your GitHub Codespaces.
  - You will be prompted to enter a username and password, so enter them displayed in your lab instance.
  - Necessary resources are deployed automatically.
    - Azure AI Hub
    - Azure AI Project
    - Azure AI Services
    - Storage Account
    - Key Vault
  - `.env` file generated. This file contains the connection string for Azure AI Project and model deployment name.
- Open and run [lab02.dib](lab02.dib) / [lab03.dib](lab03.dib) / [lab04.dib](lab04.dib) / [lab05.dib](lab05.dib) in your GitHub Codespaces.
  - The notebook for lab 1 is not provided because it's about Azure AI Foundry interactive experience only, no coding.

## References

Microsoft Learn
https://learn.microsoft.com/en-us/training/paths/develop-ai-agents-on-azure/

Lab instructions
https://microsoftlearning.github.io/mslearn-ai-agents/

Lab GitHub repository
https://microsoftlearning.github.io/mslearn-ai-agents/
