# Elixir code runs inside proceses
# They are isolated run concurrent to one another and communicate via message passing
# Basis for concurrency in Elixir and provide means for distributed fault-tolerant programs
# Processes are very lightweight, hence its not uncommon to have several thousand processes simultaneously

# spawn/1 creates new processes
spawn fn -> 1 + 2 end #=> #PID<0.43.0>

# spawn/1 takes a function which it will execute in another process
# It returns a PID, at which point the process is likely dead
# The process will execute the function and exit after completion

pid = spawn fn -> 1 + 2 end #=> #PID<0.44.0>
Process.alive?(pid)

# self/1 returns the PID of the current process
self() #=> #PID<0.41.0>
Process.alive?(self()) #=> true

# Send and recieve messages from processes using send/2 and recieve/1
send self(), {:hello, "hello"} #=> {:hello, "world"}
receive do
  {:hello, msg} #=> msg
  {:world, msg} #=> "won't match"
end #=> "world"

# When a message is sent it is stored in the process mailbox
# recieve/1 goes through the current process mailbox searching for a message that matches
# recieve/1 supports guards and many clauses such as case/2
# If there is no message in the mailbox matching any patterns the current process will wait for a matching message to arrive.
# A timeout can be specified

receive do
  {:hello, msg} -> msg
after
  1_000 -> "nothing after 1s"
end #=> "nothing after 1s"

# A timeout of 0 can be given if the message is expected to already be in mailbox

# Sending messages between processes
parent = self() #=> #=> #PID<0.41.0>
spawn fn -> send(parent, {:hello, self()}) end #=> #PID<0.48.0>

receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end #=> "Got hello from #PID<0.48.0>"

# flush/0 flushes and prints all messages in the mailbox
send self(), :hello #=> :hello
flush() #=> :hello \n :ok
