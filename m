From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/2] guard virt_spin_lock() with a static key
Date: Mon, 25 Sep 2017 10:44:42 -0400
Message-ID: <67764edc-4cb5-2404-ec90-6cb83a094298__37186.9263858118$1506350817$gmane$org@redhat.com>
References: <20170906173625.18158-1-jgross@suse.com>
	<780c50a0-160b-24e3-a5b2-6685953882e5@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <780c50a0-160b-24e3-a5b2-6685953882e5@suse.com>
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
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, peterz@infradead.org, rusty@rustcorp.com.au, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/25/2017 09:59 AM, Juergen Gross wrote:
> Ping?
>
> On 06/09/17 19:36, Juergen Gross wrote:
>> With virt_spin_lock() being guarded by a static key the bare metal case
>> can be optimized by patching the call away completely. In case a kernel
>> running as a guest it can decide whether to use paravitualized
>> spinlocks, the current fallback to the unfair test-and-set scheme, or
>> to mimic the bare metal behavior.
>>
>> V3:
>> - remove test for hypervisor environment from virt_spin_lock(9 as
>>   suggested by Waiman Long
>>
>> V2:
>> - use static key instead of making virt_spin_lock() a pvops function
>>
>> Juergen Gross (2):
>>   paravirt/locks: use new static key for controlling call of
>>     virt_spin_lock()
>>   paravirt,xen: correct xen_nopvspin case
>>
>>  arch/x86/include/asm/qspinlock.h     | 11 ++++++++++-
>>  arch/x86/kernel/paravirt-spinlocks.c |  6 ++++++
>>  arch/x86/kernel/smpboot.c            |  2 ++
>>  arch/x86/xen/spinlock.c              |  2 ++
>>  kernel/locking/qspinlock.c           |  4 ++++
>>  5 files changed, 24 insertions(+), 1 deletion(-)
>>
Acked-by: Waiman Long <longman@redhat.com>
