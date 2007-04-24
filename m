From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Mon, 23 Apr 2007 23:58:20 -0700
Message-ID: <462DAA8C.10508@goop.org>
References: <20070327214919.800272641@goop.org>	<20070327215827.871954359@goop.org> <20070423234910.50149faf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161368AbXDXG55@vger.kernel.org>
In-Reply-To: <20070423234910.50149faf.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Prarit Bhargava <prarit@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Dan Hecht <dhecht@vmware.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chris Lalancette <clalance@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Tue, 27 Mar 2007 14:49:20 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> The softlockup watchdog is currently a nuisance in a virtual machine,
>> since the whole system could have the CPU stolen from it for a long
>> period of time.  While it would be unlikely for a guest domain to be
>> denied timer interrupts for over 10s, it could happen and any softlockup
>> message would be completely spurious.
>>
>> Earlier I proposed that sched_clock() return time in unstolen
>> nanoseconds, which is how Xen and VMI currently implement it.  If the
>> softlockup watchdog uses sched_clock() to measure time, it would
>> automatically ignore stolen time, and therefore only report when the
>> guest itself locked up.  When running native, sched_clock() returns
>> real-time nanoseconds, so the behaviour would be unchanged.
>>
>> Note that sched_clock() used this way is inherently per-cpu, so this
>> patch makes sure that the per-processor watchdog thread initialized
>> its own timestamp.
>>     
>
> This patch
> (ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc6/2.6.21-rc6-mm1/broken-out/ignore-stolen-time-in-the-softlockup-watchdog.patch)
> causes six failures in the locking self-tests, which I must say is rather
> clever of it.
>   

Interesting.  Which variation of sched_clock do you have in your tree at
the moment?

    J
