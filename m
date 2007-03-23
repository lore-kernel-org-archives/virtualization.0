From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] lguest: clean rest of linkage warnings (bar one)
Date: Fri, 23 Mar 2007 18:25:39 +1100
Message-ID: <1174634740.29496.12.camel@localhost.localdomain>
References: <1174532243.2713.95.camel@localhost.localdomain>
	 <1174558182.2713.151.camel@localhost.localdomain>
	 <20070322114549.GC29453@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933960AbXCWHZ5@vger.kernel.org>
In-Reply-To: <20070322114549.GC29453@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-22 at 12:45 +0100, Sam Ravnborg wrote:
> On Thu, Mar 22, 2007 at 09:09:42PM +1100, Rusty Russell wrote:
> > It also fixes the remaining warnings, except one.  The code in
> > modpost.c which needs to be taught that it's legal to link from
> > .paravirtprobe to .init.text is horrible, and I'm pretty sure I'd just
> > make it worse.
> 
> If you drop me a sample of the exact warning I will add this one too.
> Current kbuild.git contains a lot of fixes in this area so I refer to
> do so on top of that tree.

WARNING: vmlinux - Section mismatch: reference to .init.text: from .paravirtprobe between '__start_paravirtprobe' (at offset 0xc0464c7c) and '__stop_paravirtprobe'

Sam, you're always so polite and damn helpful: I'm pretty sure that
violates the core tenets of Linux etiquette.

Perhaps you could work on that?
Rusty.
