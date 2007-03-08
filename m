From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 12:10:33 -0800
Message-ID: <20070308201033.GK10574@sequoia.sous-sol.org>
References: <1173302503.24738.795.camel@localhost.localdomain> <45EF372E.7030600@goop.org> <1173308717.24738.898.camel@localhost.localdomain> <45EF49E9.7040509@vmware.com> <1173313373.24738.937.camel@localhost.localdomain> <45EF6077.9090302@vmware.com> <20070308182456.GH19575@sequoia.sous-sol.org> <45F06720.8080901@goop.org> <20070308194740.GJ10574@sequoia.sous-sol.org> <45F06989.8030207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752411AbXCHUKt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45F06989.8030207@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Daniel Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> > I agree with that, but I think that's esp. for things like create and launch
> > new vcpu.  The IPI bit I'm not as clear on, nor running this all on native
> > as well.
> >   
> 
> Well, native would fall back to using the existing arch/i386 versions of
> those functions, so that's reasonably straightforward.

It's the fact that we need to leave code in the kernel to run on native,
but also do something dynamically with that same code when running
paravirt that I'm referring to.  Xen punts on this right now by
#ifdef'ing away as happy as can be.

> There'll need to
> be a bit of internal rearrangement so that the Xen code can call in to
> do things like set up the pda/gdt and other bits of CPU state.
> 
> I don't think IPI is especially interesting in itself, is it?   It's a
> necessary mechanism to implement smp_call_function(), but Xen can do IPI
> without having to invoke any of the existing apic-based IPI code.  The
> other main user of IPI is cross-cpu tlb shootdown, but Xen has much more
> efficient mechanisms than IPI for that (so we'll need to make the tlb
> pv_ops interface a little wider to pass down a cpuset).

No, it's not the IPI itself, it's the way it's often accessed by the rest of
the kernel (which is intertwined with genapic).  I'm happy to avoid apic
altogether since it's effectively worthless for Xen other than
integrating into the existing infrastructure.
