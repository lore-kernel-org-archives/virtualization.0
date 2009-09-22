From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 10:09:13 +0200
Message-ID: <20090922080913.GB1475@elte.hu>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com> <20090920074247.GA5733@elte.hu> <20090920095239.456ad6f2@infradead.org> <4AB5EF25.9070502@redhat.com> <4AB64EFC.10707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755385AbZIVIKR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AB64EFC.10707@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Avi Kivity <avi@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> On 09/20/09 02:00, Avi Kivity wrote:
> > On 09/20/2009 10:52 AM, Arjan van de Ven wrote:
> >> On Sun, 20 Sep 2009 09:42:47 +0200
> >> Ingo Molnar<mingo@elte.hu>  wrote:
> >>
> >>   
> >>> If we were able to rip out all (or most) of paravirt from arch/x86 it
> >>> would be tempting for other technical reasons - but the patch above
> >>> is well localized.
> >>>      
> >> interesting question is if this would allow us to remove a few of the
> >> paravirt hooks....
> >>    
> >
> > kvm will be removing the pvmmu support soon; and Xen is talking about
> > running paravirtualized guests in a vmx/svm container where they don't
> > need most of the hooks.
> 
> We have no plans to drop support for non-vmx/svm capable processors, 
> let alone require ept/npt.

But, just to map out our plans for the future, do you concur with the 
statements and numbers offered here by the VMware and KVM folks that
on sufficiently recent hardware, hardware-assisted virtualization 
outperforms paravirt_ops in many (most?) workloads?

I.e. paravirt_ops becomes a legacy hardware thing, not a core component 
of the design of arch/x86/.

(with a long obsoletion period, of course.)

Thanks,

	Ingo
