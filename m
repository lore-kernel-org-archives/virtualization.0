From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 06/26] Xen-paravirt_ops: paravirt_ops: allocate a fixmap slot
Date: Wed, 28 Feb 2007 09:30:55 +0100
Message-ID: <20070228083055.GA8866@elte.hu>
References: <20070227081337.434798469@goop.org> <20070227081631.122933982@goop.org> <20070227101143.GC10827@elte.hu> <45E47E95.2060803@goop.org> <45E4D1B1.7030903@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752051AbXB1Ih4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45E4D1B1.7030903@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > Yes.  vmalloc would have the annoying side-effect of actually 
> > allocating some pages which would be shadowed by the remapping, but 
> > I guess get_vm_area would do the job.  I'll give it a go.
> 
> Hm, this is a bit awkward.  We need to map the shared info page fairly 
> early - say, around paging_init - but we're still on the bootmem 
> allocator at that point, so get_vm_area isn't usable yet.  Using a 
> fixmap keeps things simple.  It seems to me that having a single 
> fixmap available is useful for this kind of simple/early mapping, and 
> if someone needs to map something larger, then they can put it off 
> until get_vm_area() is available...

fair enough. Please rename it to FIX_PARAVIRT_BOOTUP - you can still 
rely on it being available later on too, but we'd like to give everyone 
the right fundamental idea about this: it's meant to be a limited, 
inflexible interface for bootstrap only.

	Ingo
