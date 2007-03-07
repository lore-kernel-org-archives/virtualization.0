From: Dan Hecht <dhecht@vmware.com>
Subject: Re: Xen & VMI?
Date: Wed, 07 Mar 2007 11:14:49 -0800
Message-ID: <45EF0F29.60305@vmware.com>
References: <45ED82D9.6050204@codemonkey.ws>	<8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>	<20070306203712.GC21736@elte.hu>	<1173228246.4644.85.camel@localhost.localdomain> <20070307081510.GB15111@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422964AbXCGTTT@vger.kernel.org>
In-Reply-To: <20070307081510.GB15111@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, Dan Hecht <dhecht@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/07/2007 12:15 AM, Ingo Molnar wrote:
> On the other hand, Linux's internal details, semantics, approaches are a 
> lot more ad-hoc and alot more affected by changes in the hardware 
> environment - that's why i'd not like to see some external ABI 
> constraint limit aspects of those internals.
> 
> For example, VMI_CALL_SetAlarm takes a 'cycles' argument. Cycles is a 
> quite bad unit for an API, it should be absolute time, nanosec or 
> picosec based instead. We could easily see CPUs that have /no concept of 
> cycles/, at all! Even today's CPUs have hardly any fix concept of 
> cycles, due to cpufreq. It's as if 15 years ago we had based sys_mmap() 
> around the concept of '16-bit segments'. We could certainly make it work 
> on current hardware but it would look pretty awkward today.
> 
>

Ingo,

In the VMI definition, "cycles" does not mean "cpu cycles".  It is used 
in the normal way to mean "an interval of time during which a sequence 
of a recurring succession of events or phenomena is completed" 
[Merriam-Webster].  In this case, the recurring event is the increment 
of a counter.  The routine VMI_CALL_GetCycleFrequency defines how many 
of these events occur per second.  The rate is not variable, so is not 
subject to cpu phenomena such as cpufreq.  And it does not need to be 
tied in any way to cpu cycle frequency.  How your cpu is implemented is 
not relevant.

If a hypervisor wishes to expose it's time counters in units of 
nanoseconds, then it simply returns 1000000000 from GetCycleFrequency.

Dan
