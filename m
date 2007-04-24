From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 13:52:27 -0700
Message-ID: <1177447948.12796.66.camel@imap.mvista.com>
References: <20070327214919.800272641@goop.org>
	 <20070327215827.871954359@goop.org>
	 <20070423234910.50149faf.akpm@linux-foundation.org>
	 <462E43A7.1050001@goop.org>
	 <20070424105738.e0ce36a9.akpm@linux-foundation.org>
	 <462E4969.6070802@goop.org>
	 <20070424113222.ed2e1314.akpm@linux-foundation.org>
	 <462E61F1.7060403@goop.org>  <462E6778.7070305@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423098AbXDXUxz@vger.kernel.org>
In-Reply-To: <462E6778.7070305@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Prarit Bhargava <prarit@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, john stultz <johnstul@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>, virtualization@lists.osdl.org, Chris Lalancette <clalance@redhat.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-04-24 at 13:24 -0700, Jeremy Fitzhardinge wrote:

> And sched_clock's use of local_irq_save/restore appears to be absolutely
> correct, so I think it must be triggering a bug in either the self-tests
> or lockdep itself.

Why does sched_clock need to disable interrupts?

Daniel
