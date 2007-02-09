From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: 9 Feb 2007 12:57:58 +0100
Message-ID: <20070209115758.GA18080@muc.de>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171018812.2718.66.camel@localhost.localdomain> <45CC5771.1070309@vmware.com> <200702091250.06482.ak@muc.de> <45CC60FD.6080606@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946387AbXBIL6A@vger.kernel.org>
Date: Fri, 9 Feb 2007 12:57:58 +0100
Content-Disposition: inline
In-Reply-To: <45CC60FD.6080606@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 09, 2007 at 03:54:37AM -0800, Zachary Amsden wrote:
> Andi Kleen wrote:
> >>Yes, it is a bit, umm, innovative.  If it is going to be kept, even if 
> >>just for devel logging, you should disable interrupts around it.  
> >>Changing segments is not a normal thing to do.
> >>    
> >
> >Actually that wouldn't be needed because interrupts are not allowed to do 
> >any user accesses. And contrary to the name it doesn't actually change
> >the segment registers, only state used by *_user.
> >  
> 
> My bad, I fell for the same mistake as everyone.  Set_fs is just way too 

You could change the name. Only 654 occurrences all over the tree @)

> confusing of a name now.  But good to know interrupts must be disable in 
> such a circumstance.

+not

-Andi
