From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Mon, 16 Jan 2012 12:55:24 +0530
Message-ID: <4F13D0E4.3050407@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
	<62E14C21-4DF1-4C06-9CBB-FF36E4D49F64@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <62E14C21-4DF1-4C06-9CBB-FF36E4D49F64@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 08:42 AM, Alexander Graf wrote:
>
> On 14.01.2012, at 19:26, Raghavendra K T wrote:
>
>> Extends Linux guest running on KVM hypervisor to support pv-ticketlocks.
>>
>> During smp_boot_cpus  paravirtualied KVM guest detects if the hypervisor has
>> required feature (KVM_FEATURE_PVLOCK_KICK) to support pv-ticketlocks. If so,
>> support for pv-ticketlocks is registered via pv_lock_ops.
>>
>> Use KVM_HC_KICK_CPU hypercall to wakeup waiting/halted vcpu.
>>
>> Signed-off-by: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>> Signed-off-by: Suzuki Poulose<suzuki@in.ibm.com>
>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>> ---
>> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
>> index 7a94987..cf5327c 100644
>> --- a/arch/x86/include/asm/kvm_para.h
>> +++ b/arch/x86/include/asm/kvm_para.h
>> @@ -195,10 +195,20 @@ void kvm_async_pf_task_wait(u32 token);
>> void kvm_async_pf_task_wake(u32 token);
[...]
>> +}
>> +#endif	/* CONFIG_PARAVIRT_SPINLOCKS */
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index c7b05fc..4d7a950 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>
> This patch is mixing host and guest code. Please split those up.
>
>

Agree. The host code should have gone to patch 2.

> Alex
>
>> @@ -5754,8 +5754,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>>
