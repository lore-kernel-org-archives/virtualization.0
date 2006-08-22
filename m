From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 15:45:22 +0200
Message-ID: <1156254322.2976.55.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932252AbWHVNpz@vger.kernel.org>
In-Reply-To: <1156254965.27114.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 14:56 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 11:06 -0700, ysgrifennodd Jeremy Fitzhardinge:
> > Rusty Russell wrote:
> > > +EXPORT_SYMBOL_GPL(paravirt_ops);
> > >   
> > This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
> > driver module will need to be GPL...
> 
> It would be nice not to export it at all or to protect it, paravirt_ops
> is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> is properly protected, its an unpleasantly large security target if not.
> 
> It would be a lot safer if we could have the struct paravirt_ops in
> protected read-only const memory space, set it up in the core kernel
> early on in boot when we play "guess todays hypervisor" and then make
> sure it stays in read only (even to kernel) space.

this would need a "const after boot" section; which is really not hard
to make and probably useful for a lot more things.... todo++


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
