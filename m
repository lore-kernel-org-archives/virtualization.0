Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41600257859;
	Mon, 24 Nov 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973306; cv=none; b=GpbMObW5tEmSmKAOW80OLOT/FNU7NbNKT2xLMbx7uzGhvNePYffROgtRQ2OTwUd70hPZSSyS52mjs27vrGXD6wScDDJiKilLlIkpLJ+zJ6/ue02KYihl4AAMxIrZAhsB4Wwio0DOgYWYctD1HQmFnSxkHtg/Z5l9Ac/mi+dtOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973306; c=relaxed/simple;
	bh=Xb9i516x0AzspO1CRgWjsBZXTYtd4qfzaCz63e7W1U8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xh2kY1JAap/sB783z8ndeYWhez4gsaDk6Uvb2yNinDWKcKFjqSI4Wkf9IVtkWIZpP8/Ir9SiY/FrLsmgdIwSjXJDrm3P2uxez6yoEeEpLuzp6Jb0eyon7zhS7xPu6y4a6B812DNrPCITEGXG2OcuX3G4HcovJ0D3AVOORpbDh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx37+wGCRpKm8nAA--.17259S3;
	Mon, 24 Nov 2025 16:34:56 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxrcGmGCRpwII9AQ--.9636S3;
	Mon, 24 Nov 2025 16:34:51 +0800 (CST)
Subject: Re: [PATCH v2 2/3] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
References: <20251124035402.3817179-1-maobibo@loongson.cn>
 <20251124035402.3817179-3-maobibo@loongson.cn>
 <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>
 <5d80c452-bbc3-539a-fb8d-14dbe353f8cb@loongson.cn>
 <CAAhV-H66M+GZ2kB8BKR82BUeQcNZ8ACeXLxwjh-bsVZcca1cqQ@mail.gmail.com>
 <718b5b5d-2bb1-5d59-409e-54f54516a6b7@loongson.cn>
 <CAAhV-H4X5EAgDTnSGG+1pMWywoLAis5TH_jEWkvaY8p1m8hQMg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <611840bb-7f7d-3b13-dc89-b760d8eeda79@loongson.cn>
Date: Mon, 24 Nov 2025 16:32:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4X5EAgDTnSGG+1pMWywoLAis5TH_jEWkvaY8p1m8hQMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxrcGmGCRpwII9AQ--.9636S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw45CF18XF13tw17AFyrGrX_yoW7AryDpF
	yUJF1vqa18Gr1xA39Fqr1qkrn8tr4kG3WxXry7WFy5Ar1qvFnrJr1qqryj9Fyktwn7WF10
	qrykGF4S9Fy5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jOuc_UUUUU=



On 2025/11/24 下午4:03, Huacai Chen wrote:
> On Mon, Nov 24, 2025 at 3:50 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2025/11/24 下午3:13, Huacai Chen wrote:
>>> On Mon, Nov 24, 2025 at 3:03 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/11/24 下午2:33, Huacai Chen wrote:
>>>>> Hi, Bibo,
>>>>>
>>>>> On Mon, Nov 24, 2025 at 11:54 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> Function vcpu_is_preempted() is used to check whether vCPU is preempted
>>>>>> or not. Here add implementation with vcpu_is_preempted() when option
>>>>>> CONFIG_PARAVIRT is enabled.
>>>>>>
>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>> ---
>>>>>>     arch/loongarch/include/asm/qspinlock.h |  5 +++++
>>>>>>     arch/loongarch/kernel/paravirt.c       | 16 ++++++++++++++++
>>>>>>     2 files changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>>>>>> index e76d3aa1e1eb..9a5b7ba1f4cb 100644
>>>>>> --- a/arch/loongarch/include/asm/qspinlock.h
>>>>>> +++ b/arch/loongarch/include/asm/qspinlock.h
>>>>>> @@ -34,6 +34,11 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>>            return true;
>>>>>>     }
>>>>>>
>>>>>> +#ifdef CONFIG_SMP
>>>>>> +#define vcpu_is_preempted      vcpu_is_preempted
>>>>>> +bool vcpu_is_preempted(int cpu);
>>>>> In V1 there is a build error because you reference mp_ops, so in V2
>>>>> you needn't put it in CONFIG_SMP.
>>>> The compile failure problem is that vcpu_is_preempted() is redefined in
>>>> both arch/loongarch/kernel/paravirt.c and include/linux/sched.h
>>> But other archs don't define vcpu_is_preempted() under CONFIG_SMP, and
>> so what is advantage to implement this function if CONFIG_SMP is disabled?
> 1. Keep consistency with other architectures.
> 2. Keep it simple to reduce #ifdefs (and !SMP is just for build, not
> very useful in practice).
It seems that CONFIG_SMP can be removed in header file 
include/asm/qspinlock.h, since asm/spinlock.h and asm/qspinlock.h is 
only included when CONFIG_SMP is set, otherwise only linux/spinlock_up.h 
is included.

