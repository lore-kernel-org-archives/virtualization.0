From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
Date: Wed, 30 Nov 2011 13:03:23 +0000
Message-ID: <201111301303.23851.arnd__31944.0184896395$1322658254$gmane$org@arndb.de>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
	<201111292129.20444.arnd@arndb.de>
	<alpine.DEB.2.00.1111301053300.31179@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1111301053300.31179@kaball-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "android-virt@lists.cs.columbia.edu" <android-virt@lists.cs.columbia.edu>, "embeddedxen-devel@lists.sourceforge.net" <embeddedxen-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 30 November 2011, Stefano Stabellini wrote:
> On Tue, 29 Nov 2011, Arnd Bergmann wrote:
> > On Tuesday 29 November 2011, Stefano Stabellini wrote:
> > 
> > Do you have a pointer to the kernel sources for the Linux guest?
> 
> We have very few changes to the Linux kernel at the moment (only 3
> commits!), just enough to be able to issue hypercalls and start a PV
> console.
> 
> A git branch is available here (not ready for submission):
> 
> git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git arm

Ok, interesting. There really isn't much of the platform support
that I was expecting there. I finally found the information
I was looking for in the xen construct_dom0() function:

 167     regs->r0 = 0; /* SBZ */
 168     regs->r1 = 2272; /* Machine NR: Versatile Express */
 169     regs->r2 = 0xc0000100; /* ATAGS */

What this means is that you are emulating the current ARM/Keil reference
board, at least to the degree that is necessary to get the guest started.

This is the same choice people have made for KVM, but it's not
necessarily the best option in the long run. In particular, this
board has a lot of hardware that you claim to have by putting the
machine number there, when you don't really want to emulate it.

Pawell Moll is working on a variant of the vexpress code that uses
the flattened device tree to describe the present hardware [1], and
I think that would be a much better target for an official release.
Ideally, the hypervisor should provide the device tree binary (dtb)
to the guest OS describing the hardware that is actually there.

This would also be the place where you tell the guest that it should
look for PV devices. I'm not familiar with how Xen announces PV
devices to the guest on other architectures, but you have the
choice between providing a full "binding", i.e. a formal specification
in device tree format for the guest to detect PV devices in the
same way as physical or emulated devices, or just providing a single
place in the device tree in which the guest detects the presence
of a xen device bus and then uses hcalls to find the devices on that
bus.

Another topic is the question whether there are any hcalls that
we should try to standardize before we get another architecture
with multiple conflicting hcall APIs as we have on x86 and powerpc.

	Arnd

[1] http://www.spinics.net/lists/arm-kernel/msg149604.html
