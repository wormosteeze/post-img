<h1>Post-Reimage CMD Finalization Script</h1>

<!-- ### [YouTube Demonstration](https://youtu.be/7eJexJVCqJo) -->

<h2>Description</h2>
This is a tool used for finalizing an end-user device after it has been reimaged. Some of these steps can and have been integrated into our imager since I created this script, but this tool served to make my process easier and more consistent from day to day.
<br />


<h2>Languages and Utilities Used</h2>

- <b>Windows Command Prompt</b>
- <b>PowerShell</b> 

<h2>Environments Used </h2>

- <b>Windows 10</b> (22H2)

<h2>Program walk-through:</h2>

The batch file is saved to an encrypted USB drive which must be run as administrator.<br/>
<br/>
<b>What the script does:</b>
- checks to make sure it is being run in an administrator Command Prompt instance
- has a set of power configuartion settings that can be triggered to set the device to never sleep or hibernate as is needed for some devices
- checks for certain department names, which are used in naming the device during imaging, to determine if a VPN configuration is needed for that department
- depending on department name, can also install programs needed for certain departments
  - programs are stored on the USB drive and transferred to a folder on the C drive for installation
  - desktop icons are added as needed
- checks device manufacturer info and launches script for that manufacturer which checks for system driver updates
  - also includes wifi-installation script
  - self-deletes to avoid wifi passwords being left in cleartext on the device
<!--
<p align="center">
Launch the utility: <br/>
<img src="https://i.imgur.com/62TgaWL.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Select the disk:  <br/>
<img src="https://i.imgur.com/tcTyMUE.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Enter the number of passes: <br/>
<img src="https://i.imgur.com/nCIbXbg.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Confirm your selection:  <br/>
<img src="https://i.imgur.com/cdFHBiU.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Wait for process to complete (may take some time):  <br/>
<img src="https://i.imgur.com/JL945Ga.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Sanitization complete:  <br/>
<img src="https://i.imgur.com/K71yaM2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Observe the wiped disk:  <br/>
<img src="https://i.imgur.com/AeZkvFQ.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
</p>
-->

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
