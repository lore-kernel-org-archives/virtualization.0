From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Wed, 01 Apr 2015 16:10:34 -0400
Message-ID: <551C50BA.8070308__34497.5878288553$1427919062$gmane$org@hp.com>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com>
	<20150319101242.GM21418@twins.programming.kicks-ass.net>
	<20150319122536.GD11574@worktop.ger.corp.intel.com>
	<551C1ACE.4090408@hp.com>
	<20150401171223.GO23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150401171223.GO23123@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On 04/01/2015 01:12 PM, Peter Zijlstra wrote:
> On Wed, Apr 01, 2015 at 12:20:30PM -0400, Waiman Long wrote:
>> After more careful reading, I think the assumption that the presence of an
>> unused bucket means there is no match is not true. Consider the scenario:
>>
>> 1. cpu 0 puts lock1 into hb[0]
>> 2. cpu 1 puts lock2 into hb[1]
>> 3. cpu 2 clears hb[0]
>> 4. cpu 3 looks for lock2 and doesn't find it
> Hmm, yes. The only way I can see that being true is if we assume entries
> are never taken out again.
>
> The wikipedia page could use some clarification here, this is not clear.
>
>> At this point, I am thinking using back your previous idea of passing the
>> queue head information down the queue.
> Having to scan the entire array for a lookup sure sucks, but the wait
> loops involved in the other idea can get us in the exact predicament we
> were trying to get out, because their forward progress depends on other
> CPUs.

For the waiting loop, the worst case is when a new CPU get queued right 
before we write the head value to the previous tail node. In the case, 
the maximum number of retries is equal to the total number of CPUs - 2. 
But that should rarely happen.

I do find a way to guarantee forward progress in a few steps. I will try 
the normal way once. If that fails, I will insert the head node to the 
tail once again after saving the next pointer. After modifying the 
previous tail node, cmpxchg will be used to restore the previous tail. 
If that fails, we just have to wait until the next pointer is updated 
and write it out to the previous tail node. We can now restore the next 
pointer and move forward.

Let me know if that looks reasonable to you.

-Longman
