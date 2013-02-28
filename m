From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio PCI on KVM without IO BARs
Date: Thu, 28 Feb 2013 17:24:33 +0200
Message-ID: <20130228152433.GA13832@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

OK we talked about this a while ago, here's
a summary and some proposals:
At the moment, virtio PCI uses IO BARs for all accesses.

The reason for IO use is the cost of different VM exit types
of transactions and their emulation on KVM on x86
(it would be trivial to use memory BARs on non x86 platforms
 if they don't have PIO).
Example benchmark (cycles per transaction):
	(io access) outw 1737
	(memory access) movw 4341
for comparison:
	(hypercall access): vmcall 1566
	(pv memory access) movw_fast 1817 (*explanation what this is below)

This creates a problem if we want to make virtio devices
proper PCI express devices with native hotplug support.
This is because each hotpluggable PCI express device always has
a PCI express port (port per device),
where each port is represented by a PCI to PCI bridge.
In turn, a PCI to PCI bridge claims a 4Kbyte aligned
range of IO addresses. This means that we can have at
most 15 such devices, this is a nasty limitation.

Another problem with PIO is support for physical virtio devices,
and nested virt: KVM currently programs all PIO accesses
to cause vm exit, so using this device in a VM will be slow.

So we really want to stop using IO BARs completely if at all possible,
but looking at the table above, switching to memory BAR and movw for
notifications will not work well.

Possible solutions:
1. hypercall instead of PIO
	basically add a hypercall that gets an MMIO address/data
	and does an MMIO write for us.
	We'll want some capability in the device to let guest know
		this is what it should do.
	Pros: even faster than PIO
	Cons: this won't help nested or assigned devices (won't hurt
	      them either as it will be conditional on the capability above).
	Cons: need host kernel support, which then has to be maintained
	      forever, even if intel speeds up MMIO exits.

2. pv memory access
	There are two reasons that memory access is slower:
		- one is that it's handled as an EPT misconfiguration error
		so handled by cpu slow path
		- one is that we need to decode the x86 instruction in
		software, to calculate address/data for the access.

	We could agree that guests would use a specific instruction
	for virtio accesses, and fast-path it specifically.
	This is the pv memory access option above.
	Pros: helps assigned devices and nested virt
	Pros: easy to drop if hardware support is there
	Cons: a bit slower than IO
	Cons: need host kernel support

3. hypervisor assigned IO address
	qemu can reserve IO addresses and assign to virtio devices.
	2 bytes per device (for notification and ISR access) will be
	enough. So we can reserve 4K and this gets us 2000 devices.
        From KVM perspective, nothing changes.
	We'll want some capability in the device to let guest know
	this is what it should do, and pass the io address.
	One way to reserve the addresses is by using the bridge.
	Pros: no need for host kernel support
	Pros: regular PIO so fast
	Cons: does not help assigned devices, breaks nested virt

Simply counting pros/cons, option 3 seems best. It's also the
easiest to implement.

Comments?

-- 
MST