> 
>>
>>> you can consider to inline the whole vcpu_is_preempted() here.
>> Defining the function vcpu_is_preempted() as inlined is not so easy for
>> me, it beyond my ability now :(
>>
>> With static key method, the static key need be exported, all modules
>> need apply the jump label, that is dangerous and I doubt whether it is
>> deserved.
> No, you have already done similar things in virt_spin_lock(), it is an
> inline function and uses virt_spin_lock_key.
virt_spin_lock is only called qspinlock in function 
queued_spin_lock_slowpath(). Function vcpu_is_preempted() is defined 
header file linux/sched.h, kernel module may use it.


> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>
>>>>
>>>> The problem is that <asm/spinlock.h> is not included by sched.h, if
>>>> CONFIG_SMP is disabled. Here is part of file include/linux/spinlock.h
>>>> #ifdef CONFIG_SMP
>>>> # include <asm/spinlock.h>
>>>> #else
>>>> # include <linux/spinlock_up.h>
>>>> #endif
>>>>
>>>>> On the other hand, even if you really build a UP guest kernel, when
>>>>> multiple guests run together, you probably need vcpu_is_preemtped.
>>>> It is not relative with multiple VMs. When vcpu_is_preempted() is
>>>> called, it is to detect whether dest CPU is preempted or not, the cpu
>>>> from smp_processor_id() should not be preempted. So in generic
>>>> vcpu_is_preempted() works on multiple vCPUs.
>>> OK, I'm wrong here.
>>>
>>>
>>> Huacai
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>>
>>>>> Huacai
>>>>>
>>>>>> +#endif
>>>>>> +
>>>>>>     #endif /* CONFIG_PARAVIRT */
>>>>>>
>>>>>>     #include <asm-generic/qspinlock.h>
>>>>>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>>>>>> index b1b51f920b23..d4163679adc4 100644
>>>>>> --- a/arch/loongarch/kernel/paravirt.c
>>>>>> +++ b/arch/loongarch/kernel/paravirt.c
>>>>>> @@ -246,6 +246,7 @@ static void pv_disable_steal_time(void)
>>>>>>     }
>>>>>>
>>>>>>     #ifdef CONFIG_SMP
>>>>>> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>>>>>>     static int pv_time_cpu_online(unsigned int cpu)
>>>>>>     {
>>>>>>            unsigned long flags;
>>>>>> @@ -267,6 +268,18 @@ static int pv_time_cpu_down_prepare(unsigned int cpu)
>>>>>>
>>>>>>            return 0;
>>>>>>     }
>>>>>> +
>>>>>> +bool notrace vcpu_is_preempted(int cpu)
>>>>>> +{
>>>>>> +       struct kvm_steal_time *src;
>>>>>> +
>>>>>> +       if (!static_branch_unlikely(&virt_preempt_key))
>>>>>> +               return false;
>>>>>> +
>>>>>> +       src = &per_cpu(steal_time, cpu);
>>>>>> +       return !!(src->preempted & KVM_VCPU_PREEMPTED);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(vcpu_is_preempted);
>>>>>>     #endif
>>>>>>
>>>>>>     static void pv_cpu_reboot(void *unused)
>>>>>> @@ -308,6 +321,9 @@ int __init pv_time_init(void)
>>>>>>                    pr_err("Failed to install cpu hotplug callbacks\n");
>>>>>>                    return r;
>>>>>>            }
>>>>>> +
>>>>>> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT))
>>>>>> +               static_branch_enable(&virt_preempt_key);
>>>>>>     #endif
>>>>>>
>>>>>>            static_call_update(pv_steal_clock, paravt_steal_clock);
>>>>>> --
>>>>>> 2.39.3
>>>>>>
>>>>
>>>>
>>
>>

