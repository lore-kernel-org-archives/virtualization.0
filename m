From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 06/21] Xen-paravirt: remove ctor for pgd cache
Date: Tue, 13 Feb 2007 14:39:52 -0800
Message-ID: <45D23E38.1030607@vmware.com>
References: <20070213221729.772002682@goop.org> <20070213221829.929261125@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751372AbXBMWjz@vger.kernel.org>
In-Reply-To: <20070213221829.929261125@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>  
> @@ -261,10 +261,12 @@ void pgd_ctor(void *pgd, struct kmem_cac
>  	spin_unlock_irqrestore(&pgd_lock, flags);
>  }
>  
> -/* never called when PTRS_PER_PMD > 1 */
> -void pgd_dtor(void *pgd, struct kmem_cache *cache, unsigned long unused)
> +static void pgd_dtor(pgd_t *pgd)
>  {
>  	unsigned long flags; /* can be called from interrupt context */
> +
> +	if (PTRS_PER_PMD == 1)
> +		return;
>  
>  	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
>  	spin_lock_irqsave(&pgd_lock, flags);
>   


Acked, with exceptions.  This bit breaks VMI.  The paravirt_release_pd 
must happen unconditionally.  But I would rather fix it after patches 
get applied just to make sure the entire allocation / deallocation order 
constraints are intact.

Zach
