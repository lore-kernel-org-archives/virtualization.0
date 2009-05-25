From: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: lguest PAE
Date: Mon, 25 May 2009 13:25:49 -0300
Message-ID: <1243268749.7267.40.camel@zetabook>
References: <1239902474.7166.49.camel@zetabook>  <49E7785D.1040501@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <49E7785D.1040501-TSDbQ3PG+2Y@public.gmane.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy, I fixed the code following your comments (hope you still
remember).

I'd like to ask you again about this one:
  
> >  /* Found in switcher.S */
> >  extern unsigned long default_idt_entries[];
> > diff --git a/arch/x86/include/asm/lguest_hcall.h b/arch/x86/include/asm/lguest_hcall.h
> > index 0f4ee71..3860153 100644
> > --- a/arch/x86/include/asm/lguest_hcall.h
> > +++ b/arch/x86/include/asm/lguest_hcall.h
> > @@ -17,6 +17,7 @@
> >  #define LHCALL_SET_PMD		15
> >  #define LHCALL_LOAD_TLS		16
> >  #define LHCALL_NOTIFY		17
> > +#define LHCALL_SET_PUD		18
> >   
> 
> PGD is more accurate than PUD (here, and the rest of the patch).  The 
> pud level of the pagetable is the 4th level used by 64-bit; PAE just has 
> PGD, PMD and PTE levels.  Due to pagetable level folding, the PGD is 
> sometimes referred to as the PUD when looking "up" the pagetable tree 
> (ie, the PUD is logically the next level up from the PMD), but its still 
> just an alias for the PGD.  Since the hypervisor interface shouldn't 
> care about how the guest OS manages its pagetables, it should use a 
> consistent naming for the levels as they "really" are.  Lguest 
> traditionally uses the same names that Linux does, so PGD is appropriate.
  
I understand, but then should we change also the LHCALL_SET_PMD name ?
this is the one used for setting a new pgd when PAE is NOT activated.


So, just to confirm:  even if we are implementing pv_mmu_ops.set_pud
replacement (lguest_set_pud in our case), we should use LHCALL_SET_PGD
hypercall name in this code because that is what host is going to
actually do? 

static void lguest_set_pud(pud_t *pudp, pud_t pudval)
{
	native_set_pud(pudp, pudval);

	/* 32 bytes aligned pdpt address. */
	lazy_hcall2(LHCALL_SET_PUD, __pa(pudp) & 0xFFFFFFE0,
		   (__pa(pudp) & 0x1F) / sizeof(pud_t));
}


Thanks, 
Matias
