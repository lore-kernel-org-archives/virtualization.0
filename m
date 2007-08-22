From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 21:46:32 +0200
Message-ID: <20070822194632.GD8058@bingen.suse.de>
References: <46CBC842.4070100@vmware.com> <20070822102217.GE2642@bingen.suse.de> <46CC68D9.5060200@vmware.com> <20070822175918.GB8058@bingen.suse.de> <46CC6D63.2010204@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764309AbXHVSww@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CC6D63.2010204@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2007 at 10:07:47AM -0700, Zachary Amsden wrote:
> >Also I fail to see the fundamental speed difference between
> >
> >mov index,register
> >int 0x...
> >...
> >switch (register) 
> >case xxxx: do emulation
> >  
> 
> Int (on p4 == ~680 cycles).
> 
> >versus
> >
> >out ...
> >#gp
> >-> switch (*eip) {
> >case 0xee:  /* etc. */ 
> >	do emulation
> >  
> 
> GP = ~2000 cycles.

How is that measured? In a loop? In the same pipeline state?

It seems a little dubious to me.

> 
> >>to verify protection in the page tables mapping the page allows 
> >>execution (P, !NX, and U/S check).  This is a lot more expensive than a 
> >>    
> >
> >When the page is not executable or not present you get #PF not #GP. 
> >So the hardware already checks that.
> >
> >The only case where you would need to check yourself is if you emulate
> >NX on non NX capable hardware, but I can't see you doing that.
> >  
> 
> No, it doesn't.  Between the #GP and decode, you have an SMP race where 
> another processor can rewrite the instruction.

That can be ignored imho. If the page goes away you'll notice
when you handle the page fault on read. If it becomes NX then the execution
just happened to be logically a little earlier.

My other objection to this scheme is that you'll change a zillion
drivers you'll never emulate which seems just stupid. You could
just change the small handful that you emulate to use hypercalls.

Or easier to just write a backend for the lguest virtio drivers,
that will be likely faster in the end anyways than this gross
hack.

Really LinuxHAL^wparavirt ops is already so complicated that
any new hooks need an extremly good justification and that is
just not here for this.

We can add it if you find an equivalent number of hooks
to eliminate.

-Andi
