From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen implementation
Date: Fri, 16 Mar 2007 12:00:49 +0000
Message-ID: <20070316120049.GA22072@infradead.org>
References: <20070301232443.195603797@goop.org> <20070301232528.812011702@goop.org> <20070316091411.GF23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933584AbXCPMBL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070316091411.GF23174@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Adrian Bunk <bunk@stusta.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 16, 2007 at 10:14:11AM +0100, Ingo Molnar wrote:
> 
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Core Xen Implementation
> > 
> > This patch is a rollup of all the core pieces of the Xen 
> > implementation, including booting, memory management, interrupts, time 
> > and so on.
> 
> > --- a/arch/i386/kernel/head.S
> > +++ b/arch/i386/kernel/head.S
> > @@ -535,6 +535,10 @@ unhandled_paravirt:
> >  	ud2
> >  #endif
> >  
> > +#ifdef CONFIG_XEN
> > +#include "../xen/xen-head.S"
> > +#endif
> 
> i'd suggest to remove the #ifdef and push it into xen-head.S.

Even better would be an explanation of why this needs to be included
at all.  Life would be much simpler if this was simply a totally
separate file.
