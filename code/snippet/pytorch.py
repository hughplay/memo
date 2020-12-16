# General process
data, target = data.to(device), target.to(device)
model.train()
optimizer.zero_grad()
output = model(data)
loss = F.nll_loss(output, target)
optimizer.step()
print(loss.item())

# Backward through the graph a second time
# https://discuss.pytorch.org/t/runtimeerror-trying-to-backward-through-the-graph-a-second-time-but-the-buffers-have-already-been-freed-specify-retain-graph-true-when-calling-backward-the-first-time/6795
y = model(x)
model.zero_grad()
out_1 = f(y)
out_1.backward(retain_graph=True)
opt_1.step()
model.zero_grad()
out_2 = g(y)
out_2.backward()
opt_2.step()
