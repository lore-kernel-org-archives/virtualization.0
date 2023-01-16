Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6E0C54EBE
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 04:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 088C16059D;
	Mon, 16 Jan 2023 04:40:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 088C16059D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7YVwj9CZXpn0; Mon, 16 Jan 2023 04:40:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7215060812;
	Mon, 16 Jan 2023 04:40:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7215060812
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4008DC0033;
	Mon, 16 Jan 2023 04:40:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1FC1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 04:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E9F3403ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 04:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E9F3403ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqAVNVDExz1D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 04:40:03 +0000 (UTC)
X-Greylist: delayed 00:11:50 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59C2E403D8
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59C2E403D8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 04:40:03 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab3MD6R.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pHH69-00EU45-Mo;
 Sun, 15 Jan 2023 23:27:53 -0500
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org
References: <20230112152132.4399-1-jgross@suse.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
Message-ID: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
Date: Sun, 15 Jan 2023 20:27:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230112152132.4399-1-jgross@suse.com>
Content-Language: en-US
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alexey Makhalov <amakhalov@vmware.com>,
 xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


Hi Juergen,

On 1/12/23 7:21 AM, Juergen Gross wrote:
> The two paravirt callbacks .mmu.activate_mm and .mmu.dup_mmap are
> sharing the same implementations in all cases: for Xen PV guests they
> are pinning the PGD of the new mm_struct, and for all other cases
> they are a NOP.
> 

I was expecting that the duplicated functions xen_activate_mm() and
xen_dup_mmap() would be merged into a common one, and that both
.mmu.activate_mm and .mmu.dup_mmap callbacks would be mapped to that
common implementation for Xen PV.

> So merge them to a common callback .mmu.enter_mmap (in contrast to the
> corresponding already existing .mmu.exit_mmap).
> 

Instead, this patch seems to be merging the callbacks themselves...

I see that's not an issue right now since there is no other actual
user for these callbacks. But are we sure that merging the callbacks
just because the current user (Xen PV) has the same implementation for
both is a good idea? The callbacks are invoked at distinct points from
fork/exec, so wouldn't it be valuable to retain that distinction in
semantics in the callbacks as well?

However, if you believe that two separate callbacks are not really
required here (because there is no significant difference in what they
mean, rather than because their callback implementations happen to be
the same right now), then could you please expand on this and call it
out in the commit message, please?

Thank you!

Regards,
Srivatsa
VMware Photon OS

> As the first parameter of the old callbacks isn't used, drop it from
> the replacement one.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/mmu_context.h    |  4 ++--
>  arch/x86/include/asm/paravirt.h       | 14 +++-----------
>  arch/x86/include/asm/paravirt_types.h |  7 ++-----
>  arch/x86/kernel/paravirt.c            |  3 +--
>  arch/x86/xen/mmu_pv.c                 | 12 ++----------
>  5 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index b8d40ddeab00..6a14b6c2165c 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -134,7 +134,7 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  
>  #define activate_mm(prev, next)			\
>  do {						\
> -	paravirt_activate_mm((prev), (next));	\
> +	paravirt_enter_mmap(next);		\
>  	switch_mm((prev), (next), NULL);	\
>  } while (0);
>  
> @@ -167,7 +167,7 @@ static inline void arch_dup_pkeys(struct mm_struct *oldmm,
>  static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
>  {
>  	arch_dup_pkeys(oldmm, mm);
> -	paravirt_arch_dup_mmap(oldmm, mm);
> +	paravirt_enter_mmap(mm);
>  	return ldt_dup_context(oldmm, mm);
>  }
>  
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 73e9522db7c1..07bbdceaf35a 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -332,16 +332,9 @@ static inline void tss_update_io_bitmap(void)
>  }
>  #endif
>  
> -static inline void paravirt_activate_mm(struct mm_struct *prev,
> -					struct mm_struct *next)
> +static inline void paravirt_enter_mmap(struct mm_struct *next)
>  {
> -	PVOP_VCALL2(mmu.activate_mm, prev, next);
> -}
> -
> -static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
> -					  struct mm_struct *mm)
> -{
> -	PVOP_VCALL2(mmu.dup_mmap, oldmm, mm);
> +	PVOP_VCALL1(mmu.enter_mmap, next);
>  }
>  
>  static inline int paravirt_pgd_alloc(struct mm_struct *mm)
> @@ -787,8 +780,7 @@ extern void default_banner(void);
>  
>  #ifndef __ASSEMBLY__
>  #ifndef CONFIG_PARAVIRT_XXL
> -static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
> -					  struct mm_struct *mm)
> +static inline void paravirt_enter_mmap(struct mm_struct *mm)
>  {
>  }
>  #endif
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 8c1da419260f..71bf64b963df 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -164,11 +164,8 @@ struct pv_mmu_ops {
>  	unsigned long (*read_cr3)(void);
>  	void (*write_cr3)(unsigned long);
>  
> -	/* Hooks for intercepting the creation/use of an mm_struct. */
> -	void (*activate_mm)(struct mm_struct *prev,
> -			    struct mm_struct *next);
> -	void (*dup_mmap)(struct mm_struct *oldmm,
> -			 struct mm_struct *mm);
> +	/* Hook for intercepting the creation/use of an mm_struct. */
> +	void (*enter_mmap)(struct mm_struct *mm);
>  
>  	/* Hooks for allocating and freeing a pagetable top-level */
>  	int  (*pgd_alloc)(struct mm_struct *mm);
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 327757afb027..ff1109b9c6cd 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -352,8 +352,7 @@ struct paravirt_patch_template pv_ops = {
>  	.mmu.make_pte		= PTE_IDENT,
>  	.mmu.make_pgd		= PTE_IDENT,
>  
> -	.mmu.dup_mmap		= paravirt_nop,
> -	.mmu.activate_mm	= paravirt_nop,
> +	.mmu.enter_mmap		= paravirt_nop,
>  
>  	.mmu.lazy_mode = {
>  		.enter		= paravirt_nop,
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index ee29fb558f2e..b3b8d289b9ab 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -885,14 +885,7 @@ void xen_mm_unpin_all(void)
>  	spin_unlock(&pgd_lock);
>  }
>  
> -static void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
> -{
> -	spin_lock(&next->page_table_lock);
> -	xen_pgd_pin(next);
> -	spin_unlock(&next->page_table_lock);
> -}
> -
> -static void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
> +static void xen_enter_mmap(struct mm_struct *mm)
>  {
>  	spin_lock(&mm->page_table_lock);
>  	xen_pgd_pin(mm);
> @@ -2153,8 +2146,7 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
>  		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
>  #endif
>  
> -		.activate_mm = xen_activate_mm,
> -		.dup_mmap = xen_dup_mmap,
> +		.enter_mmap = xen_enter_mmap,
>  		.exit_mmap = xen_exit_mmap,
>  
>  		.lazy_mode = {
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
