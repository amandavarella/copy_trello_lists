require 'httparty'
require 'json'

API_KEY = ""
API_TOKEN = ""
SOURCE_BOARD_ID = ""
DESTINATION_BOARD_ID = ""

BASE_URL = "https://api.trello.com/1"

def get_lists(board_id)
  url = "#{BASE_URL}/boards/#{board_id}/lists?cards=open&key=#{API_KEY}&token=#{API_TOKEN}"
  response = HTTParty.get(url)
  JSON.parse(response.body)
end

def create_list(board_id, name)
  url = "#{BASE_URL}/lists"
  response = HTTParty.post(url, query: {
    key: API_KEY,
    token: API_TOKEN,
    idBoard: board_id,
    name: name,
    pos: "bottom"
  })
  JSON.parse(response.body)
end

def copy_card(card, new_list_id)
  url = "#{BASE_URL}/cards"
  HTTParty.post(url, query: {
    key: API_KEY,
    token: API_TOKEN,
    idList: new_list_id,
    name: card['name'],
    desc: card['desc'],
    due: card['due'],
    idMembers: card['idMembers'].join(','),
    idLabels: card['idLabels'].join(',')
  })
end

def copy_lists_and_cards(source_board_id, destination_board_id)
  source_lists = get_lists(source_board_id)

  source_lists.each do |list|
    puts "Copying list: #{list['name']}"
    new_list = create_list(destination_board_id, list['name'])
    list['cards'].each do |card|
      puts "  Copying card: #{card['name']}"
      copy_card(card, new_list['id'])
    end
  end
  puts "✅ All lists and cards copied!"
end

copy_lists_and_cards(SOURCE_BOARD_ID, DESTINATION_BOARD_ID)
