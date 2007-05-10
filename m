From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 5/9] lguest: the Makefile and Kconfig
Date: Thu, 10 May 2007 10:19:35 +1000
Message-ID: <1178756375.7286.178.camel@localhost.localdomain>
References: <200705090951.l499pb6H020400@shell0.pdx.osdl.net>
	 <20070509204725.GB10336@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760427AbXEJATr@vger.kernel.org>
In-Reply-To: <20070509204725.GB10336@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 22:47 +0200, Sam Ravnborg wrote:
> > diff -puN /dev/null drivers/lguest/Makefile
> > --- /dev/null
> > +++ a/drivers/lguest/Makefile
> > @@ -0,0 +1,7 @@
> > +# Guest requires the paravirt_ops replacement and the bus driver.
> > +obj-$(CONFIG_LGUEST_GUEST) += lguest.o lguest_asm.o lguest_bus.o
> > +
> > +# Host requires the other files, which can be a module.
> > +obj-$(CONFIG_LGUEST)	+= lg.o
> > +lg-objs := core.o hypercalls.o page_tables.o interrupts_and_traps.o \
> > +	segments.o io.o lguest_user.o switcher.o
> Please use: lg-y :=
> Using -objs is no longer preferred.

Hi Sam!

	Thanks, will patch.

Cheers,
Rusty.
