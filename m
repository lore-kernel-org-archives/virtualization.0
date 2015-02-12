From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] x86 spinlock: Fix memory corruption on completing
	completions
Date: Thu, 12 Feb 2015 20:58:16 +0530
Message-ID: <54DCC690.1070103__48022.5805346437$1423754872$gmane$org@linux.vnet.ibm.com>
References: <1423741647-2156-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150212150059.GA23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150212150059.GA23123@twins.programming.kicks-ass.net>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, oleg@redhat.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/12/2015 08:30 PM, Peter Zijlstra wrote:
> On Thu, Feb 12, 2015 at 05:17:27PM +0530, Raghavendra K T wrote:
[...]
>>
>> Linus suggested that we should not do any writes to lock after unlock(),
>> and we can move slowpath clearing to fastpath lock.
>>
>> So this patch implements the fix with:
>> 1. Moving slowpath flag to head (Oleg).
>> 2. use xadd to avoid read/write after unlock that checks the need for
>> unlock_kick (Linus).
>
> Maybe spend a few more words explaining these things; something like:
>
> Unlocked locks don't care about the slowpath flag; therefore we can keep
> it set after the last unlock, as long as we clear it again on the first
> (try)lock -- this removes the write after unlock.

Nit: I 'll reword a bit here since slowpath flag would result in
unnecessary kick but otherwise harmless IMO.
something like:
Unlocked locks don't care about the slowpath flag; therefore we can keep
it set after the last unlock, and clear it again on the first (try)lock.
-- this removes the write after unlock. note that keeping slowpath flag 
would result in unnecessary kicks.

> By moving the slowpath flag from the tail to the head ticket we avoid
> the need to access both the head and tail tickets on unlock.
>
> We can further avoid the need for a read-after-release by using xadd;
> the prev head value will include the slowpath flag and indicate if we
> need to do PV kicking of suspended spinners -- on modern chips xadd
> isn't (much) more expensive than an add + load.
>
> Its 'obvious' now, but maybe not so much after we've all not looked at
> this for a few months.
>

Absolutely correct. Thanks Peter for the detailed and very helpful
writeup.
