module StaticPagesHelper
  #Available Phrases
  @@phrases = ["La Fiona y el Ulicho te saludan.",
             "Pompo!",
             "I loooooooove you!",
             "Fiona, 50% perro,50% puerco, 100% actitud.",
             "Being a punk is also an illness!",
             "I'm a shimmering beacon of lust.",
             "My log does not judge.",
             "Aren't you too old to be out whorin'?",
             "Look at my horse! My horse is amazing!",
             "You're pale as oaty shite."]
  #Say hi to user!
  def say_hello
    @@phrases.sample
  end
end
