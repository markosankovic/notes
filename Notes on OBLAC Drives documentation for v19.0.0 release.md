# Notes on OBLAC Drives documentation for v19.0.0 release

## https://www.synapticon.com/products/somanet/somanet-oblac-drives

First if you look at the URL there is *somanet-oblac-drives* at the end, but the title is *SOMANET OBLAC TOOLS*. As for the tools team (Nikola, James, Romy, Marko) OBLAC Tools refer to all software that the tools team make. That is EDT, System Designer, CANopen Profiles, OBLAC Drives, Inventory... As already mentioned oblak translates to cloud, so cloud tools, runs on cloud infrastructure (preferably) uses web technologies those are the traits or common characteristics.

SOMANET OBLAC Drives is our only public software, therefore I would rename the links, title on our website to SOMANET OBLAC Drives. Also the documentation is about OBLAC Drives and not OBLAC Tools.

> Commissioning and tuning tool for SOMANET Servo Drives.
> Commissioning of your SOMANET Drive must be as easy as ...

Why do we use SOMANET Servo Drives in the first and SOMANET Drive in the second paragraph. From what I know those are not synonyms, SOMANET Drive term is a group of drive modules such as SOMANET Drive 1000, but SOMANET Servo Drives is a bit tricky for me at least, my guess is it's a synonym for SOMANET Servo Node.

> Any number of SOMANET nodes can be connected to the PC running OBLAC Drive Tools using a single fieldbus cable. The firmware of each node can be installed or updated individually or simultaneously.

Yet again, *SOMANET nodes*, how is that different to *SOMANET Servo Drives* vs *SOMANET Drive* vs *SOMANET Servo Node*?

And *OBLAC Drive Tools*, that's not *OBLAC Tools* or *OBLAC Drives*.

> Test and evaluate your system without setting up and running a motion application. Operate the drive in Torque, Speed and Position mode and evaluate the performance using advanced scope features like math, triggers, recording and more.

Scope features like math, triggers, recording are a lie, because we don't have those features implemented.

We must update all screenshots, images and animated gifs.

## https://doc.synapticon.com/oblac_drives/index.html

> OBLAC Drives makes operating SOMANET drives based on EtherCAT a breeze. It guides the user through the setup process, supports configuration and tuning of the SOMANET drive stack and makes the operation and first steps in turning a motor as easy as possible.

> OBLAC Drives makes operating SOMANET Servo Drives a breeze. It guides the user through the setup process, supports configuration and tuning of SOMANET Servo Drives and makes operation and first steps in tuning a motor as easy as possible.

**Rationale**: We should be consistent with the naming, e.g. *SOMANET drives based on EtherCAT* and *SOMANET drive stack* both found in the previous paragraph refer to the same thing. On our website we refer to that as SOMANET Servo Drives. Even the ACTILINK that tools will support is described as motor-integrated servo drives. The description on our website for OBLAC Tools is: *Commissioning and tuning tool for SOMANET Servo Drives*. Now, OBLAC Tools is an umbrella term for all tools developed in the company. OBLAC Drives and OBLAC EtherCAT Design Tool are software products under OBLAC Tools.

> Synapticon OBLAC Drives is delivered as a VMware Image to run a Linux virtual machine containing Synapticon EtherCAT Tuning Tools.

> OBLAC Drives is delivered through the downloadable virtual machine (OBLAC Drives VM) or a physical machine<sup>[[1]]</sup> (OBLAC Drives Box).
> Why can't I just install OBLAC Drives? OBLAC Drives uses the EtherCAT Master that runs as a Linux kernel module and it consists of multiple  services running on a host. In order to support all major platforms we created the virtual machine based on Linux OS, that runs EtherCAT Master as a kernel module and all of the required services.

**Rationale**:  Why *Synapticon OBLAC Drives*, from website it's *SOMANET OBLAC Drives*. Is it okay to remove SOMANET? We actually deliver the virtual machine in OVA format which stands for Open Virtualization Format. VMware is not the only virtualization software that can import it, but VirtualBox as well and with small changes to network adapter names it is possible to use it. Anyway, we recommend VMware because it works out--ofbox. The second question/answer paragraph is there for users that are used to desktop applications and download, install, run way of getting software. It states the reasons why we must run OBLAC Drives in a virtual machine: 1) multi-platform support, 2) due to multiple processes/services that make the application, 3) due to EtherCAT Master which must run under Linux OS. Introducing *OBLAC Drives VM* and *OBLAC Drives Box* makes a nice disctinction.

