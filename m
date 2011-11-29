From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
Date: Tue, 29 Nov 2011 14:53:34 +0000
Message-ID: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: linaro-dev@lists.linaro.org, kvm@vger.kernel.org, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, android-virt@lists.cs.columbia.edu, embeddedxen-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,
a few weeks ago I (and a few others) started hacking on a
proof-of-concept hypervisor port to Cortex-A15 which uses and requires
ARMv7 virtualization extensions. The intention of this work was to find
out how to best support ARM v7+ on Xen. See
http://old-list-archives.xen.org/archives/html/xen-arm/2011-09/msg00013.html
for more details. 

I am pleased to announce that significant progress has been made, and
that we now have a nascent Xen port for Cortex-A15. The port is based on
xen-unstable (HG CS 8d6edc3d26d2) and written from scratch exploiting
the latest virtualization, LPAE, GIC and generic timer support in
hardware.

We started the work less than three months ago, but the port is already
capable of booting a Linux 3.0 based virtual machine (dom0) up to a
shell prompt on an ARM Architecture Envelope Model, configured to emulate
an A15-based Versatile Express. In this context, we wanted to thank ARM
for making the model available to us.
Now we are looking forward to porting the tools and running multiple
guests.

The code requires virtualization, LPAE and GIC support and therefore it
won't be able to run on anything older than a Cortex-A15.
On the other hand, thanks to this, it is very small and easy to read,
write and understand.
The implementation does not distinguish between PV and HVM guests: there
is just one type of guests that would be comparable to Linux PV on HVM
in the Xen X86 world, but with no need for Qemu emulation.
The code only requires minimal changes to the Linux kernel: just enough
to support PV drivers.

Even though we are currently targeting Versatile Express and Cortex-A15
we do intend to support other machines and other ARMv7 with
virtualization extensions CPUs.
We are also looking forward to ARMv8 and 64 bits support.

Given that porting Xen to Cortex-A15 could be done with so little code,
we believe that the best course of action is to merge it into
xen-unstable as quickly as possible. There are still few rough edges to
sort out but we should be able to produce a clean and digestible patch
series for submission to xen-devel within the next couple of months. I
hope to see the first patches going to the list as soon as possible.
We would very welcome any contributions, in the form of testing, code
reviews and, of course, patches! 


A git tree is available here:

git://xenbits.xen.org/people/sstabellini/xen-unstable.git arm

the gitweb url is the following:

http://xenbits.xen.org/gitweb/?p=people/sstabellini/xen-unstable.git/.git;a=shortlog;h=refs/heads/arm

And here is the full diff:

http://xenbits.xen.org/people/sstabellini/diff


We want to point out that this effort is in addition to Samsung's
ongoing efforts to upstream Xen ARM to xen-unstable. Samsung's XenARM
port allows virtualization of Xen on ARM CPUs prior to virtualization
extensions and supports traditional PV guests.

I would like to thank Tim Deegan and Ian Campbell: if you spend some
time reading the history, you'll see that this project wouldn't have
been possible in such a short time without great contributions from
them.

Cheers,
Stefano
