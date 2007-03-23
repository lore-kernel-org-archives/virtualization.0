From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH RFC] Change softlockup watchdog to ignore stolen time
Date: Thu, 22 Mar 2007 16:51:51 -0800
Message-ID: <460324A7.3010604@vmware.com>
References: <460311FA.6070400@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752784AbXCVXvm@vger.kernel.org>
In-Reply-To: <460311FA.6070400@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Hecht <dhecht@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Akinobu Mita <mita@miraclelinux.com>, Andrew Morton <akpm@linux-foundation.org>, James Morris <jmorris@namei.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> The softlockup watchdog is currently a nuisance in a virtual machine,
> since the whole system could have the CPU stolen from it for a long
> period of time.  While it would be unlikely for a guest domain to be
> denied timer interrupts for over 10s, it could happen and any softlockup
> message would be completely spurious.
>   

No, it is not unlikely.  4-way SMP VMs idling exhibit this behavior with 
NO_HZ or NO_IDLE_HZ because they get quiet enough to schedule nothing on 
the APs.

And that can happen on native hardware as well.

> Earlier I proposed that sched_clock() return time in unstolen
> nanoseconds, which is how Xen and VMI currently implement it.  If the
> softlockup watchdog uses sched_clock() to measure time, it would
> automatically ignore stolen time, and therefore only report when the
> guest itself locked up.  When running native, sched_clock() returns
> real-time nanoseconds, so the behaviour would be unchanged.
>
> Does this seem sound?
>
> Also, softlockup.c's use of jiffies seems archaic now.  Should it be
> converted to use timers?  Mightn't it report lockups just because there
> was no timer event?
>   

This looks good to me, as a first order approximation.  But on native 
hardware, with NO_HZ, this is just broken to begin with.  Perhaps we 
should make SOFTLOCKUP depend on !NO_HZ.

Zach
