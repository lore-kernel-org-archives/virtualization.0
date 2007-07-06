From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] I386: Deactivate the test for the dead CONFIG_DEBUG_PAGE_TYPE
 variable.
Date: Fri, 06 Jul 2007 20:25:14 +0200
Message-ID: <468E890A.1070504@s5r6.in-berlin.de>
References: <Pine.LNX.4.64.0707060847470.23786@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763959AbXGFSZ6@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0707060847470.23786@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Robert P. J. Day wrote:
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
> diff --git a/arch/i386/kernel/vmi.c b/arch/i386/kernel/vmi.c

Maintainers are apparently those under "PARAVIRT_OPS INTERFACE".
CCs added.

> index c12720d..e3ce5c8 100644
> --- a/arch/i386/kernel/vmi.c
> +++ b/arch/i386/kernel/vmi.c
> @@ -235,7 +235,7 @@ static void vmi_nop(void)
>  {
>  }
> 
> -#ifdef CONFIG_DEBUG_PAGE_TYPE
> +#if 0 /* debug page type */
> 
>  #ifdef CONFIG_X86_PAE
>  #define MAX_BOOT_PTS (2048+4+1)
> @@ -336,7 +336,7 @@ static void vmi_check_page_type(u32 pfn, int type)
>  #else
>  #define vmi_set_page_type(p,t) do { } while (0)
>  #define vmi_check_page_type(p,t) do { } while (0)
> -#endif
> +#endif /* debug page type */
> 
>  #ifdef CONFIG_HIGHPTE
>  static void *vmi_kmap_atomic_pte(struct page *page, enum km_type type)

This misnamed CONFIG_DEBUG_PAGE_TYPE (it's not a Kconfig variable) has
about 120 lines debug code dangling on it.  So, replacing it by #if 0
will hopefully motivate a kind janitor to send a removal patch for that
debug code eventually.  I don't do so just now because that code went in
between 2.6.20 and 2.6.21-rc1, i.e. not so long ago.
-- 
Stefan Richter
-=====-=-=== -=== --==-
http://arcgraph.de/sr/
