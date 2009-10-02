From: Alok Kataria <akataria@vmware.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Thu, 01 Oct 2009 21:45:21 -0700
Message-ID: <1254458721.8491.39.camel@ank32.eng.vmware.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	 <20090919224430.GB9567@kroah.com>
	 <1253419185.3253.21.camel@ank32.eng.vmware.com>
	 <20090920074247.GA5733@elte.hu>
	 <1253647845.10565.20.camel@ank32.eng.vmware.com>
	 <4AB9CE66.1030504@redhat.com>
	 <1254185107.13456.32.camel@ank32.eng.vmware.com>
	 <20090929100831.18ece319@infradead.org>
	 <1254242989.7803.11.camel@ank32.eng.vmware.com>
	 <m1y6nuxzx8.fsf@fess.ebiederm.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753518AbZJBEpT@vger.kernel.org>
In-Reply-To: <m1y6nuxzx8.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2009-10-01 at 20:00 -0700, Eric W. Biederman wrote:

> >> btw the "default" in KConfig tends to be totally ignored by distro
> >> kernel maintainers... please don't assume that just because some default
> >> is set in KConfig it has ANY impact on what shows up in distributions.
> >
> > So, are you saying that we should be doing something else along with
> > toggling it off in the Kconfig ? 
> > We have already informed most of the distro folks about this deprecation
> > so I think we should be okay there, but if there is something else that
> > should be done, do let me know.
> 
> Perhaps log a message when it is first used?

Yeah, Chris' suggestion about adding "deprecated" string in pv_info.name
does just that.

Thanks, 
Alok
