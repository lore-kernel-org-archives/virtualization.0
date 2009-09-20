From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sun, 20 Sep 2009 09:42:47 +0200
Message-ID: <20090920074247.GA5733@elte.hu>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753877AbZITHnc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1253419185.3253.21.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Alok Kataria <akataria@vmware.com> wrote:

> Here is the patch which actually removes the vmi code.
> 
> Signed-off-by: Alok N Kataria <akataria@vmware.com>
> ---
> 
>  Documentation/kernel-parameters.txt |    2 
>  arch/x86/Kconfig                    |   10 
>  arch/x86/include/asm/vmi.h          |  269 ----------
>  arch/x86/include/asm/vmi_time.h     |   98 ----
>  arch/x86/kernel/Makefile            |    1 
>  arch/x86/kernel/setup.c             |    7 
>  arch/x86/kernel/smpboot.c           |    9 
>  arch/x86/kernel/vmi_32.c            |  913 -----------------------------------
>  arch/x86/kernel/vmiclock_32.c       |  321 ------------
>  9 files changed, 1 insertions(+), 1629 deletions(-)
>  delete mode 100644 arch/x86/include/asm/vmi.h
>  delete mode 100644 arch/x86/include/asm/vmi_time.h
>  delete mode 100644 arch/x86/kernel/vmi_32.c
>  delete mode 100644 arch/x86/kernel/vmiclock_32.c

The thing is, the overwhelming majority of vmware users dont benefit 
from hardware features like nested page tables yet. So this needs to be 
done _way_ more carefully, with a proper sunset period of a couple of 
kernel cycles.

This is as if Intel had sent a patch to desupport say Core2 
optimizations, now that Nehalem is out.

'Virtual hardware' is no different in this respect: until users benefit 
from something we want to keep it, even if the vendor would like to sell 
new hardware and would like the new hardware to have an edge over the 
installed base.

If we were able to rip out all (or most) of paravirt from arch/x86 it 
would be tempting for other technical reasons - but the patch above is 
well localized.

	Ingo
