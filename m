From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 15:58:52 -0700
Message-ID: <4AB956AC.9050700@zytor.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>	 <20090919224430.GB9567@kroah.com>	 <1253419185.3253.21.camel@ank32.eng.vmware.com>	 <20090920074247.GA5733@elte.hu>	 <1253647845.10565.20.camel@ank32.eng.vmware.com>	 <4AB9414C.6060805@zytor.com> <1253656476.10565.28.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752220AbZIVXAo@vger.kernel.org>
In-Reply-To: <1253656476.10565.28.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> 
> What do you suggest would be the right time ? 
> 
> Please note that the next major release of VMware's product will not
> have this supported. Also that, most of our customers will actually be
> running some distro's enterprise release, rather than running the
> cutting edge kernel. So IMO there is still a window of around 1-1.5
> years, until a customer actually sees a kernel which has dropped VMI
> support.
> 

I would say it might make sense pulling it out around the end of 2010, 
which would be about 6 kernel releases from now -- 2.6.37.

	-hpa
