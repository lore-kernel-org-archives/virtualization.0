From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/11] qspinlock: Optimize for smaller NR_CPUS
Date: Mon, 07 Jul 2014 17:08:17 +0200
Message-ID: <53BAB7E1.4010506__14247.278442099$1404746252$gmane$org@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.483502389@chello.nl> <53A17A88.7090705@redhat.com>
	<20140707143503.GS6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140707143503.GS6758@twins.programming.kicks-ass.net>
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
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Il 07/07/2014 16:35, Peter Zijlstra ha scritto:
> On Wed, Jun 18, 2014 at 01:39:52PM +0200, Paolo Bonzini wrote:
>> Il 15/06/2014 14:47, Peter Zijlstra ha scritto:
>>>
>>> -	for (;;) {
>>> -		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
>>> -
>>> -		old = atomic_cmpxchg(&lock->val, val, new);
>>> -		if (old == val)
>>> -			break;
>>> -
>>> -		val = old;
>>> -	}
>>> +	clear_pending_set_locked(lock, val);
>>> 	return;
>>
>>
>> Might as well add clear_pending_set_locked already in patch 3.
>
> Patch 4, if anywhere.
>

This code is added in patch 3:

+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * *,1,0 -> *,0,1
+	 */
+	for (;;) {
+		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+	return;

Unlike the change in patch 4, clear_pending_set_locked doesn't change 
how qspinlock moves from a state to the next.

Paolo
