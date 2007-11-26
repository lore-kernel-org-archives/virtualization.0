From: "Juan Quintela" <juan.quintela@gmail.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 26 Nov 2007 15:02:17 +0100
Message-ID: <de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4744BB54.4040803@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4744BB54.4040803@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

your console works great, but rest of patches are assuming:

arch/x86/boot/compressed/notes-xen.c
arch/x86/xen/early.c

at least.  It looks as if there is missing another patche, could you
take a look, please?
Otherwise, I will take a look at what is missing.

It breaks with:

Intel machine check architecture supported.
(XEN) traps.c:1734:d0 Domain attempted WRMSR 00000404 from 00000000:00000001 to
ffffffff:ffffffff.
Intel machine check reporting enabled on CPU#0.
general protection fault: 0000 [#1] SMP
Modules linked in:

Pid: 1, comm: swapper Not tainted (2.6.24-rc3-q2 #10)
EIP: 0061:[<c0101790>] EFLAGS: 00010082 CPU: 0
EIP is at native_write_cr0+0x0/0x4
EAX: c005003b EBX: c03902a0 ECX: ed03f288 EDX: 00000005
ESI: c1c10c80 EDI: ed054200 EBP: 00000001 ESP: ed027eb8
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: e021
Process swapper (pid: 1, ti=ed027000 task=ed03ebb0 task.ti=ed027000)
Stack: c01125e9 00000000 c03902a0 c1c10c80 ed054200 c01128c6 c03900a0 00000008
       c010e0aa c037b48d 00000000 ed00efa0 ed027f24 0000000a c035215c c01e20a7
       c1c10c80 80000008 000006f4 00020800 c0143563 ed03ebb0 017fe000 c03902a0
Call Trace:
 [<c01125e9>] prepare_set+0x20/0x86
 [<c01128c6>] generic_set_all+0x28/0x34a
 [<c010e0aa>] identify_cpu+0x525/0x52d
 [<c01e20a7>] kvasprintf+0x3f/0x48
 [<c0143563>] trace_hardirqs_off+0x28/0xa1
 [<c0111ac6>] mtrr_ap_init+0x33/0x5d
 [<c0117547>] smp_store_cpu_info+0x32/0xb9
 [<c0104e78>] xen_cpu_up+0x22c/0x3b4
 [<c0148fdf>] _cpu_up+0xab/0x120
 [<c014913e>] cpu_up+0x4e/0x61
 [<c03d33f8>] kernel_init+0x9e/0x2c6
 [<c0107017>] restore_nocheck+0x12/0x15
 [<c03d335a>] kernel_init+0x0/0x2c6
 [<c03d335a>] kernel_init+0x0/0x2c6
 [<c0107c7f>] kernel_thread_helper+0x7/0x10
 =======================
Code: 53 89 cb 83 ec 08 89 14 24 89 da 8b 04 24 89 4c 24 04 89 f9 0f 30 31 c0 5a
 59 5b 5e 5f c3 0f 31 c3 0f 33 c3 0f 06 c3 0f 20 c0 c3 <0f> 22 c0 c3 0f 20 e0 c3
 31 c0 0f 20 e0 c3 0f 09 c3 0f 01 00 c3
EIP: [<c0101790>] native_write_cr0+0x0/0x4 SS:ESP e021:ed027eb8
Kernel panic - not syncing: Attempted to kill init!


Later, Juan.


On Nov 22, 2007 12:12 AM, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Stephen C. Tweedie wrote:
> > I've been looking at the next steps to try to get Xen running fully on
> > top of pv_ops.  To that end, I've (just) started looking at one of the
> > next major jobs --- i686 dom0 on pv_ops.
> >
>
> Great!
>
> > There are still a number of things needing done to reach parity with
> > xen-unstable:
> >
> >   x86_64 xen on pv_ops
> >
>
> I think once pvops has been unified, Xen support should be fairly
> straightforward.  I wrote most of the existing code with 64-bit in mind,
> so I'm hoping I got it right...
>
> >   Paravirt framebuffer/keyboard
> >   CPU hotplug
> >   Balloon
> >
>
> I've done some preliminary work on balloon and hotplug.  I think balloon
> should make more use of memory hotplug, but a straight port would be a
> good first step.
>
> >   kexec
> >   driver domains
> >
> > but it looks like these can largely proceed in parallel if desired.
> >
> > My short-term goal with this is simply to come up with a first-pass
> > merge of the linux-2.6.18-xen.hg dom0 support into the current
> > kernel.org tree's pv_ops support.  No major refactoring in the first
> > pass, but absolutely no *-xen.c code copying.
> >
>
> Yes.  #ifdefs are the way to go here.
>
> > I'm just starting this, but at least with the version magic check (see
> >
> >       http://lists.xensource.com/archives/html/xen-devel/2007-11/msg00601.html
> >
>
> I was just about to post a fix for this.
>
> > ) out of the way, an SMP dom0 running pv_ops gets all the way through
> > start_kernel() and into rest_init() before dying with an unsupported cr0
> > write.  (I'm using direct console hypercalls for printk for now, full
> > xencons is not working yet.)
> >
>
> I have some early dom0 patches already, though they're a few months old
> now.  Not much there, but I did do an early console implementation.
>
> > I'm happy to put up a git tree for this once it gets anywhere.  We'd
> > need to decide which tree to track for that purpose --- Linus's, or
> > perhaps the tglx or mingo x86 merge tree might make more sense.
> >
>
> Yes, I think the x86 tree is where we need to be, since there's a lot of
> activity there.
>
> I'll attach my dom0 patches for whatever use you can make of them.  The
> definitely won't apply to anything, not least because of the arch merge
> (though it looks like they did get converted by script), but also
> because they're based on some defunct experimental booting-from-bzImage
> patches.  But perhaps there's some useful stuff in there.
>
> I've also attached my xen-balloon and hotplug patches as-is.  They don't
> work completely, but they should be closer to applying.
>
>     J
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
>
>
