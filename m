From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Thu, 02 Apr 2015 12:28:30 -0400
Message-ID: <551D6E2E.1080801__48191.0676615827$1427992133$gmane$org@hp.com>
References: <5509E51D.7040909@hp.com>
	<20150319101242.GM21418@twins.programming.kicks-ass.net>
	<20150319122536.GD11574@worktop.ger.corp.intel.com>
	<551C1ACE.4090408@hp.com>
	<20150401171223.GO23123@twins.programming.kicks-ass.net>
	<20150401174239.GO24151@twins.programming.kicks-ass.net>
	<20150401181744.GE32047@worktop.ger.corp.intel.com>
	<551C3EF5.6090809@hp.com>
	<20150401184858.GA9791@dyad.arnhem.chello.nl>
	<551C4E02.8030806@hp.com>
	<20150401210317.GZ27490@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150401210317.GZ27490@worktop.programming.kicks-ass.net>
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

On 04/01/2015 05:03 PM, Peter Zijlstra wrote:
> On Wed, Apr 01, 2015 at 03:58:58PM -0400, Waiman Long wrote:
>> On 04/01/2015 02:48 PM, Peter Zijlstra wrote:
>> I am sorry that I don't quite get what you mean here. My point is that in
>> the hashing step, a cpu will need to scan an empty bucket to put the lock
>> in. In the interim, an previously used bucket before the empty one may get
>> freed. In the lookup step for that lock, the scanning will stop because of
>> an empty bucket in front of the target one.
> Right, that's broken. So we need to do something else to limit the
> lookup, because without that break, a lookup that needs to iterate the
> entire array in order to determine -ENOENT, which is expensive.
>
> So my alternative proposal is that IFF we can guarantee that every
> lookup will succeed -- the entry we're looking for is always there, we
> don't need the break on empty but can probe until we find the entry.
> This will be bound in cost to the same number if probes we required for
> insertion and avoids the full array scan.
>
> Now I think we can indeed do this, if as said earlier we do not clear
> the bucket on insert if the cmpxchg succeeds, in that case the unlock
> will observe _Q_SLOW_VAL and do the lookup, the lookup will then find
> the entry. And we then need the unlock to clear the entry.
> _Q_SLOW_VAL
> Does that explain this? Or should I try again with code?

OK, I got your proposal now. However, there is still the issue that 
setting the _Q_SLOW_VAL flag and the hash bucket are not atomic wrt each 
other. It is possible a CPU has set the _Q_SLOW_VAL flag but not yet 
filling in the hash bucket while another one is trying to look for it. 
So we need to have some kind of synchronization mechanism to let the 
lookup CPU know when is a good time to look up.

One possibility is to delay setting _Q_SLOW_VAL until the hash bucket is 
set up. Maybe we can make that work.

Cheers,
Longman
