From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 03 Apr 2007 17:52:57 -0700
Message-ID: <4612F6E9.7040003@zytor.com>
References: <4611652F.700@zytor.com> <200704032351.17823.arnd@arndb.de>	<4612D0CA.3070209@zytor.com> <200704040049.13118.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966213AbXDDAxO@vger.kernel.org>
In-Reply-To: <200704040049.13118.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Wednesday 04 April 2007, H. Peter Anvin wrote:
>> Note that at least for PIO-based devices, there is nothing that says you 
>> can't implement PCI over another transport, if you wish.  It's really 
>> just a very simple RPC protocol.
> 
> The PIO aspect of PCI is simple, yes, except on architectures that don't
> have the concept of PIO or even uncached memory, but even that can
> be done by defining readl/writel/inl/outl/... as hcalls.
> 
> The tricky part about PCI is the device probing, everything about config
> space accesses, interrupt swizzling, bus/device/function numbers and
> base address registers becomes a pointless excercise when the other side
> is just faking it.

Configuration space access is platform-dependent.  It's only defined to 
work in a specific way on x86 platforms.

"Interrupt swizzling" is really totally independent of PCI.  ALL PCI 
really provides is up to four interrupts per device (not counting 
MSI/MSI-X) and an 8-bit writable field which the platform can choose to 
use to hold interrupt information.  That's all.  The rest is all 
platform information.

PCI enumeration is hardly complex.  Most of the stuff that doesn't apply 
to you you can generally ignore, as is done by other busses like 
HyperTransport when they emulate PCI.

That being said, on platforms which are PCI-centric, such as x86, this 
of course makes it a lot easier to produce virtual devices which work 
across hypervisors, since the device model, of *any* operating system is 
set up to handle them.

	-hpa
