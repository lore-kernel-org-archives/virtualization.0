From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH] Make lguest compile with CONFIG_BLOCK=n and CONFIG_NET=n
Date: Mon, 30 Jul 2007 06:18:56 +0530
Message-ID: <a781481a0707291748x5a70c2d3i83ef54d7f2336b33@mail.gmail.com>
References: <46ACAFBF.6060609@googlemail.com>
	 <1185755123.12151.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936584AbXG3AtL@vger.kernel.org>
In-Reply-To: <1185755123.12151.102.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Gabriel C <nix.or.die@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 7/30/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> [...]
> Gabriel C reports lguest doesn't compile with CONFIG_BLOCK=n.  Fix
> this by introducing a config var for the block device, which depends
> on LGUEST && BLOCK.  Do the same for the net driver, rather then
> depending gratuitously on CONFIG_NET.
> [...]
> diff -r 9e987fcabb16 drivers/lguest/Kconfig
> --- a/drivers/lguest/Kconfig    Mon Jul 30 09:47:25 2007 +1000
> +++ b/drivers/lguest/Kconfig    Mon Jul 30 10:03:39 2007 +1000
> @@ -1,6 +1,6 @@ config LGUEST
>  config LGUEST
>         tristate "Linux hypervisor example code"
> -       depends on X86 && PARAVIRT && NET && EXPERIMENTAL && !X86_PAE
> +       depends on X86 && PARAVIRT && EXPERIMENTAL && !X86_PAE
>         select LGUEST_GUEST
>         select HVC_DRIVER
>         ---help---
> @@ -18,3 +18,11 @@ config LGUEST_GUEST
>           The guest needs code built-in, even if the host has lguest
>           support as a module.  The drivers are tiny, so we build them
>           in too.
> +
> +config LGUEST_NET
> +       tristate
> +       depends on LGUEST_GUEST && NET

default y ?

> +
> +config LGUEST_BLOCK
> +       tristate
> +       depends on LGUEST_GUEST && BLOCK

default y ?

I /think/ the default "y" would also automatically become "m" if any of the
dependencies are modules ... probably need to test this, though.


Satyam
