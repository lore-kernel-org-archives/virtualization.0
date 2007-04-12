From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 3/4] Pte xchg optimization.patch
Date: Thu, 12 Apr 2007 11:44:26 -0700
Message-ID: <461E7E0A.60002@vmware.com>
References: <200704120530.l3C5UweV022834@zach-dev.vmware.com> <20070412181809.GC25646@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030664AbXDLSrN@vger.kernel.org>
In-Reply-To: <20070412181809.GC25646@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Dave Jones wrote:
> On Wed, Apr 11, 2007 at 10:30:58PM -0700, Zachary Amsden wrote:
>  > In situations where page table updates need only be made locally, and there
>  > is no cross-processor A/D bit races involved, we need not use the heavyweight
>  > xchg instruction to atomically fetch and clear page table entries.  Instead,
>  > we can just read and clear them directly.
>  > 
>  > This introduces a neat optimization for non-SMP kernels; drop the atomic
>  > xchg operations from page table updates.
>
> Would it be feasible to do this using the smp_alternatives stuff?
> Given many distros are now shipping SMP-only kernels, it'd be nice
> to get that win without using having to rebuild their kernels.
>   

That's a good point. It is a fairly straightforward substitution for the 
static case:

xchg reg, mem

to

mov mem, reg
mov imm, mem

I'll give it a spin and see how it drives. It is, though, less obvious 
how easy it will be for PAE kernels.

Zach
