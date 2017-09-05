From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 10:19:03 -0400
Message-ID: <7fd8ed7b-2a26-499a-8036-ca1e8af7e390__33211.1977077604$1504621191$gmane$org@redhat.com>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
	<3eee978b-e570-5675-7840-c448375b02fc@redhat.com>
	<20170905140813.e455trgmcq3ahzry@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905140813.e455trgmcq3ahzry@hirez.programming.kicks-ass.net>
Content-Language: en-US
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/05/2017 10:08 AM, Peter Zijlstra wrote:
> On Tue, Sep 05, 2017 at 10:02:57AM -0400, Waiman Long wrote:
>> On 09/05/2017 09:24 AM, Juergen Gross wrote:
>>> +static inline bool native_virt_spin_lock(struct qspinlock *lock)
>>> +{
>>> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
>>> +		return false;
>>> +
>> I think you can take the above if statement out as you has done test in
>> native_pv_lock_init(). So the test will also be false here.
> That does mean we'll run a test-and-set spinlock until paravirt patching
> happens though. I prefer to not do that.
>
> One important point.. we must not be holding any locks when we switch
> over between the two locks. Back then I spend some time making sure that
> didn't happen with the X86 feature flag muck.

AFAICT, native_pv_lock_init() is called before SMP init. So it shouldn't
matter.

Cheers,
Longman
