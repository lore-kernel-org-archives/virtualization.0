From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 12:30:35 -0700
Message-ID: <4AB925DB.1070906@goop.org>
References: <20090919224430.GB9567@kroah.com> <1253419185.3253.21.camel@ank32.eng.vmware.com> <20090920074247.GA5733@elte.hu> <20090920095239.456ad6f2@infradead.org> <4AB5EF25.9070502@redhat.com> <4AB64EFC.10707@goop.org> <20090922080913.GB1475@elte.hu> <4AB900CC.7090409@goop.org> <20090922180216.GA16789@elte.hu> <4AB91478.2050508@goop.org> <20090922190419.GA24542@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752007AbZIVTai@vger.kernel.org>
In-Reply-To: <20090922190419.GA24542@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, George Dunlap <George.Dunlap@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/22/09 12:04, Ingo Molnar wrote:
> Sorry for being dense, but what does that mean precisely? No available 
> hardware? Xen doesnt run?

Nobody has implemented hybrid PV mode yet, so we haven't got anything to
measure.

Also, I don't think there have been very many measurements of Linux HVM
(full virtualization) Xen guests, because Linux is typically run
paravirtualized and HVM support is primarily tuned for Windows guests.

    J
