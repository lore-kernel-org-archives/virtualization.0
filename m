From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie-t5LvXY1cjzpaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Thu, 09 Apr 2009 12:32:45 +0200
Message-ID: <1239273165.5687.10.camel@odie.local>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <1239224319.17844.16.camel@zetabook>
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

ons, 08 04 2009 kl. 17:58 -0300, skrev Matias Zabaljauregui:
> Simon, Patrick,
> 
> On Wed, 2009-04-08 at 10:21 +0930, Rusty Russell wrote:
> > On Tuesday 07 April 2009 04:19:58 Matias Zabaljauregui wrote:
> > > But then, when it tries to re-execute the faulting instruction, which is
> > > now patched with "cd 1f 90"  (int 0x1f, nop), it raises an invalid code
> > > fault again, instead of doing the trap. 
> > 
> > COW on the page?  Perhaps try flushing all the shadow pagetables after a
> > rewrite?
> > 
> > Rusty.
> 
> Rusty suggested that perhaps we need to flush all shadow after rewriting. 
> Could you please try this patch?

Yes, it fixes the issue.
> 
> BTW, shouldn't this also affect my test boxes if this were the case?
> 
Could be the timing differences between our boxes I guess?

The compiler used seems to play a role as well, though. I compiled a
kernel on another box and using that there was no problems even without
the patch. If you are interested in testing the faulty kernel I could
make it available to you.


Simon
> 
> diff --git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
> index a6b7176..b4747f7 100644
> --- a/drivers/lguest/x86/core.c
> +++ b/drivers/lguest/x86/core.c
> @@ -324,6 +324,7 @@ static void rewrite_hypercall(struct lg_cpu *cpu)
>  	u8 insn[3] = {0xcd, 0x1f, 0x90};
>  
>  	__lgwrite(cpu, guest_pa(cpu, cpu->regs->eip), insn, sizeof(insn));
> +	guest_pagetable_clear_all(cpu);
>  }
>  
>  static bool is_hypercall(struct lg_cpu *cpu)
