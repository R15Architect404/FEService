# FEService

A simple service/module for all your FE (real) needs (literally)

will be adding more FE (real) stuff if i'm not busy 

everything in this module is FE (real) and replicates.

Works in Synapse X, KRNL, ScriptWare



# DOCS

```
<void> FE:FullNetwork() -- Makes your Player have full physics capabilities
<string> FE:Chat(string) -- Fires .Chatted event with the string provided
<void, int> FE:GrabTools(num) -- Grabs ALL "Grabbable" tools parented in workspace, with an optional grab limit
<instance[BasePart]> FE:ClaimPart(Part) -- Claims a basepart using networkOwnership and make it not sleep
<instance[BasePart]> FE:UnclaimPart(Part) -- Unclaims a basepart that was claimed using FE:ClaimPart()
<int, bool> FE:SetHumanoidAnimationSpeed(Speed) -- Changes your humanoid animation speed (looped), pass a false bool to disable
<instance[Humanoid]> FE:ReplicateJump(Humanoid) -- Makes the Humanoid provided jump.
<int> FE:ReleaseCharacter(num) -- Makes the server "networkOwner" of your own Character for a number of seconds
<int[HumanoidState], string[HumanoidState]> FE:ChangeState(State) -- Changes your Humanoid's State with the given state on loop (Optional Humanoid argument soon)
<int, void> FE:UnChangeState(num) -- Disables the FE:ChangeState() function, pass a number to only disable it in a given amount of time.
```
