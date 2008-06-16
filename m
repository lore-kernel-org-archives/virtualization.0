From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: linux-next: Tree for June 13 (XEN)
Date: Mon, 16 Jun 2008 21:30:57 +0200
Message-ID: <20080616193057.GA20851@kernel.dk>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <20080613101316.1c228fe7.randy.dunlap@oracle.com> <4852F1C8.7060904@goop.org> <20080614203109.GH20851@kernel.dk> <4854B284.7030709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4854B284.7030709@goop.org>
Sender: linux-next-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, chrisw@sous-sol.org, virtualization@lists.osdl.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 15 2008, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> >On Fri, Jun 13 2008, Jeremy Fitzhardinge wrote:
> >  
> >>Randy Dunlap wrote:
> >>    
> >>>next-20080613 on x86_32 has lots of xen build errors like this:
> >>>
> >>>linux-next-20080613/arch/x86/xen/mmu.c: In function 'drop_mm_ref':
> >>>linux-next-20080613/arch/x86/xen/mmu.c:759: error: implicit declaration 
> >>>of function 'xen_smp_call_function_mask'
> >>>make[2]: *** [arch/x86/xen/mmu.o] Error 1
> >>>
> >>> 
> >>>      
> >>Ooh, first time I've seen that.  Sounds like Jens' patches are missing 
> >>the appropriate update there (though it's certainly had it in the past).
> >>    
> >
> >Hmm, will this work or do we need to force xen smp_ops for this one? I
> >wonder if this is new code and was missed, or what happened in this
> >case.
> >  
> 
> Yes, using smp_call_function_mask is perfectly OK.  The old code was 
> just a micro-optimisation.  I'm pretty sure this chunk was in one of 
> your patchsets (or perhaps I sent it to you at some point).

Hmm yes, not sure myself to be honest, but I think you are right.

> >diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> >index 3525ef5..8baef77 100644
> >--- a/arch/x86/xen/mmu.c
> >+++ b/arch/x86/xen/mmu.c
> >@@ -569,7 +569,7 @@ static void drop_mm_ref(struct mm_struct *mm)
> > 	}
> > 
> > 	if (!cpus_empty(mask))
> >-		xen_smp_call_function_mask(mask, drop_other_mm_ref, mm, 1);
> >+		smp_call_function_mask(mask, drop_other_mm_ref, mm, 1);
> > }
> > #else
> > static void drop_mm_ref(struct mm_struct *mm)
> >
> >  
> 
> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Thanks, I just folded it in with the existing patch to avoid breakage.
That one doesn't have an ack from you though, so if you have done a full
review of the x86 bits, I'd appreciate an ack on those from you :-)

-- 
Jens Axboe

