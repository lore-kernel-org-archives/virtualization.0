From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sun, 20 Sep 2009 09:52:39 +0200
Message-ID: <20090920095239.456ad6f2@infradead.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	<20090919224430.GB9567@kroah.com>
	<1253419185.3253.21.camel@ank32.eng.vmware.com>
	<20090920074247.GA5733@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753990AbZITHz3@vger.kernel.org>
In-Reply-To: <20090920074247.GA5733@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 20 Sep 2009 09:42:47 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> If we were able to rip out all (or most) of paravirt from arch/x86 it 
> would be tempting for other technical reasons - but the patch above
> is well localized.

interesting question is if this would allow us to remove a few of the
paravirt hooks....


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
