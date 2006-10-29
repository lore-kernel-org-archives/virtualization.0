From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/7] header and stubs for paravirtualizing critical operations
Date: Sun, 29 Oct 2006 08:40:07 -0800
Message-ID: <200610290840.08231.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org> <20061029024603.317829000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965291AbWJ2Qmv@vger.kernel.org>
In-Reply-To: <20061029024603.317829000@sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Can you add a high level comment to entry.S what paravirt mode
is all about and perhaps a quick cheat sheet on the macros?

> +/* SMP boot always wants to use real time delay to allow sufficient time
> for + * the APs to come online */
> +#define USE_REAL_TIME_DELAY

That's ugly. Can't you call different wait functions for that case instead?

> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#else
> +static inline void init_IRQ(void)
> +{
> +	native_init_IRQ();
> +}
> +#endif /* CONFIG_PARAVIRT */

You could probably avoid a lot of ifdefs by strategic use of 
__attribute__((weak))

> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#else

This is probably a good candidate for rename to native + wrapper
macros too. Otherwise we'll always have to hack two different
places later.

-Andi
