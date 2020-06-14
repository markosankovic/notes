# Notes

## Mon May 25, 2020

Frank helped me with recovering the malfunctioning Drive 400. He ran the following commands:

```sh
ethercat pdos
ethercat reg_read 0x134 2
ethercat reg_read 0x30 2
ethercat reg_read 0x130 2
ethercat sii_read -v

Withdraw EEPROM control.
SII Area:
  08 0e
```

He looked at the first hex values and they were different than `08 0e`. He said that those hex values indicate that sii was written for Circulo. This is probably true because on Friday I was testing Circulo by writing `.hardware_description` and I downgraded the firmware version and possibly the tools loaded the list of packages for Circulo.

On Friday I got:

```sh
ethercat sii_read -v
Withdraw EEPROM control.
```

Frank also gave me `ethercat_reclaim_esi` that could fix the error I had: cannot switch to BOOT from INIT E and no file operations supported. That script was hanging.

The fix is simple: extract the sii file from the package for the drive e.g. Drive 400 and write it with `ethercat sii_write -f et1100.sii`.

ET110 contains data about registers.

## Thu May 28, 2020

### SMM WI-409 deep dive Meeting with Nikola and James

<https://www.wrike.com/open.htm?id=512198677>

Two documents:

- Software Requirements Specification Safe Motion Module (SMM) 40701_SWRS.docx
- SOMANET Safe Motion Module (SMM) Requirements Specification

4.1.4.1 Safety parameter download

WI-409 - Parameter download process

Login to SMM with password and then user uploads parameters in some binary format. This file format is used by SMM to change the configuration, check and store parameters. Sends parameters somehow back to a user and there is a loop where user verifies the parameters. Two screens to compare input and set parameters. Then there is a request that parameters are verified.

The binary format is a big topic how to encode it. SMM enters safe state. Checks the received parameters for plausability.

How do you verify. Verify with CRC.

Two different processes: different parameters for verifying and validating. Verify is that you did what you said you're gonna do and validate is confirmation that they're the parameters you want to use. Validation makes sense, verification is what it is. Not totally sure about validation.

Text dump for user to sign.

Safety IF goes from SoC to SMM. FoE to Drive. Two components: upload bin file over FoE and command get that file and upload it and SMM service will use the service to upload bin. FoE to get the file and other the OS command to trigger that action. And other checks validation verifications should be through OS commands. Arbitrary commands. Baud rate of the interface no objects for that. Setup of BiSS sensor does something similar.

Data dictionary: 40701_Data_Dictionary_V0.2.pdf

Who checked and validated the parameters. Delete parameters.

TODO: Create a JSON model from the Mesco dictionary. Keep the JSON file on drive. Use JSON for the UI and making binary.

## Sun Jun 7, 2020

Created VM using `debian-10.4.0-amd64-netinst.iso`.

Problem running Docker containers. This fixed:

```sh
sudo pip uninstall backports.ssl-match-hostname
sudo apt-get install python-backports.ssl-match-hostname
```

See: https://stackoverflow.com/questions/42695004/importerror-no-module-named-ssl-match-hostname-when-importing-the-docker-sdk-fo

