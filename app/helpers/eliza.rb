require 'pat5'

module Enumerable
  def some?
    self.each do |v|
      result = yield v
      return result if result
    end
    nil
  end
end

class Array
  def random_elt
    self[rand(self.length)]
  end
end

class Rule
  attr_reader :pattern, :responses

  def initialize(pattern, *responses)
    @pattern, @responses = pattern, responses
  end

  ELIZA_RULES = 
    [
     Rule.new(Pattern.new(%w(*x hello *y)),
              "How do you do. Please state your problem"),
     Rule.new(Pattern.new(%w(*x I want *y)),
              "What would it mean if you got ?y?",
              "Why do you want ?y?",
              "Suppose you got ?y soon"),
     Rule.new(Pattern.new(%w(*x if *y)),
              "Do you really think it's likely that ?y? ",
              "Do you wish that ?y?",
              "What do you think about ?y?",
              "Really-- if ?y?"),
     Rule.new(Pattern.new(%w(*x no *y)),
              "Why not?",
              "You are being a bit negative",
              "Are you saying \"NO\" just to be negative?"),
     Rule.new(Pattern.new(%w(*x I was *y)),
              "Were you really?",
              "Perhaps I already knew you were ?y?",
              "Why do you tell me you were ?y now?"),
     Rule.new(Pattern.new(%w(*x I feel *y)),
              "Do you often feel ?y?"),
     Rule.new(Pattern.new(%w(*x I felt *y)),
              "What other feelings do you have?"),

     Rule.new(Pattern.new(%w(*x computer *y)),
              "Do computers worry you?",
              "What do you think about machines?",
              "Why do you mention computers",
              "What do you think machines have to do with your problem?"),
     Rule.new(Pattern.new(%w(*x name *y)),
              "I am not interested in names"),
     Rule.new(Pattern.new(%w(*x sorry *y)),
              "Please don't apologize",
              "Apologies are not necessary",
              "What feelings do you have when you apologize?"),
     Rule.new(Pattern.new(%w(*x I remember *y)),
              "Do you often think of ?y?",
              "Does thinking of ?y bring anything else to mind?",
              "What else do you remember?",
              "Why do you recall ?y right now?",
              "What in the present situation reminds you of ?y?",
              "What is the connection between me and ?y?"),
     Rule.new(Pattern.new(%w(*x do you remember *y)),
              "Did you think I would forget ?y?",
              "Why do you think I should recall ?y now?",
              "What about ?y?",
              "You mentioned ?y"),
     Rule.new(Pattern.new(%w(*x I dreamt *y)),
              "Really-- ?y?",
              "Have you ever fantasized ?y while you were awake?",
              "Have you dreamt ?y before?"),
     Rule.new(Pattern.new(%w(*x dream about *y)),
              "How do you feel about ?y in reality?"),
     Rule.new(Pattern.new(%w(*x dream *y)),
              "What does this dream suggest to you?",
              "Do you dream often?",
              "What persons appear in your dreams?",
              "Don't you believe that dream has to do with your problem? "),
     Rule.new(Pattern.new(%w(*x my mother *y)),
              "Who else in your family ?y?",
              "Tell me more about your family"),
     Rule.new(Pattern.new(%w(*x my father *y)),
              "Your father?",
              "Does he influence you strongly?",
              "What else comes to mind when you think of your father?"),
     Rule.new(Pattern.new(%w(*x I am glad *y)),
              "How have I helped you to be ?y?",
              "What makes you happy just now?",
              "Can you explain why you are suddenly ?y?"),
     Rule.new(Pattern.new(%w(*x I am sad *y)),
              "I am sorry to hear you are depressed",
              "I'm sure it's not pleasant to be sad"),
     Rule.new(Pattern.new(%w(*x are like *y)),
              "What resemblance do you see between ?x and ?y?"),
     Rule.new(Pattern.new(%w(*x is like *y)),
              "In what way is it that ?y is like ?y?",
              "What resemblance do you see?",
              "Could there really be come connection?",
              "How?"),
     Rule.new(Pattern.new(%w(*x alike *y)),
              "In what way?",
              "What similarities are there?"),
     Rule.new(Pattern.new(%w(*x same *y)),
              "What other connections do you see?"),
     Rule.new(Pattern.new(%w(*x was I *y)),
              "What if you were ?y?",
              "Do you think you were ?y?",
              "What would it mean if you were ?y?"),
     Rule.new(Pattern.new(%w(*x I am *y)),
              "In what way are you ?y?",
              "Do you want to be ?y?"),
     Rule.new(Pattern.new(%w(*x am I *y)),
              "Do you believe you are ?y?",
              "Would you want to be ?y?",
              "You wish I would tell you you are ?y",
              "What would it mean if you were ?y?"),
     Rule.new(Pattern.new(%w(*x am *y)),
              "Why do you say 'AM'? ",
              "I don't understand that"),
     Rule.new(Pattern.new(%w(*x are you *y)),
              "Why are you interested in whether I am ?y or not?",
              "Would you prefer if I weren't ?y? ",
              "Perhaps I am ?y in your fantasies?"),
     Rule.new(Pattern.new(%w(*x you are *y)),
              "What makes you think I am ?y?"),
     Rule.new(Pattern.new(%w(*x because *y)),
              "Is that the real reason?",
              "What other reasons might there be?",
              "Does that reason seem to explain anything else?"),
     Rule.new(Pattern.new(%w(*x were you *y)),
              "Perhaps I was ?y",
              "What do you think?",
              "What if I had been ?y"),
     Rule.new(Pattern.new(%w(*x I can't *y)),
              "Maybe you could ?y now",
              "What if you could ?y?"),
     Rule.new(Pattern.new(%w(*x I *y you *z)),
              "Perhaps in your fantasy we ?y each other"),
     Rule.new(Pattern.new(%w(*x why don't you *y)),
              "Should you ?y yourself?",
              "Do you believe I don't ?y? ",
              "Perhaps I will ?y in good time"),
     Rule.new(Pattern.new(%w(*x yes *y)),
              "You seem quite positive",
              "You are sure?",
              "I understand"),
     Rule.new(Pattern.new(%w(*x someone *y)),
              "Can you be more specific?"),
     Rule.new(Pattern.new(%w(*x everyone *y)),
              "Surely not everyone?",
              "Can you think of anyone in particular?",
              "Who for example?",
              "You are thinking of a special person"),
     Rule.new(Pattern.new(%w(*x always *y)),
              "Can you think of a specific example?",
              "When?",
              "What incident are you thinking of?",
              "Really-- always?"),
     Rule.new(Pattern.new(%w(*x what *y)),
              "Why do you ask?",
              "Does that question interest you?",
              "What is it you really want to know?",
              "What do you think?",
              "What comes to your mind when you ask that?"),
     Rule.new(Pattern.new(%w(*x perhaps *y)),
              "You do not seem quite certain"),
     Rule.new(Pattern.new(%w(*x are *y)),
              "Did you think they might not be ?y?",
              "Possibly they are ?y"),
     Rule.new(Pattern.new(%w(*x)),
              "Very interesting",
              "I am not sure I understand you fully",
              "What does that suggest to you?",
              "Please continue",
              "Go on",
              "Do you feel strongly about discussing such things?"),


    ]
end

module Eliza
  class << self
    def run(rules = Rule::ELIZA_RULES)
      while true
        print "eliza> "
        puts eliza_rule(gets.downcase.split, rules)
      end
    end

    def respond(input, rules = Rule::ELIZA_RULES)
        eliza_rule(input.downcase.split, rules)
    end
    
    def eliza_rule(input, rules)
      rules.some? do |rule|
        result = rule.pattern.match(input)
        if result
          switch_viewpoint(result).inject(rule.responses.random_elt) do |sum, repl|
            sum.gsub(repl[0], repl[1].join(" "))
          end
        end
      end
    end
    
    def switch_viewpoint(words)
      replacements = [%w(I you), 
                      %w(you I), 
                      %w(me you), 
                      %w(am are)]
      hash = {}
      words.each do |key, val|
        hash[key] = replacements.inject(val) do |sum, repl|
          sum.map { |val| val == repl[0] ? repl[1] : val}
        end
      end
      hash
    end
  end
end

if __FILE__ == $0
  Eliza.run
end
