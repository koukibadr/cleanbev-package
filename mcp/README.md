# cleanbev-mcp

MCP server for [cleanbev](https://pub.dev/packages/cleanbev) — clean unused Flutter assets from any MCP-compatible AI tool.

## Requirements

- Dart SDK on PATH
- `dart pub global activate cleanbev`

## Getting Started

### Quick Install

Click one of the buttons below to install the MCP server in your preferred IDE:

[![Install in VS Code](https://img.shields.io/badge/Install_in-VS_Code-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://vscode.dev/redirect/mcp/install?name=cleanbev-mcp&config=%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D)
[![Install in VS Code Insiders](https://img.shields.io/badge/Install_in-VS_Code_Insiders-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=cleanbev-mcp&config=%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D&quality=insiders)
[![Install in Visual Studio](https://img.shields.io/badge/Install_in-Visual_Studio-C16FDE?style=flat-square&logo=visualstudio&logoColor=white)](https://vs-open.link/mcp-install?%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D)
[![Install in Cursor](https://img.shields.io/badge/Install_in-Cursor-000000?style=flat-square&logoColor=white)](https://cursor.com/en/install-mcp?name=cleanbev-mcp&config=eyJjb21tYW5kIjoidXZ4IiwiYXJncyI6WyItLWZyb20iLCJjbGVhbmJldi1tY3AiLCJjbGVhbmJldi1tY3AiXSwiZW52Ijp7fX0=)

### Manual Installation

**Standard config** works in most tools:

```js
{
  "servers": {
    "cleanbev-mcp": {
      "command": "uvx",
      "args": [
        "--from",
        "cleanbev-mcp",
        "cleanbev-mcp"
      ],
      "env": {}
    }
  }
}
```

<details>
<summary>VS Code</summary>

#### Click the button to install:

[![Install in VS Code](https://img.shields.io/badge/Install_in-VS_Code-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://vscode.dev/redirect/mcp/install?name=cleanbev-mcp&config=%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D)

#### Or install manually:

Follow the MCP install [guide](https://code.visualstudio.com/docs/copilot/chat/mcp-servers#_add-an-mcp-server), use the standard config above. You can also install the cleanbev-mcp MCP server using the VS Code CLI:

```bash
code --add-mcp '{\"name\":\"cleanbev-mcp\",\"command\":\"uvx\",\"args\":[\"--from\",\"cleanbev-mcp\",\"cleanbev-mcp\"],\"env\":{}}'
```

After installation, the cleanbev-mcp MCP server will be available for use with your GitHub Copilot agent in VS Code.
</details>

<details>
<summary>VS Code Insiders</summary>

#### Click the button to install:

[![Install in VS Code Insiders](https://img.shields.io/badge/Install_in-VS_Code_Insiders-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=cleanbev-mcp&config=%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D&quality=insiders)

#### Or install manually:

Follow the MCP install [guide](https://code.visualstudio.com/docs/copilot/chat/mcp-servers#_add-an-mcp-server), use the standard config above. You can also install the cleanbev-mcp MCP server using the VS Code Insiders CLI:

```bash
code-insiders --add-mcp '{\"name\":\"cleanbev-mcp\",\"command\":\"uvx\",\"args\":[\"--from\",\"cleanbev-mcp\",\"cleanbev-mcp\"],\"env\":{}}'
```

After installation, the cleanbev-mcp MCP server will be available for use with your GitHub Copilot agent in VS Code Insiders.
</details>

<details>
<summary>Visual Studio</summary>

#### Click the button to install:

[![Install in Visual Studio](https://img.shields.io/badge/Install_in-Visual_Studio-C16FDE?style=flat-square&logo=visualstudio&logoColor=white)](https://vs-open.link/mcp-install?%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22--from%22%2C%22cleanbev-mcp%22%2C%22cleanbev-mcp%22%5D%2C%22env%22%3A%7B%7D%7D)

#### Or install manually:

1. Open Visual Studio
2. Navigate to the GitHub Copilot Chat window
3. Click the tools icon (🛠️) in the chat toolbar
4. Click the + "Add Server" button to open the "Configure MCP server" dialog
5. Fill in the configuration:
   - **Server ID**: `cleanbev-mcp`
   - **Type**: Select `stdio` from the dropdown
   - **Command**: `uvx`
   - **Arguments**: `--from cleanbev-mcp cleanbev-mcp`
6. Click "Save" to add the server

For detailed instructions, see the [Visual Studio MCP documentation](https://learn.microsoft.com/visualstudio/ide/mcp-servers).
</details>

<details>
<summary>Cursor</summary>

#### Click the button to install:

[![Install in Cursor](https://img.shields.io/badge/Install_in-Cursor-000000?style=flat-square&logoColor=white)](https://cursor.com/en/install-mcp?name=cleanbev-mcp&config=eyJuYW1lIjoiY2xlYW5iZXYtbWNwIiwiY29tbWFuZCI6InV2eCIsImFyZ3MiOlsiLS1mcm9tIiwiY2xlYW5iZXYtbWNwIiwiY2xlYW5iZXYtbWNwIl0sImVudiI6e319)

#### Or install manually:

Go to `Cursor Settings` -> `MCP` -> `Add new MCP Server`. Name to your liking, use `command` type with the command from the standard config above. You can also verify config or add command like arguments via clicking `Edit`.
</details>

<details>
<summary>Claude Code</summary>

Use the Claude Code CLI to add the cleanbev-mcp MCP server:

```bash
claude mcp add cleanbev-mcp uvx --from cleanbev-mcp cleanbev-mcp
```
</details>

<details>
<summary>Claude Desktop</summary>

Follow the MCP install [guide](https://modelcontextprotocol.io/quickstart/user), use the standard config above.
</details>

<details>
<summary>Warp</summary>

Go to `Settings` -> `AI` -> `Manage MCP Servers` -> `+ Add` to [add an MCP Server](https://docs.warp.dev/knowledge-and-collaboration/mcp#adding-an-mcp-server). Use the standard config above.

Alternatively, use the slash command `/add-mcp` in the Warp prompt and paste the standard config from above.
</details>

<details>
<summary>GitHub Copilot CLI</summary>

GitHub Copilot CLI supports adding MCP servers interactively and through a config file.

#### Option 1: Interactive setup with `/mcp add`

1. Open GitHub Copilot CLI in interactive mode.
2. Run `/mcp add`.
3. Enter **Server Name**: `cleanbev-mcp`.
4. Choose **Server Type**:
   - `STDIO` for command-based servers
   - `HTTP` for remote servers
5. Fill in command/url settings from the standard config above and set **Tools** to `*`.
6. Press `Ctrl+S` to save.

#### Option 2: Edit `~/.copilot/mcp-config.json`

```json
{
  "mcpServers": {
    "cleanbev-mcp": {
      "command": "uvx",
      "args": [
        "--from",
        "cleanbev-mcp",
        "cleanbev-mcp"
      ],
      "env": {},
      "type": "local",
      "tools": [
        "*"
      ]
    }
  }
}
```

For more information, see the [GitHub Copilot CLI MCP documentation](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-mcp-servers).
</details>

<details>
<summary>GitHub Copilot Coding Agent</summary>

GitHub Copilot Coding Agent can use MCP servers to extend its capabilities. Use the configuration below specifically formatted for the Coding Agent:

```json
{
  "mcpServers": {
    "cleanbev-mcp": {
      "command": "uvx",
      "args": [
        "--from",
        "cleanbev-mcp",
        "cleanbev-mcp"
      ],
      "env": {},
      "type": "local",
      "tools": [
        "*"
      ]
    }
  }
}
```

Add this configuration to your repository settings under **Copilot > Coding agent**. The `"tools": ["*"]` setting enables all available tools from the MCP server.

For more information, see the [GitHub Copilot Coding Agent MCP documentation](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/extend-coding-agent-with-mcp).
</details>

### Configuration Details

- **Server Name:** `cleanbev-mcp`
- **Type:** UVX Package
- **Package:** `cleanbev-mcp`
- **From:** `cleanbev-mcp`

### Need Help?

For more information about the Model Context Protocol, visit [modelcontextprotocol.io](https://modelcontextprotocol.io).

For any other issues, consider opening an issue on the [cleanbev GitHub repository](https://github.com/koukibadr/cleanbev-package)

## Contributing

Contributions to the Cleanbev MCP are welcome! If you have ideas for improvements or want to report bugs, please open an issue or submit a pull request on the [cleanbev GitHub repository](https://github.com/koukibadr/cleanbev-package).
