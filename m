From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: Use wmb instead of rmb in xen_evtchn_do_upcall().
Date: Wed, 11 Jun 2008 07:54:51 +0100
Message-ID: <484F76BB.20507__49173.5678086572$1213167475$gmane$org@goop.org>
References: <20080610073532.GG24381%yamahata@valinux.co.jp>
	<200806101741.39871.nickpiggin@yahoo.com.au>
	<484E33F1.5000503@goop.org>
	<200806101815.53729.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806101815.53729.nickpiggin@yahoo.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Isaku Yamahata <yamahata@valinux.co.jp>, Keir Fraser <Keir.Fraser@eu.citrix.com>, Samuel Thibault <samuel.thibault@eu.citrix.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Nick Piggin wrote:
> On Tuesday 10 June 2008 17:57, Jeremy Fitzhardinge wrote:
>   
>> Nick Piggin wrote:
>>     
>>> On Tuesday 10 June 2008 17:35, Isaku Yamahata wrote:
>>>       
>>>> This patch is ported one from 534:77db69c38249 of linux-2.6.18-xen.hg.
>>>> Use wmb instead of rmb to enforce ordering between
>>>> evtchn_upcall_pending and evtchn_pending_sel stores
>>>> in xen_evtchn_do_upcall().
>>>>         
>>> There are a whole load of places in the kernel that should be using
>>> smp_ variants of memory barriers. This seemed to me like one of them,
>>> but I could be wrong.
>>>       
>> No, it needs to be an unconditional barrier.  This is synchronizing with
>> the hypervisor - even if the kernel is compiled UP, the SMP hypervisor
>> may be testing/setting the events pending bits from another (physical) cpu.
>>     
>
> OK. What you *really* want is smp_*mb_even_if_compiled_for_UP() ;)
> That is, a small set of primitives that are compiled with CONFIG_SMP
> (and given some xxx_ prefix to distinguish).
>   

We already have a set of sync_* for atomic ops which are always locked.

> IO barriers are probably the best thing you can use for the moment.
>   

It is conceptually similar, I suppose.

       J
