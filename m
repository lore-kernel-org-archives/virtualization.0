From: Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 00:01:52 +0200
Message-ID: <200608050001.52535.ak@suse.de>
References: <44D1CC7D.4010600@vmware.com>
	<20060804183448.GE11244@sequoia.sous-sol.org>
	<44D3B0F0.2010409@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D3B0F0.2010409@vmware.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, James.Bottomley@steeleye.com, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org

> In the Xen case, =

> they may want to run a dom-0 hypervisor which is compiled for an actual =

> hardware sub-arch, such as Summit or ES7000. =


There is no reason Summit or es7000 or any other subarchitecture =

would need to do different  virtualization. In fact these subarchitectures =

are pretty much obsolete by the generic subarchitecture and could be fully
done by runtime switching.

I don't disagree with your general point that some kind of PAL
code between kernels and hypervisors might be a good idea
(in fact I think Xen already uses vsyscall pages in some cases for this),
but this particular example is no good.

> I would expect to see these new sub-architectures =

> begin to grow like a rash. =


I hope not. The i386 subarchitecture setup is pretty bad already
and mostly obsolete for modern systems.

> The same approach can be used on x86_64 for paravirtualization, but also =

> to abstract out vendor differences between platforms.  Opteron and EMT64 =

> hardware are quite different, and the plethora of non-standard =

> motherboards and uses have already intruded into the kernel.  Having a =

> clean interface to encapsulate these changes is also desirable here, and =

> once we've nailed down a final approach to achieving this for i386, it =

> makes sense to do x86_64 as well.

Possible.

> =

> I'm now talking lightyears into the future

tststs - please watch your units.

>, but when the i386 and x86_64  =

> trees merge together,

I don't think that will happen in the way you imagine. I certainly
don't plan to ever merge legacy stuff like Voyager or Visual Workstation
or even 586 multiprocessor support.

It might be that x86-64 grows 32bit support at some point, but certainly
only for modern systems and without the heavyweight subarchitecture setup
that i386 uses.

> this layer will be almost identical for the two,  =

> allowing sharing of tricky pieces of code, like the APIC and IO-APIC, =


No, one of the strong points of the x86-64 port is that APIC/IO-APIC support
doesn't carry all the legacy i386 has to carry.

> NMI handling, system profiling, and power management.  It the interface =

> evolves in a nicely packaged and compartmentalized way from that, then =

> perhaps someday it can grow to become a true cross-architecture way to =

> handle machine abstraction and virtualization. =


I don't fully agree to move everything into paravirt ops. IMHO
it should be only done for stuff which is performance critical
or cannot be virtualized.

For most other stuff a Hypervisor can always trap or not bother.

> (N-tiered cache coloring, =

> multiway hardware page tables, hypercubic interrupt routing, dynamically =

> morphed GPUs, quantum hypervisor isolation).  =


I have my doubts paravirt ops will ever support any of this @)
If we tried that then it would be so messy that it would turn into
a bad idea.

> Of course, it will still  =

> require a PCI bus.

And it's unlikely PCI will be ever a good fit for a Quantum computer @)

>  I too would like to push for an interface =

> in 2.6.19, and we can't have confusion on this issue be a last minute =

> stopper.

For 2.6.19 it's too late already. Freeze for its merge =

window has already nearly begun and this stuff is not ready yet.
 =

> Maybe someday Xen and VMware can share the same ABI interface and both =

> use a VMI like layer. =


The problem with VMI is that while it allows hypervisor side evolution
it doesn't really allow Linux side evolution with its fixed spec.

But having it a bit isolated is probably ok.

-Andi
