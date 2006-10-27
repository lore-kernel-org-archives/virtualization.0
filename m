From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS address space
Date: Fri, 27 Oct 2006 13:30:01 +0200
Message-ID: <20061027113001.GB8095@elf.ucw.cz>
References: <1161920325.17807.29.camel@localhost.localdomain> <1161920535.17807.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946410AbWJ0LaW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1161920535.17807.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> (Andrew had already taken that last one, I meant to send this)
> 
> Subject: Be careful about touching BIOS address space
> 
> BIOS ROM areas may not be mapped into the guest address space, so be careful
> when touching those addresses to make sure they appear to be mapped.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> ===================================================================
> --- a/arch/i386/kernel/setup.c
> +++ b/arch/i386/kernel/setup.c
> @@ -270,7 +270,14 @@ static struct resource standard_io_resou
>  	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
>  } };
>  
> -#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
> +static inline int romsignature(const unsigned char *x)
> +{
> +     unsigned short sig;
> +     int ret = 0;
> +     if (__get_user(sig, (const unsigned short *)x) == 0)
> +	  ret = (sig == 0xaa55);

Indentation is b0rken here.

And... is get_user right primitive for accessing area that may not be
there?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
