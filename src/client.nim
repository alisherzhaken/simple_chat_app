import os, threadpool, asyncdispatch, asyncnet
import protocol

proc connect(socket: AsyncSocket, serverAddr: string) {.async.} = 
  echo "Connecting to ",serverAddr
  await socket.connect(serverAddr, Port(7687))
  echo "Connection successfull"

  while true:
    let 
      line = await socket.recvLine()
      parsed = parseMessage(line)
    echo parsed.username, ": ", parsed.message

echo "Chat application started"
if paramCount() == 0:
  quit "Please specify the server address, e.g. ./client localhost"

let serverAddr = paramStr(1)
let username = paramStr(2)
var socket = newAsyncSocket()
asyncCheck connect(socket, serverAddr)

var messageFlowVar = spawn stdin.readLine()
while true:
  if messageFlowVar.isReady():
    let message = createMessage(username, ^messageFlowVar)
    asyncCheck socket.send(message)
    messageFlowVar = spawn stdin.readLine()

  asyncdispatch.poll()