> Set up your OBLAC Box - OBLAC Box is a convenient way to commission your Node with the latest version of OBLAC Drives.

> OBLAC Drives Box - OBLAC Drives Box is a physical machine that comes preinstalled with OBLAC Drives.

**Rationale**: The description doesn't really distinquish OBLAC Drives Box from VM - they both are a convenient way to commision the SOMANET Servo Nodes with *any* version of OBLAC Drives. In future we are going to run RTOS on OBLAC Drives Box and offer improved or let's say predictable execution. Motion Master will be a production-grade motion framework capable of executing custom code. Consistent naming, so instead of OBLAC Box it must always be OBLAC Drives Box. So, when someone asks what is OBLAC Drives Box, the answer is: OBLAC Drives Box is a physical machine that comes preinstalled with Linux OS and runs OBLAC Drives and the related services.

> Installation Guide - OBLAC Drives runs on Linux, Windows and macOS.

> OBLAC Drives VM - OBLAC Drives VM is downloadable virtual machine that comes preinstalled with OBLAC Drives.

**Rationale**: *Installation Guide* is ambiguous. OBLAC Drives VM page provides instructions on how to download, open and configure VM on the target platform. I think that names *OBLAC Drives Box* and *OBLAC Drives VM* make a good contrast. In that regard we are going to rename oblac-drives-box.ova to just oblac-drives.ova (as is the case now download link).

> Set up your drive system - How to set parameters for your Motor and Sensors correctly.
> Tune your drive - Each motor needs to be tuned before it is operational.

> Set up your servo drive - Instructions on how to install firmware and configure your motor, brake and sensors.
> Tune your servo drive - Instructions on how to do manual and automatic tuning of your servo drive.

**Rationale**: What is the drive system? How is it different than servo drive? For *Tune your drive*, what is *drive* is it *servo drive*? What is the difference between servo system and servo drive? Should we maybe use *SOMANET Servo Node* instead of *servo drive*.

> Tutorial: Motion Control System - Use the playground to rotate the motor to defined position or at defined torque.

> Tutorial: Motion Control System - Use the Playground to rotate a motor to the target position or torque.

**Rationale**: There is only one Playground therefore capitalized first letter of a noun. Consistency in naming - target vs defined position or torque.

> Update OBLAC Drives - You may update your OBLAC Drives any time with our update tool.

> Update OBLAC Drives - Use the provided OBLAC Drives Update Service to install and run any version of OBLAC Drives.

**Rationale**: *Update tool* is ambiguous. We also provide a kind of update tool for SOMANET Software. In order to avoid misunderstanding in writing and conversation things should be called by their full name, so instead of *update tool* it's *OBLAC Drives Update Service*. With OBLAC Drives Update Service users can install any version of OBLAC Drives, *at any time* is surplus.

Gif https://doc.synapticon.com/_images/Autotunining_OBLAC_Drives2.gif must be replaced with the latest look of OBLAC Drives.

## https://doc.synapticon.com/oblac_drives/oblac_box_setup/index.html

> OBLAC Drives Box is a small computer with WiFi access that runs a minimal operating system and EtherCAT master. The OBLAC Drives commissioning software and update service are pre-installed.

> OBLAC Drives Box is a physical machine that comes preinstalled with Linux OS and runs OBLAC Drives and the related services. It supports access over WiFi or local network.

**Rationale**: Not quite sure about the description. Anyway, whatever the description it has to be consistent.

> Installation
> Optionally, connect the box to your local area network using the upper LAN port. This is necessary if you want to commission the SOMANET Servo Node through the network rather than via wireless.

> ... This will allow you to access OBLAC Drives tool over the local area network rather than having to connect to OBLAC Drives Box over WiFi.

**Rationale**: Provisioning is really done over EtherCAT. Only the access to OBLAC Drives application is somewhat different whether you use WiFi access or local area network.

> Connect to the GUI

> Open OBLAC Drives

**Rationale**: We are not really connecting, that implies some kind of software connection. Wa are opening an URL in our browser that will serve the OBLAC Drives application. It could also be *Access OBLAC Drives*.
Sticker image must be updated. The IP address is not preferred anymore, but rather the assigned domain name. So, the application is available at http://oblac-drives-*network-name*.local and *network-name* is really a unique OBLAC Drives Box identifier. For Windows the mDNS domain name will not resolve without having Bonjour software, so instruction on installation are required.

