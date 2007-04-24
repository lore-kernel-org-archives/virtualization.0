From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 23:20:06 +0200
Message-ID: <200704242320.06470.ak@suse.de>
References: <20070327214919.800272641@goop.org> <462E6778.7070305@goop.org> <1177447948.12796.66.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030767AbXDXVUT@vger.kernel.org>
In-Reply-To: <1177447948.12796.66.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Daniel Walker <dwalker@mvista.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Prarit Bhargava <prarit@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>, virtualization@lists.osdl.org, Chris Lalancette <clalance@redhat.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 24 April 2007 22:52:27 Daniel Walker wrote:
> On Tue, 2007-04-24 at 13:24 -0700, Jeremy Fitzhardinge wrote:
> 
> > And sched_clock's use of local_irq_save/restore appears to be absolutely
> > correct, so I think it must be triggering a bug in either the self-tests
> > or lockdep itself.
> 
> Why does sched_clock need to disable interrupts?

It's only used in the instable path which is kind of "i already threw up
my hands" anyways

I use it because when you transition from stable (TSC) to instable (jiffies)
the only way to avoid the clock jumping backwards is to remember and update the 
last value. To avoid races with parallel cpufreq handlers or timer
interrupts this small section needs to run with interrupts disabled.

The alternative would be a seqlock, but people have complained about this
earlier too so i judged irq disabling better.

-Andi
