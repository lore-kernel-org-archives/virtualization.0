From: Andi Kleen <ak@suse.de>
Subject: Re: [Xen-devel] Re: [PATCH] xen: use iret directly where possible
Date: Mon, 4 Jun 2007 23:46:54 +0200
Message-ID: <200706042346.55049.ak@suse.de>
References: <46646662.9020707@goop.org> <200706042305.05340.ak@suse.de> <4664841A.8040802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757996AbXFDVrU@vger.kernel.org>
In-Reply-To: <4664841A.8040802@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 04 June 2007 23:28, Jeremy Fitzhardinge wrote:

> The cli/sti instructions don't control the event mask, so they're
> effectively expensive no-ops (they trap into the hypervisor, are
> emulated as no-ops). But if you mean cli as a general term for
> "events/interrupts masked", then they can't remain masked when you
> return to usermode.   iret normally sets the current eflags IF state
> from the on-stack IF, but that's irrelevent to Xen; we need to extract
> eflags.IF from the on-stack eflags, and put that into the vcpu's event
> mask.  That's inherently non-atomic with respect to iret.

Ah I assumed the hypervisor would just check IF in ring 1 too.
It would certainly make this easier, but then the additional trap
of setting it would be also somewhat expensive agreed.

I must say I still hate the patch; it has all the signs of something that
will be very nasty to maintain later.

-Andi
