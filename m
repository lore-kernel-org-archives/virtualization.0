From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 21:04:19 +0200
Message-ID: <20090922190419.GA24542@elte.hu>
References: <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com> <20090920074247.GA5733@elte.hu> <20090920095239.456ad6f2@infradead.org> <4AB5EF25.9070502@redhat.com> <4AB64EFC.10707@goop.org> <20090922080913.GB1475@elte.hu> <4AB900CC.7090409@goop.org> <20090922180216.GA16789@elte.hu> <4AB91478.2050508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751803AbZIVTGS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AB91478.2050508@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Avi Kivity <avi@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> On 09/22/09 11:02, Ingo Molnar wrote:
>
> > obviously they are workload dependent - that's why numbers were 
> > posted in this thread with various workloads. Do you concur with 
> > those conclusions that they are generally a speedup over paravirt? 
> > If not, which are the workloads where paravirt offers significant 
> > speedup over hardware acceleration?
> 
> We're not in a position to do any useful measurements yet.

Sorry for being dense, but what does that mean precisely? No available 
hardware? Xen doesnt run?

	Ingo
