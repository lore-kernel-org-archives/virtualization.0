From: Matias Zabaljauregui <zabaljauregui@gmail.com>
Subject: Re: [PATCH] lguest: PAE support
Date: Sun, 07 Jun 2009 14:51:07 -0300
Message-ID: <1244397067.21275.33.camel__14598.0262467221$1244397133$gmane$org@zetabook>
References: <1244218142.7700.24.camel@zetabook>
	<200906071058.23921.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906071058.23921.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2009-06-07 at 10:58 +0930, Rusty Russell wrote:
> On Sat, 6 Jun 2009 01:39:02 am Matias Zabaljauregui wrote:
> > Hi, this version requires that host and guest have the same PAE status.
> > NX cap is not offered to the guest, yet.
> 
> Thanks, applied!
> 
> I extracted the following parts for moving into your previous "native ops"
> patch:

great, thank you    (forgive my laziness)


> diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
> --- a/arch/x86/lguest/boot.c
> +++ b/arch/x86/lguest/boot.c
> @@ -519,7 +519,7 @@ static void lguest_pte_update(struct mm_
>  static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pteval)
>  {
> -	*ptep = pteval;
> +	native_set_pte(ptep, pteval);
>  	lguest_pte_update(mm, addr, ptep);
>  }
>  
> @@ -528,9 +528,9 @@ static void lguest_set_pte_at(struct mm_
>   * changed. */
>  static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
>  {
> -	*pmdp = pmdval;
> +	native_set_pmd(pmdp, pmdval);
>  	lazy_hcall2(LHCALL_SET_PMD, __pa(pmdp) & PAGE_MASK,
> -		   (__pa(pmdp) & (PAGE_SIZE - 1)) / 4);
> +		   (__pa(pmdp) & (PAGE_SIZE - 1)) / sizeof(pmd_t));
>  }
>  
>  /* There are a couple of legacy places where the kernel sets a PTE, but we
> @@ -544,7 +544,7 @@ static void lguest_set_pmd(pmd_t *pmdp, 
>   * which brings boot back to 0.25 seconds. */
>  static void lguest_set_pte(pte_t *ptep, pte_t pteval)
>  {
> -	*ptep = pteval;
> +	native_set_pte(ptep, pteval);
>  	if (cr3_changed)
>  		lazy_hcall1(LHCALL_FLUSH_TLB, 1);
>  }
> diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
> --- a/drivers/lguest/page_tables.c
> +++ b/drivers/lguest/page_tables.c
> @@ -726,8 +726,9 @@ void map_switcher_in_guest(struct lg_cpu
>  	 * page is already mapped there, we don't have to copy them out
>  	 * again. */
>  	pfn = __pa(cpu->regs_page) >> PAGE_SHIFT;
> -	regs_pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL));
> -	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTRS_PER_PTE] = regs_pte;
> +	native_set_pte(&regs_pte, pfn_pte(pfn, PAGE_KERNEL));
> +	native_set_pte(&switcher_pte_page[pte_index((unsigned long)pages)],
> +			regs_pte);
>  }
>  /*:*/
>  
> 
