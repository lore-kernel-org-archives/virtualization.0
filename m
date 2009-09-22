From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 16:52:32 +0930
Message-ID: <200909221652.35446.rusty@rustcorp.com.au>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090920095239.456ad6f2@infradead.org> <4AB5EF25.9070502@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755374AbZIVHWh@vger.kernel.org>
In-Reply-To: <4AB5EF25.9070502@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 20 Sep 2009 06:30:21 pm Avi Kivity wrote:
> On 09/20/2009 10:52 AM, Arjan van de Ven wrote:
> > On Sun, 20 Sep 2009 09:42:47 +0200
> > Ingo Molnar<mingo@elte.hu>  wrote:
> >
> >    
> >> If we were able to rip out all (or most) of paravirt from arch/x86 it
> >> would be tempting for other technical reasons - but the patch above
> >> is well localized.
> >>      
> > interesting question is if this would allow us to remove a few of the
> > paravirt hooks....
> >    
> 
> kvm will be removing the pvmmu support soon; and Xen is talking about 
> running paravirtualized guests in a vmx/svm container where they don't 
> need most of the hooks.

When they're all gone, even I don't think lguest is sufficient excuse
to keep CONFIG_PARAVIRT.  Oh well.  But that will probably be a while.

Cheers,
Rusty.
