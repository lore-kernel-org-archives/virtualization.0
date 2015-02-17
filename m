From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH V5] x86 spinlock: Fix memory corruption on completing
	completions
Date: Tue, 17 Feb 2015 13:26:07 -0500
Message-ID: <54E387BF.6010909@oracle.com>
References: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54E03652.8010104@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54E03652.8010104@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, oleg@redhat.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/15/2015 01:01 AM, Raghavendra K T wrote:
> On 02/15/2015 11:25 AM, Raghavendra K T wrote:
>> Paravirt spinlock clears slowpath flag after doing unlock.
>> As explained by Linus currently it does:
>>                  prev = *lock;
>>                  add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>
>>                  /* add_smp() is a full mb() */
>>
>>                  if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>>                          __ticket_unlock_slowpath(lock, prev);
>>
>> which is *exactly* the kind of things you cannot do with spinlocks,
>> because after you've done the "add_smp()" and released the spinlock
>> for the fast-path, you can't access the spinlock any more.  Exactly
>> because a fast-path lock might come in, and release the whole data
>> structure.
>>
>> Linus suggested that we should not do any writes to lock after unlock(),
>> and we can move slowpath clearing to fastpath lock.
>>
>> So this patch implements the fix with:
>> 1. Moving slowpath flag to head (Oleg):
>> Unlocked locks don't care about the slowpath flag; therefore we can keep
>> it set after the last unlock, and clear it again on the first (try)lock.
>> -- this removes the write after unlock. note that keeping slowpath flag would
>> result in unnecessary kicks.
>> By moving the slowpath flag from the tail to the head ticket we also avoid
>> the need to access both the head and tail tickets on unlock.
>>
>> 2. use xadd to avoid read/write after unlock that checks the need for
>> unlock_kick (Linus):
>> We further avoid the need for a read-after-release by using xadd;
>> the prev head value will include the slowpath flag and indicate if we
>> need to do PV kicking of suspended spinners -- on modern chips xadd
>> isn't (much) more expensive than an add + load.
>>
>> Result:
>>   setup: 16core (32 cpu +ht sandy bridge 8GB 16vcpu guest)
>>   benchmark overcommit %improve
>>   kernbench  1x           -0.13
>>   kernbench  2x            0.02
>>   dbench     1x           -1.77
>>   dbench     2x           -0.63
>>
>> [Jeremy: hinted missing TICKET_LOCK_INC for kick]
>> [Oleg: Moving slowpath flag to head, ticket_equals idea]
>> [PeterZ: Detailed changelog]
>>
>> Reported-by: Sasha Levin <sasha.levin@oracle.com>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
> 
> Sasha, Hope this addresses invalid read concern you had with latest
> xadd based implementation.
> 
> (Think we need to test without Oleg's PATCH] sched/completion: completion_done() should serialize with complete() reported by Paul.)
> 

I ran it for a while and everything seems to work correctly:

	Tested-by: Sasha Levin <sasha.levin@oracle.com>


Thanks,
Sasha
