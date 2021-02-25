import ../src/protocol

when isMainModule:
  block parseMessageTest:
    block testOne:
      let 
        data = """ {
            "username": "Alisher",
            "message": "Hello!"
          } """

        parsed = parseMessage(data)
    
      try:
        doAssert parsed.username == "Alisher"
        doAssert parsed.message == "Hello!"
        echo "Test #1 passed"
      except:
        quit "Test #1 failed"

    block testTwo:
      let
        data = """ {
            "username" : "Steve",
            "message": "Hi Tony"
          } """
        parsed = parseMessage(data)
      
      try:
        doAssert parsed.username == "Steve"
        doAssert parsed.message == "Hi Tony!"
        quit "Test #2 failed"
      except:
        echo "Test #2 passed"
  
  block createMessageTest:
    block whiteBox:
      let
        expected = """{"username":"Alish","message":"Hello World!"}""" & "\c\l"
        created = createMessage("Alish", "Hello World!")
      
      try:
        doAssert created == expected
        echo "Test #3 passed"
      except:
        quit "Test #3 failed"
    block blackBox:
      let
        expected = """{"username":"Alish","message":"Hello World!"}""" & "\c\l"
        created = createMessage("Ali", "Hello World!")

      try:
        doAssert expected != created
        echo "Test #4 passed"
      except:
        quit "Test #4 failed"

  echo "All tests passed!"
