From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
 address space
Date: Fri, 27 Oct 2006 21:50:37 -0700
Message-ID: <20061027215037.cd69b2a3.akpm@osdl.org>
References: <1161920325.17807.29.camel@localhost.localdomain>
	<1161920535.17807.33.camel@localhost.localdomain>
	<20061027113001.GB8095@elf.ucw.cz>
	<45427ABD.6070407@goop.org>
	<20061027144157.f23fcf89.akpm@osdl.org>
	<4542DD84.3070006@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750883AbWJ1Eut@vger.kernel.org>
In-Reply-To: <4542DD84.3070006@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 27 Oct 2006 21:33:08 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > It'd be better to use include/linux/uaccess.h:probe_kernel_address() for
> > this operation.
> >   
> Ah, yes, that was the precedent I was thinking of,

We've done open-coded __get_user() in various places in the past.  The difference with
probe_kernel_address() is that it doesn't get deadlocked on mmap_sem().

>  but I guess it would 
> be better to just use it directly.  It's a relatively new interface, 
> isn't it?

Yeah.  New enough that nobody's tried using it on non-x86 ;) It needs
to do set_fs(KERNEL_DS).
