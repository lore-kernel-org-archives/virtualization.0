From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] x86/paravirt: Add kernel parameter to choose paravirt
	lock type
Date: Wed, 1 Nov 2017 12:28:54 -0400
Message-ID: <409ede92-5243-0d9b-7893-b596f3f353aa__46148.8578272567$1509553747$gmane$org@redhat.com>
References: <1509550367-19255-1-git-send-email-longman@redhat.com>
	<404a9fab-03ff-174e-4ece-79932a6f302c@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <404a9fab-03ff-174e-4ece-79932a6f302c@suse.com>
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
To: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/01/2017 11:51 AM, Juergen Gross wrote:
> On 01/11/17 16:32, Waiman Long wrote:
>> Currently, there are 3 different lock types that can be chosen for
>> the x86 architecture:
>>
>>  - qspinlock
>>  - pvqspinlock
>>  - unfair lock
>>
>> One of the above lock types will be chosen at boot time depending on
>> a number of different factors.
>>
>> Ideally, the hypervisors should be able to pick the best performing
>> lock type for the current VM configuration. That is not currently
>> the case as the performance of each lock type are affected by many
>> different factors like the number of vCPUs in the VM, the amount vCPU
>> overcommitment, the CPU type and so on.
>>
>> Generally speaking, unfair lock performs well for VMs with a small
>> number of vCPUs. Native qspinlock may perform better than pvqspinlock
>> if there is vCPU pinning and there is no vCPU over-commitment.
>>
>> This patch adds a new kernel parameter to allow administrator to
>> choose the paravirt spinlock type to be used. VM administrators can
>> experiment with the different lock types and choose one that can best
>> suit their need, if they want to. Hypervisor developers can also use
>> that to experiment with different lock types so that they can come
>> up with a better algorithm to pick the best lock type.
>>
>> The hypervisor paravirt spinlock code will override this new parameter
>> in determining if pvqspinlock should be used. The parameter, however,
>> will override Xen's xen_nopvspin in term of disabling unfair lock.
> Hmm, I'm not sure we need pvlock_type _and_ xen_nopvspin. What do others
> think?

I don't think we need xen_nopvspin, but I don't want to remove that
without agreement from the community.
>>  DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>  
>>  void __init native_pv_lock_init(void)
>>  {
>> -	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
>> +	if (pv_spinlock_type == locktype_unfair)
>> +		return;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
>> +	   (pv_spinlock_type != locktype_auto))
>>  		static_branch_disable(&virt_spin_lock_key);
> Really? I don't think locktype_paravirt should disable the static key.

With paravirt spinlock, it doesn't matter if the static key is disabled
or not. Without CONFIG_PARAVIRT_SPINLOCKS, however, it does degenerate
into the native qspinlock. So you are right, I should check for paravirt
type as well.

Cheers,
Longman
