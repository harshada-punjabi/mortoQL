//Get all characters
final String getAllCharacters = """
query allCharacters(\$page: Int!) {
  characters(page: \$page) {
    info {
      count
      pages
      next
    }
    results {
      id
      name
      species
      gender
      image
      created
    }
  }
}

""";

//Get all character details
final String getCharacterDetails = """
  query characterDetails(\$id: ID!) {
  character(id: \$id) {
    id 
    status
    type
    image
    origin {
      name
    }
    episode {
      episode
    }
  }
}""";

