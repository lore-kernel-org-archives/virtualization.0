From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/4] x86 paravirt_ops: paravirt_desc.h for native descriptor ops.
Date: Mon, 7 Aug 2006 10:53:28 +0200
Message-ID: <200608071053.28293.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070740.23840.ak@muc.de> <1154937040.7642.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751163AbWHGIxe@vger.kernel.org>
In-Reply-To: <1154937040.7642.31.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 09:50, Rusty Russell wrote:
> On Mon, 2006-08-07 at 07:40 +0200, Andi Kleen wrote:
> > On Monday 07 August 2006 06:45, Rusty Russell wrote:
> > > Unfortunately, due to include cycles, we can't put these in
> > > paravirt.h: we use a separate header for these.
> > > 
> > > The implementation comes from Zach's [RFC, PATCH 10/24] i386 Vmi descriptor changes:
> > > 
> > >   Descriptor and trap table cleanups.  Add cleanly written accessors for
> > >   IDT and GDT gates so the subarch may override them.  Note that this
> > >   allows the hypervisor to transparently tweak the DPL of the descriptors
> > >   as well as the RPL of segments in those descriptors, with no unnecessary
> > >   kernel code modification.  It also allows the hypervisor implementation
> > >   of the VMI to tweak the gates, allowing for custom exception frames or
> > >   extra layers of indirection above the guest fault / IRQ handlers.
> > 
> > Nice cleanup. The old assembly mess was ripe to be killed for a long time.
> 
> OK, here's that patch extracted out.

Is there something wrong with your mailer? This one doesn't apply either:

Applying patch patches/paravirt_desc.h-for-native
patching file arch/i386/kernel/traps.c
Hunk #1 FAILED at 1112.
1 out of 1 hunk FAILED -- rejects in file arch/i386/kernel/traps.c
missing header for unified diff at line 78 of patch
can't find file to patch at input line 78
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|  * thus use the _nonmapped_ version of the IDT, as the
--------------------------
No file to patch.  Skipping patch.
1 out of 1 hunk ignored
missing header for unified diff at line 88 of patch
can't find file to patch at input line 88
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
| /*
--------------------------


-Andi
