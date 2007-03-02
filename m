From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Thu, 01 Mar 2007 22:31:57 -0800
Message-ID: <45E7C4DD.1040403@vmware.com>
References: <200703020254.l222smBB009668@zach-dev.vmware.com> <45E79529.9000305@goop.org> <45E79C72.4000806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422968AbXCBGb7@vger.kernel.org>
In-Reply-To: <45E79C72.4000806@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Hm, I don't think this interface will work for Xen.  In Xen, whenever a
>> pagetable page gets mapped, it must be mapped RO.  map_pt_hook gets
>> called after the mapping has already been created, so its too late for Xen.
>>
>> I was planning on adding kmap_atomic_pte() for use in pte_offset_map*(),
>> which would be wired through to paravirt_ops to allow Xen to make this a
>> RO mapping.  Would this be sufficient for you to do your vmi thing?
>>   
>>     
>
> Something like this (compiled, untested).
>
>     J
>
> diff -r 972e84c265cf arch/i386/kernel/paravirt.c
> --- a/arch/i386/kernel/paravirt.c	Thu Mar 01 19:12:49 2007 -0800
> +++ b/arch/i386/kernel/paravirt.c	Thu Mar 01 19:38:42 2007 -0800
> @@ -32,6 +32,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/apic.h>
>  #include <asm/tlbflush.h>
> +#include <asm/highmem.h>
>  
>  /* nop stub */
>  void _paravirt_nop(void)
> @@ -605,6 +606,8 @@ struct paravirt_ops paravirt_ops = {
>  
>  	.kpte_clear_flush = native_kpte_clear_flush,
>  
> +	.kmap_atomic_pte = native_kmap_atomic_pte,
> +
>  #ifdef CONFIG_X86_PAE
>  	.set_pte_atomic = native_set_pte_atomic,
>  	.set_pte_present = native_set_pte_present,
> diff -r 972e84c265cf arch/i386/mm/highmem.c
> --- a/arch/i386/mm/highmem.c	Thu Mar 01 19:12:49 2007 -0800
> +++ b/arch/i386/mm/highmem.c	Thu Mar 01 19:38:42 2007 -0800
> @@ -26,7 +26,7 @@ void kunmap(struct page *page)
>   * However when holding an atomic kmap is is not legal to sleep, so atomic
>   * kmaps are appropriate for short, tight code paths only.
>   */
> -void *kmap_atomic(struct page *page, enum km_type type)
> +void *_kmap_atomic(struct page *page, enum km_type type, pgprot_t prot)
>  {
>  	enum fixed_addresses idx;
>  	unsigned long vaddr;
> @@ -41,9 +41,14 @@ void *kmap_atomic(struct page *page, enu
>  		return page_address(page);
>  
>  	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
> -	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
> +	set_pte(kmap_pte-idx, mk_pte(page, prot));
>  
>  	return (void*) vaddr;
> +}
> +
> +void *kmap_atomic(struct page *page, enum km_type type)
> +{
> +	return _kmap_atomic(page, type, kmap_prot);
>  }
>   

Yeah, actually that does work, since you pass the km_type, we can use 
that.  But I would rather not respin this for 2.6.21; getting this 100% 
right can be tricky, and we've already done a good deal of testing on 
this patch the way it is.  Do you have any objection to me creating a 
patch for -mm tree that implements kmap_atomic_pte the way you have 
described above and attaching it to the Xen patch series, but leaving 
the current patch as is for now?

Thanks, (and thanks for the suggestion - I was a little worried about 
how it would play with Xen when HIGHPTE support came around, but it 
looks like it will work for both of us with just one paravirt-op).

Zach
