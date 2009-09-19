From: Greg KH <greg@kroah.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sat, 19 Sep 2009 15:44:30 -0700
Message-ID: <20090919224430.GB9567@kroah.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753331AbZISWr5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1253233028.19731.63.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 17, 2009 at 05:17:08PM -0700, Alok Kataria wrote:
> Given this new development, I wanted to discuss how should we go about
> retiring the VMI code from mainline Linux, i.e. the vmi_32.c and
> vmiclock_32.c bits.
> 
> One of the options that I am contemplating is to drop the code from the
> tip tree in this release cycle, and given that this should be a low risk
> change we can remove it from Linus's tree later in the merge cycle.

That sounds good to me, how intrusive are the patches to do this?  Is it
going to be tricky to get everything merged properly in -tip for it?

thanks,

greg k-h