I would say the preferred method to access OBLAC Drive application is to have box connected to a local network. WiFi access in documentation should come later, with something like: 'It is also possible to connect to OBLAC Drives Box over Wifi...'.

> Open a web browser to the IP stated on the sticker (192.168.0.1 by default)
> A pre-installed version of OBLAC Drives will open. You can access your Node by WiFi.

> This not required and especially *You can access your Node by WiFi*. What is Node here? It's better to say in step 2: Open OBLAC Drives in your browser by navigating to http://oblac-drives-12345fad.local

My personal preference is to use first uppercase letter for the Internet<sup>[[2]]</sup>.

> Accessing the Internet

Remove this section. We need to add another link below OBLAC Drives Box and OBLAC Drives VM called Updating OBLAC Drives where we are going to describe how to use OBLAC Drives Update Service, how we match the supported firmwares etc. We need to explain that it is possible to use OBLAC Drives Box offline and to install and run the previous versions of OBLAC Drives. Newer versions of OBLAC Drives that get installed will be cached on the box, but they will have to be downloaded from the Internet.

OBLAC Drives Box acts as NAT and so when connected over WiFi and if the box is connected to the Internet over LAN then the connected computer will have the Internet access.

We must remove IP discovery. That is not requred anymore and the service (IP Addr Service) will be removed.

> That’s it! You may now proceed to Commision your Node

> That's it! You may now proceed to commision your SOMANTE Servo Node.

## https://doc.synapticon.com/oblac_drives/oblac_drives_setup/index.html

> System Requirements

> I would replace it Prerequeisite or Required Software and write that OBLAC Drives VM is a virtual machine that you as a user should run on VMware Player version 14 or above for Windows and Linux and VMware Function 10 for macOS and provide links to VMware website.

> Note
> OBLAC Drives runs in your browser and has been successfully tested with Google Chrome (Version 63.0.3239.132 and above). Other browsers or older versions of Chrome may also be supported but can’t be recomended.

> OBLAC Drives is application that runs in a Web Browser. We recommend Google Chrome as of version 63. OBLAC Drives will work on other browsers, but they are not recommended.

List of operating systems: well, Debian as well because the VM runs Debian.
Works on VMware Workstation Player 15 as well.

> Download the latest OBLAC Drives image

> Latest and OBLAC Drives image should not be used, but rather Download OBLAC Drives VM.

> 3. Open a virtual machine
> 4. Select the downloaded OBLAC Drives image (OVA file) and import it to VMware Player

A bit strange, shouldn't this be one step instead: Click on File/Open a Virtual Machine and select the downloaded OBLAC Drives VM (oblac-drives.ova) file.

> If you get a warning that the import failed, just click “Retry” and it will run.

We should write the reason why the import fails.

> Step 5. should only have the network configuration, processor is not required any more. Images must be replaced.

> There should be two network adapters available - one set to NAT and one set to bridged. I would write bridged as Bridged (Automatic) exactly as on the screenshot.

> Add them if any of them are missing

> Remove this, they are always going to be there, this is part of te ova file.

> Press OK to save changes

> Obvious by I would write something like press OK in Automatic Bridging Settings dialog and then OK on Virtual Machine Settings dialog to save the changes

> Play the virtual machine

> Actually, the VMware term is *Power On*, so maybe the full instruction right click on oblac-drives-box in the list of VMs and then click on *Power On*

> Connecting to OBLAC Drives

> Open OBLAC Drives

> Shutting down the Virtual Machine

> I would remove this, or add it as a note on the bottom of Getting Started. It is not that much important to require its own section.

Replace image for Welcome screen. It looks a bit different now and runs Debian.

> Now you are ready to use the features of OBLAC Drives!

Unnecessary I think.

## https://doc.synapticon.com/oblac_drives/oblac_drives_commissioning/index.html

> Please make sure to select a firmware that fits your version of the Drive module.

It is impossible to select a firmware that doesn't fit the version of the Drive module. Now, yet again term *Drive module*. Is it the same as SOMANET Servo Drive?

## Links

[1]: https://searchenterprisedesktop.techtarget.com/definition/physical-computer
[2]: https://en.wikipedia.org/wiki/Capitalization_of_Internet
[3]: http://blog.hoxnox.com/gentoo/wifi-hotspot.html

## Draft

A physical computer (sometimes called a physical machine or a physical box) is a hardware-based device, such as a personal computer. The term is generally used to differentiate hardware-based computers from software-based virtual machines (VMs).

Some guides specify that the word should be capitalized as a noun but not capitalized as an adjective, e.g., "internet resources".
