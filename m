From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable accessors to pack and unpack pagetable entries
Date: Wed, 28 Feb 2007 09:32:03 +0100
Message-ID: <20070228083203.GB8866@elte.hu>
References: <20070227081337.434798469@goop.org> <20070227081630.311681690@goop.org> <20070227100850.GA10827@elte.hu> <45E47DEF.70405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752052AbXB1Iiy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45E47DEF.70405@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> >> +#ifdef CONFIG_PARAVIRT
> >> +/* After pte_t, etc, have been defined */
> >> +#include <asm/paravirt.h>
> >> +#endif
> >>     
> >
> > hm - there's already a CONFIG_PARAVIRT conditional in 
> > asm-i386/paravirt.h.
> 
> Yes, but it happens after asm/paravirt.h has already included some 
> things, and it ends up causing problems.  paravirt.h still defines 
> various stub functions in the !CONFIG_PARAVIRT case, so it needs to do 
> the includes either way.

hm, it then needs to be fixed first, instead of adding to the mess.

	Ingo
