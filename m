From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/10] I386 sysenter arch pages fix.patch
Date: Mon, 09 Apr 2007 22:23:49 -0700
Message-ID: <461B1F65.6090104@goop.org>
References: <200704100006.l3A062AL020596@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966091AbXDJFX6@vger.kernel.org>
In-Reply-To: <200704100006.l3A062AL020596@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> In compat mode, the return value here was uninitialized.
>
> Signed-off-by: Zachary Amsden <zach@vmware.com>
>
> diff -r 1fda49a076ed arch/i386/kernel/sysenter.c
> --- a/arch/i386/kernel/sysenter.c	Fri Apr 06 14:25:09 2007 -0700
> +++ b/arch/i386/kernel/sysenter.c	Fri Apr 06 14:27:31 2007 -0700
> @@ -254,7 +254,7 @@ int arch_setup_additional_pages(struct l
>  {
>  	struct mm_struct *mm = current->mm;
>  	unsigned long addr;
> -	int ret;
> +	int ret = 0;
>  	bool compat;
>  
>  	down_write(&mm->mmap_sem);
> -

Hm, OK, but what about just zeroing it in the compat leg of the if()?

    J
