From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH 04/12] Clean up duplicate includes in arch/i386/xen/
Date: Mon, 15 Oct 2007 23:58:32 +0200
Message-ID: <9a8748490710151458o73267df1tcfb35fb5ae71d598@mail.gmail.com>
References: <20071015204840.074767068@goop.org>
	 <20071015210114.891237072@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932066AbXJOV6r@vger.kernel.org>
In-Reply-To: <20071015210114.891237072@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 15/10/2007, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> This patch cleans up duplicate includes in
>         arch/i386/xen/
>

Just for the record; this patch is
From: Jesper Juhl <jesper.juhl@gmail.com>

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> ---
>  arch/x86/xen/enlighten.c |    1 -
>  arch/x86/xen/mmu.c       |    2 --
>  2 files changed, 3 deletions(-)
>
> ===================================================================
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -25,7 +25,6 @@
>  #include <linux/mm.h>
>  #include <linux/page-flags.h>
>  #include <linux/highmem.h>
> -#include <linux/smp.h>
>
>  #include <xen/interface/xen.h>
>  #include <xen/interface/physdev.h>
> diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> index 4ae038a..35691a2 100644
> ===================================================================
> --- a/arch/x86/xen/mmu.c
> +++ b/arch/x86/xen/mmu.c
> @@ -41,7 +41,6 @@
>  #include <linux/sched.h>
>  #include <linux/highmem.h>
>  #include <linux/bug.h>
> -#include <linux/sched.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
