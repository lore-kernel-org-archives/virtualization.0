From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 29 Sep 2009 02:01:30 -0700
Message-ID: <20090929090130.GD3958@sequoia.sous-sol.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com> <20090920074247.GA5733@elte.hu> <1253647845.10565.20.camel@ank32.eng.vmware.com> <4AB9CE66.1030504@redhat.com> <1254185107.13456.32.camel@ank32.eng.vmware.com> <4AC17018.4040600@zytor.com> <1254193238.13456.48.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753557AbZI2JDY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1254193238.13456.48.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Gerd Hoffmann <kraxel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

* Alok Kataria (akataria@vmware.com) wrote:
> 
> On Mon, 2009-09-28 at 19:25 -0700, H. Peter Anvin wrote:
> > On 09/28/2009 05:45 PM, Alok Kataria wrote:
> > > +	bool "VMI Guest support [will be deprecated soon]"
> > > +	default n
> > 
> > This is incorrect use of the word "deprecated"... it's *already*
> > deprecated (a word which pretty much means the opposite of "recommended".)
> > 
> > As far as "default n" is concerned... this is usually not necessary; "n"
> > is the default unless anything else is specified.
> 
> How about this ?  Thanks.

Looks good to me (missing Signed-off-by).  I think it's also useful
to generate some runtime noise saying it's a deprecated option.

Even something as simple as:

-	pv_info.name = "vmi"
+	pv_info.name = "vmi [deprecated]";
