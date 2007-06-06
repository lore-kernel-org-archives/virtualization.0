From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 12:52:59 +0100
Message-ID: <C28C5EAB.1024D%keir__13971.3449789726$1181130814$gmane$org@xensource.com>
References: <4666AFEF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763833AbXFFLxU@vger.kernel.org>
In-Reply-To: <4666AFEF.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org




On 6/6/07 12:00, "Jan Beulich" <jbeulich@novell.com> wrote:

>> If the error across CPUS is +/- just a few microseconds at worst then having
>> the clocksource clamp to no less than the last timestamp returned seems a
>> reasonable fix. Time won't 'stop' for longer than the cross-CPU error, and
>> that should always be a tiny value.
> 
> Are you sure this is also true when e.g. a CPU gets throttled due to thermal
> conditions? It is my understanding that both the duty cycle adjustment and
> the frequency reduction would yield a reduced rate TSC, which would be
> accounted for only the next time the local clock gets calibrated. Otherwise,
> immediate calibration (and vcpu update) would need to be forced out of the
> thermal interrupt.

Yes, this could be an issue. Is there any way to get an interrupt or MCE
when thermal throttling occurs?

 -- Keir
