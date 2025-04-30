
# 📋 Trello List Copier (Ruby Script)

This Ruby script copies all lists (columns) and their cards from one Trello board (source) to another (destination) using the Trello API.

## 🚀 Features

- Copies all lists (columns) from a source board
- Copies all cards within each list
- Preserves card metadata like due dates, members, and labels

## 🔧 Requirements

- macOS or Unix-based system
- Ruby ≥ 3.1.2 (tested with 3.4.3)
- Trello account with access to both source and destination boards

## 💎 Install Ruby (via rbenv)

```bash
# 1. Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install rbenv and ruby-build
brew install rbenv ruby-build

# 3. Add rbenv to your shell config (for Zsh users)
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc

# 4. Install Ruby
rbenv install 3.4.3
rbenv global 3.4.3

# 5. Verify Ruby version
ruby -v
```

## 📦 Install Dependencies

```bash
gem install httparty
```

## 🔐 Trello API Setup

1. **Get your API Key**  
   👉 [https://trello.com/power-ups/admin/](https://trello.com/power-ups/admin/)  
   - Click **“Create a new Power-Up”** if needed  
   - Your **API Key** will be shown under the “API Key” column  

2. **Generate your OAuth Token**  
   Replace `<your_api_key>` below with your actual API key and visit:

   ```
   https://trello.com/1/authorize?key=<your_api_key>&name=TrelloListCopier&expiration=never&response_type=token&scope=read,write
   ```

   - Click **Allow**
   - Copy the token that appears

3. **Add your credentials to the script**:

```ruby
API_KEY = "your_api_key"
API_TOKEN = "your_generated_token"
```

## 🆔 Get Your Board IDs

Visit this URL with your key and token:

```
https://api.trello.com/1/members/me/boards?key=YOUR_API_KEY&token=YOUR_API_TOKEN
```

Find the board names and use the corresponding `"id"` values:

```ruby
SOURCE_BOARD_ID = "6811c0bb0c4d45b8afc31527"
DESTINATION_BOARD_ID = "6811c0cffbf90e67a97b275c"
```

## ▶️ Run the Script

```bash
ruby copy_trello_lists.rb
```

Or make it executable and run directly:

```bash
chmod +x copy_trello_lists.rb
./copy_trello_lists.rb
```

## ✅ Example Output

```text
Copying list: For the Manager
  Copying card: Define Q2 objectives
  Copying card: Finalise roadmap
✅ All lists and cards copied!
```

## 🧹 Troubleshooting

- ❗ `invalid value for idBoard` → Make sure your `DESTINATION_BOARD_ID` is correct
- ❗ `JSON::ParserError` → Print `response.body` before parsing to debug Trello API responses
- ❗ `multi_xml requires Ruby >= 3.1.2` → Use `rbenv` to upgrade Ruby as shown above

