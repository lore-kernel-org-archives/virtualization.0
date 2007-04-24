From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 10:51:35 -0700
Message-ID: <462E43A7.1050001@goop.org>
References: <20070327214919.800272641@goop.org>	<20070327215827.871954359@goop.org> <20070423234910.50149faf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422889AbXDXRvQ@vger.kernel.org>
In-Reply-To: <20070423234910.50149faf.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Prarit Bhargava <prarit@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Dan Hecht <dhecht@vmware.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chris Lalancette <clalance@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> It seems fairly sensitive to .config settings.  See
> http://userweb.kernel.org/~akpm/config-sony.txt
>   

I haven't tried your config yet, but I haven't managed to reproduce it
by playing with the usual suspects in my config (SMP, PREEMPT).  Any
idea about which config changes make the difference?

Hm, is it caused by using sched_clock() to generate the printk
timestamps while generating the lock test output?

    J
