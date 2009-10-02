From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Thu, 01 Oct 2009 20:00:51 -0700
Message-ID: <m1y6nuxzx8.fsf@fess.ebiederm.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	<20090919224430.GB9567@kroah.com>
	<1253419185.3253.21.camel@ank32.eng.vmware.com>
	<20090920074247.GA5733@elte.hu>
	<1253647845.10565.20.camel@ank32.eng.vmware.com>
	<4AB9CE66.1030504@redhat.com>
	<1254185107.13456.32.camel@ank32.eng.vmware.com>
	<20090929100831.18ece319@infradead.org>
	<1254242989.7803.11.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756405AbZJBDBI@vger.kernel.org>
In-Reply-To: <1254242989.7803.11.camel@ank32.eng.vmware.com> (Alok Kataria's message of "Tue\, 29 Sep 2009 09\:49\:49 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Arjan van de Ven <arjan@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria <akataria@vmware.com> writes:

> On Tue, 2009-09-29 at 01:08 -0700, Arjan van de Ven wrote:
>> > For now I have just added some text in the feature-removal file and
>> > disabled VMI by default in the Kconfig, the reason that needs to be
>> > done is because "Live Migration" of a VMI enabled VM to future
>> > products which don't support VMI will not work, so its important that
>> > newer distros keep this disabled, if they want seamless migration
>> > that is.
>> 
>> btw the "default" in KConfig tends to be totally ignored by distro
>> kernel maintainers... please don't assume that just because some default
>> is set in KConfig it has ANY impact on what shows up in distributions.
>
> So, are you saying that we should be doing something else along with
> toggling it off in the Kconfig ? 
> We have already informed most of the distro folks about this deprecation
> so I think we should be okay there, but if there is something else that
> should be done, do let me know.

Perhaps log a message when it is first used?

I do that for sysctl right now.

Eric
