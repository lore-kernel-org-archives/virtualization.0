From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 22 Sep 2009 14:27:40 -0700
Message-ID: <4AB9414C.6060805@zytor.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>	 <20090919224430.GB9567@kroah.com>	 <1253419185.3253.21.camel@ank32.eng.vmware.com>	 <20090920074247.GA5733@elte.hu> <1253647845.10565.20.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753055AbZIVV3g@vger.kernel.org>
In-Reply-To: <1253647845.10565.20.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> Hi Ingo,
> 
> On Sun, 2009-09-20 at 00:42 -0700, Ingo Molnar wrote:
> 
>> The thing is, the overwhelming majority of vmware users dont benefit 
>> from hardware features like nested page tables yet. So this needs to be 
>> done _way_ more carefully, with a proper sunset period of a couple of 
>> kernel cycles.
> 
> I am fine with that too. Below is a patch which adds notes in
> feature-removal-schedule.txt, I have marked it for removal from 2.6.34.
> Please consider this patch for 2.6.32.
> 

This seems way, way too early still.

	-hpa
