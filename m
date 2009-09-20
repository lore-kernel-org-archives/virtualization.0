From: Alok Kataria <akataria@vmware.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sat, 19 Sep 2009 20:56:34 -0700
Message-ID: <1253418994.3253.18.camel@ank32.eng.vmware.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	 <20090919224430.GB9567@kroah.com>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753821AbZITD4c@vger.kernel.org>
In-Reply-To: <20090919224430.GB9567@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


On Sat, 2009-09-19 at 15:44 -0700, Greg KH wrote:
> On Thu, Sep 17, 2009 at 05:17:08PM -0700, Alok Kataria wrote:
> > Given this new development, I wanted to discuss how should we go about
> > retiring the VMI code from mainline Linux, i.e. the vmi_32.c and
> > vmiclock_32.c bits.
> > 
> > One of the options that I am contemplating is to drop the code from the
> > tip tree in this release cycle, and given that this should be a low risk
> > change we can remove it from Linus's tree later in the merge cycle.
> 
> That sounds good to me, how intrusive are the patches to do this? 

It's a single patch, and the changes are pretty much self contained,
meat of the patch comprises of removing the vmi_32.c and vmiclock_32.c
file. I don't think we may want to break the changes down. 

Below are the diffstats, let me post the patch in a separate mail.

====
 Documentation/kernel-parameters.txt |    2 
 arch/x86/Kconfig                    |   10 
 arch/x86/include/asm/vmi.h          |  269 ----------
 arch/x86/include/asm/vmi_time.h     |   98 ----
 arch/x86/kernel/Makefile            |    1 
 arch/x86/kernel/setup.c             |    7 
 arch/x86/kernel/smpboot.c           |    9 
 arch/x86/kernel/vmi_32.c            |  913 -----------------------------------
 arch/x86/kernel/vmiclock_32.c       |  321 ------------
 9 files changed, 1 insertions(+), 1629 deletions(-)
 delete mode 100644 arch/x86/include/asm/vmi.h
 delete mode 100644 arch/x86/include/asm/vmi_time.h
 delete mode 100644 arch/x86/kernel/vmi_32.c
 delete mode 100644 arch/x86/kernel/vmiclock_32.c
====

>  Is it going to be tricky to get everything merged properly in -tip
> for it?

IMO, shouldn't be a problem.

Thanks,
Alok
