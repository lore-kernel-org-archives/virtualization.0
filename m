From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH for stable] x86/spinlocks/paravirt: Fix memory corruption
	on unlock
Date: Tue, 24 Feb 2015 23:49:13 +0530
Message-ID: <54ECC0A1.1080802__48648.5697947957$1424801943$gmane$org@linux.vnet.ibm.com>
References: <1424769899-14158-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150224141731.GA16033@kroah.com>
	<20150224144737.GA26074@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150224144737.GA26074@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, Greg KH <gregkh@linuxfoundation.org>, oleg@redhat.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/24/2015 08:17 PM, Ingo Molnar wrote:
>
> * Greg KH <gregkh@linuxfoundation.org> wrote:
>
>> On Tue, Feb 24, 2015 at 02:54:59PM +0530, Raghavendra K T wrote:
>>> Paravirt spinlock clears slowpath flag after doing unlock.
>>> As explained by Linus currently it does:
>>>                  prev = *lock;
>>>                  add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>>
>>>                  /* add_smp() is a full mb() */
>>>
>>>                  if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>>>                          __ticket_unlock_slowpath(lock, prev);
>>>
>>> which is *exactly* the kind of things you cannot do with spinlocks,
>>> because after you've done the "add_smp()" and released the spinlock
>>> for the fast-path, you can't access the spinlock any more.  Exactly
>>> because a fast-path lock might come in, and release the whole data
>>> structure.
>>>
>>> Linus suggested that we should not do any writes to lock after unlock(),
>>> and we can move slowpath clearing to fastpath lock.
>>>
>>> So this patch implements the fix with:
>>> 1. Moving slowpath flag to head (Oleg):
>>> Unlocked locks don't care about the slowpath flag; therefore we can keep
>>> it set after the last unlock, and clear it again on the first (try)lock.
>>> -- this removes the write after unlock. note that keeping slowpath flag would
>>> result in unnecessary kicks.
>>> By moving the slowpath flag from the tail to the head ticket we also avoid
>>> the need to access both the head and tail tickets on unlock.
>>>
>>> 2. use xadd to avoid read/write after unlock that checks the need for
>>> unlock_kick (Linus):
>>> We further avoid the need for a read-after-release by using xadd;
>>> the prev head value will include the slowpath flag and indicate if we
>>> need to do PV kicking of suspended spinners -- on modern chips xadd
>>> isn't (much) more expensive than an add + load.
>>>
>>> Result:
>>>   setup: 16core (32 cpu +ht sandy bridge 8GB 16vcpu guest)
>>>   benchmark overcommit %improve
>>>   kernbench  1x           -0.13
>>>   kernbench  2x            0.02
>>>   dbench     1x           -1.77
>>>   dbench     2x           -0.63
>>>
>>> [Jeremy: hinted missing TICKET_LOCK_INC for kick]
>>> [Oleg: Moving slowpath flag to head, ticket_equals idea]
>>> [PeterZ: Detailed changelog]
>>>
>>> Reported-by: Sasha Levin <sasha.levin@oracle.com>
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>> Acked-by: David Vrabel <david.vrabel@citrix.com>
>>> ---
>>>   arch/x86/include/asm/spinlock.h | 94 ++++++++++++++++++++---------------------
>>>   arch/x86/kernel/kvm.c           |  7 ++-
>>>   arch/x86/xen/spinlock.c         |  7 ++-
>>>   3 files changed, 58 insertions(+), 50 deletions(-)
>>>
>>> Changes for stable:
>>>    - Don't replace the ACCESS_ONCE to READ_ONCE which would cause horraneous
>>>      Compiler warnings (Linus, David Vbriel, PeterZ, Ingo)
>>
>> What is the git commit id of this in Linus's tree?  What
>> stable tree(s) do you want this applied to?
>
> It's:
>
>   d6abfdb20223 x86/spinlocks/paravirt: Fix memory corruption on unlock

Yes, This is the original patch. Please note I have taken out the
READ_ONCE changes from the original patch to avoid build warnings
mentioned below.
(Those READ_ONCE changes were cosmetic and was not present in the
previous versions)

>
> You'll also need this fix from Linus to avoid (harmless)
> build warnings:
>
>   dd36929720f4 kernel: make READ_ONCE() valid on const arguments

So this may not be absolutely necessary with the current patch.
