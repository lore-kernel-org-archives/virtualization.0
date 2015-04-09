From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v15 13/15] pvqspinlock: Only kick CPU at unlock time
Date: Thu, 09 Apr 2015 18:06:01 -0400
Message-ID: <5526F7C9.1020600__5115.19341166622$1428617221$gmane$org@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-14-git-send-email-Waiman.Long@hp.com>
	<20150409195721.GA5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150409195721.GA5029@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/09/2015 03:57 PM, Peter Zijlstra wrote:
> On Mon, Apr 06, 2015 at 10:55:48PM -0400, Waiman Long wrote:
>
>> @@ -219,24 +236,30 @@ static void pv_wait_node(struct mcs_spinlock *node)
>>   }
>>
>>   /*
>> + * Called after setting next->locked = 1&  lock acquired.
>> + * Check if the the CPU has been halted. If so, set the _Q_SLOW_VAL flag
>> + * and put an entry into the lock hash table to be waken up at unlock time.
>>    */
>> -static void pv_kick_node(struct mcs_spinlock *node)
>> +static void pv_scan_next(struct qspinlock *lock, struct mcs_spinlock *node)
> I'm not too sure about that name change..

It is because the function will no longer kick the cpu. So I change the 
name to reflect that. I am not good at naming. Please let me know if you 
have a better name.

Cheers,
Longman
