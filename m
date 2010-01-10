From: Guillaume FORTAINE <gfortaine@live.com>
Subject: Intel Rapid Boot Toolkit - UEFI Hypervisor : Cloud Computing Firmware
	/ Firmware-as-a-Service
Date: Sun, 10 Jan 2010 20:55:24 +0100
Message-ID: <BLU0-SMTP1715009C1002A1EEF1CFF7C86E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Misters,

Happy New Year to you.

Let me introduce myself : Guillaume FORTAINE, Engineer in Computer
Science. I am currently working on a Cloud Computing Firmware in
an Infrastructure-as-a-Service context.

The product is an UEFI Hypervisor. It puts virtualization exactly
where it belongs: Into the firmware [0]

Customers will be able to deploy their appliances and products
directly to new hardware - without headaches due to the underlying
technology.

It will enable scalability through high-end technology on their x86
bases server systems.

My Business Model comes from this fairly simple question :

What is the value-added from an OEM point of view to need 3rd parties
to provide an Hypervisor Layer knowing that Virtualization is a
feature from the Hardware (so it belongs to the CPU / Chipset / OEM
World) and they are not necessary to enable it (coreboot AVATT
prototype is the most successful example [1]),
however they are making the greatest benefits from it ?


To quote [2] :

"There's actually a lot to be said for the embedded hypervisor. Lots
of IT environments--especially enterprise ones--do indeed have a mix
of  operating systems  and operating system versions. Given that,
there is indeed a lot to be said for the idea  that hypervisors just
come with the server as a sort of superset to the firmware, like BIOS,
already loaded on every system. Then IT administrators could  just
configure any guest OSs they want on top."


That's why I am currently going further since the first successful 
prototype of
the coreboot GSOC project AVATT (All Virtual All The Time) [1].

Coreboot is an open source hardware initialization firmware. It does
some basic hardware init, then hands over control to one of many
possible payloads.

This Google Summer of Code sponsored project suggested the idea
of implementing a Linux kernel with KVM (Kernel Virtual
Machine to provide Type I Hypervisor abilities to Linux) as a coreboot
payload (=Virtualization inside the BIOS).

However, after several discussions with leading OEMs inside the UEFI 
Forum, I
realized that coreboot was not a convenient choice as a Platform
Initialization code :

With the processors and chipsets being mostly commodity (at least
identical between IHVs), there is little room in the platform for
vendors such as Dell, IBM, and HP to differentiate between each other
on features, so all have chosen to implement features in BIOS as one
differentiation location.

CoreBoot is interesting, in that it could remove even that level of
differentiation capability between the vendors; or it could provide
the ultimate in end user customization (hardware/firmware-as-a-service
models, or eliminate-the-IHV models).

They are exploring if/how they can utilize CoreBoot, for specific
customers, but simply do not see the broad market demand for CoreBoot
to displace their entrenched development projects (legacy BIOS and
UEFI), again, they simply don't have the resources needed to keep many
separate streams of BIOS-level development going at once, when it's
not clear there could be any ROI for adding CoreBoot in a general
product offering.

Moreover, there are many liability and ownership issues due to its 
GPL-Licence.


So, that's why after a thorough research work,  I definitely believe
that the Intel Rapid Boot Toolkit [3] could be the perfect BIOS Framework
knowing that it is UEFI-Based and that it provides a Linux payload,
like coreboot, enabling a Firmware-as-a-Service Model.

To quote [4]:

"Intel, Dell, and servers that change with the phases of the moon

As we reported a while back, Dell is looking to bundle a hypervisor on
the motherboard using flash, so that the hypervisor loads first and
then loads the OS. Even more importantly, Intel itself headed in this
direction with their line of server boards that use the company's
Rapid Boot Toolkit. Both of these are efforts that bring lightweight,
task-specific, widget-like personalities to high-powered server
hardware.

Intel's Rapid Boot Toolkit is basically the same as what Dell is
planning (i.e., a pool of embedded flash boots a hypervisor, which
then loads the OS), but Intel is already there with a line of server
motherboards. Furthermore, the beauty of Intel's scheme is that the
hypervisor can pull an OS image from over the network and load the
image on the system without ever spinning up the hard drive. This
functionality replaces the standard Linux PXE boot, and it can be done
with Windows, as well."



The value-added move to the payload ( Firmware-as-a-Service ) and it
will be portable across all OEMs products (ensuring Linux Device Drivers
compatibility for IOMMU to provide High-Performance Hardware
Virtualization : Infrastructure-as-a-Service).

The Platform Initialization becomes secondary and Hardware Vendors can
provide a closed UEFI Platform Initialization code to protect their
value-add features.

I have currently a team of Linux-From-Scratch / Embedded experts
who will provide engineering support for a custom Rapid Boot Toolkit.

Thanks to this one, we will be able to create a Cloud Computing
Firmware. The functional specifications of this one are :

a) Smart (WBEM : SLP + CIM + SSL/TLS) [5]

b) Virtual Hypervisor (Linux + KVM + IOMMU)


This is Firmware Engineering at the highest-level, not 'marketing fluff'
like Citrix Xen for OEMs or VMWare ESXi, because it will be the first
true Bare-Metal Hypervisor  in the World and I definitely believe that
it could revolutionize the industry.


I would greatly appreciate to know if I would be able to make a
partnership with the Linux Foundation to sponsor this project, if 
possible, please.

To realize this project, I am currently asking two things, if
possible, please :

1) Intel Rapid Boot Toolkit [3]


2) Server Board with :

a) IOMMU : Intel VT-d2/AMD IOMMU

b) ROM chip socketed

c) UEFI Firmware

c) Numonyx Forte M25P128 [6]



I look forward to your answer,

Best Regards,

Guillaume FORTAINE

[0] 
http://x86asm.net/articles/uefi-hypervisors-winning-the-race-to-bare-metal/
[1] http://www.coreboot.org/AVATT
[2] http://news.cnet.com/8301-13556_3-10170884-61.html
[3] http://www.intel.com/design/servers/ism/rbt/index.htm
[4] 
http://arstechnica.com/business/news/2007/11/split-personalties-new-hypervisorflash-combos-mean-an-os-is-just-one-way-to-boot.ars
[5] http://icac2009.acis.ufl.edu/files/presentations/Kinzhalin.pdf
[6] http://www.numonyx.com/en-US/MemoryProducts/NORserial/Pages/M25P.aspx
