# GLPI AI Ticket Generator

An intelligent n8n workflow that automatically processes emails and creates/manages GLPI tickets using AI-powered classification and resolution suggestions.

## 🌟 Features

- **Automatic Email Classification**: AI-powered email filtering to identify genuine support requests
- **Smart Ticket Creation**: Automatically creates GLPI tickets with proper categorization and priority
- **Solution Search**: Searches through resolved tickets database to suggest solutions
- **Ticket Linking**: Automatically detects and links related tickets to avoid duplicates
- **Multi-Agent System**: Uses three specialized AI agents for different tasks:
  - Classification Agent: Filters spam and identifies support requests
  - Solution Finder Agent: Searches knowledge base for solutions
  - Ticket Assembler Agent: Creates structured tickets with all necessary information

## 🏗️ Architecture

```
Email Inbox → HTML Filter → Email Filter → Classification Agent
                                              ↓
                                    Solution Search (Qdrant)
                                              ↓
                                    GLPI Ticket Creation/Update
                                              ↓
                                    Archive Processed Email
```

## 📋 Prerequisites

- n8n instance (v1.0+)
- GLPI server with API access
- Ollama for local LLM processing
- Qdrant vector database for knowledge base
- Microsoft Outlook account (or adaptable to other email providers)

## 🚀 Installation

1. **Import the workflow**
   - Open your n8n instance
   - Go to Workflows → Import
   - Import the `glpi-ai-workflow.json` file

2. **Configure credentials**
   - GLPI API credentials (App-Token and User-Token)
   - Ollama connection
   - Qdrant database connection
   - Email account credentials

3. **Update configuration**
   Replace the following placeholders in the workflow:
   - `YOUR_GLPI_SERVER`: Your GLPI server URL
   - `YOUR_APP_TOKEN_HERE`: Your GLPI App Token
   - `YOUR_USER_TOKEN_HERE`: Your GLPI User Token
   - `YOUR_MODEL_HERE`: Your preferred Ollama model (e.g., "mistral:latest", "llama2:13b")
   - `YOUR_FOLDER_ID_HERE`: Your email folder ID for incoming tickets
   - `YOUR_PROCESSED_FOLDER_ID`: Folder ID for processed emails
   - Email domain references (`@company.example`)

## ⚙️ Configuration

### AI Models
The workflow uses Ollama for local LLM processing. Recommended models:
- For classification: `mistral:latest` or `llama2:7b`
- For solution finding: `mistral:latest` or larger models for better accuracy
- For ticket assembly: Any model with good instruction following

### Vector Database
Set up Qdrant with your resolved tickets:
1. Create a collection named `company_tickets`
2. Index your resolved GLPI tickets
3. Use the same embedding model (default: `mistral:latest`)

### Email Filtering Rules
Customize the email filter rules in the "Email Filter" node to match your organization's needs:
- Exclude specific senders
- Filter by subject patterns
- Add custom exclusion rules

## 📊 Workflow Components

### 1. Email Processing
- **Microsoft Outlook Trigger**: Monitors inbox for new emails
- **HTML Filter**: Extracts clean text from HTML emails
- **Email Filter**: Pre-filters emails based on rules

### 2. AI Classification
- **Classification Agent**: Determines if email requires a ticket
- Categories: Hardware, Software, Network, Access, Telephony, Office 365, General Support

### 3. Solution Search
- **AI Solution Finder**: Searches knowledge base for similar resolved tickets
- **Qdrant Vector Store**: Semantic search through ticket history

### 4. Ticket Management
- **Check Recent Tickets**: Looks for related recent tickets
- **AI Ticket Assembler**: Structures ticket information
- **GLPI Integration**: Creates new tickets or adds followups

## 🔧 Customization

### Adding New Categories
Edit the category mapping in the "Prepare GLPI Data" node:
```javascript
const categoryMap = {
  "hardware": 1,
  "software": 2,
  "general support": 3,
  "network": 4,
  // Add your categories here
};
```

### Modifying Priority Rules
Adjust priority mapping in the same node:
```javascript
const priorityMap = {
  "low": 5,
  "medium": 3,
  "high": 1
};
```

### Changing AI System Prompts
Each AI agent has customizable system prompts that can be modified to fit your organization's needs. Access them in the respective agent nodes.

## 📝 Usage

1. **Activate the workflow** in n8n
2. **Emails are automatically processed** when they arrive in the monitored folder
3. The workflow will:
   - Filter out spam and non-support emails
   - Classify legitimate support requests
   - Search for existing solutions
   - Create or update GLPI tickets
   - Archive processed emails

## 🔍 Monitoring

### Execution Logs
- Check n8n execution logs for workflow status
- Monitor failed executions for troubleshooting

### GLPI Dashboard
- Review created tickets in GLPI
- Verify ticket categorization and priority
- Check linked tickets accuracy

## 🐛 Troubleshooting

### Common Issues

1. **API Authentication Errors**
   - Verify GLPI API tokens are correct
   - Check user permissions in GLPI
   - Ensure API is enabled in GLPI configuration

2. **LLM Model Errors**
   - Verify Ollama is running
   - Check model is downloaded (`ollama pull model_name`)
   - Ensure sufficient system resources

3. **Vector Database Connection**
   - Verify Qdrant is running
   - Check collection exists and contains data
   - Validate embedding model consistency

4. **Email Processing Issues**
   - Verify email folder IDs are correct
   - Check email account permissions
   - Review email filter rules

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- n8n community for the amazing workflow automation platform
- GLPI team for the powerful ticketing system
- Ollama for local LLM processing
- Qdrant for vector search capabilities

## 📞 Support

For issues and questions:
- Create an issue in this repository
- Check the [n8n community forum](https://community.n8n.io)
- Review [GLPI documentation](https://glpi-project.org/documentation/)

## 🗺️ Roadmap

- [ ] Multi-language support
- [ ] Enhanced solution matching algorithms
- [ ] Integration with more email providers
- [ ] Automatic ticket assignment based on expertise
- [ ] Performance metrics dashboard
- [ ] Automated responses for common issues
- [ ] Integration with chat platforms (Teams, Slack)
- [ ] Machine learning for improved classification

---

**Note**: This workflow processes sensitive data. Ensure proper security measures are in place and comply with your organization's data protection policies.