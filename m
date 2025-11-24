Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1C2E0418;
	Mon, 24 Nov 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967807; cv=none; b=fWJs6XlHVDFdtonUs8PNEjNZnOSNV5ypimVG/Yl5hNwNtvHc9RKhC5fEHyYfGx6dzdxXMDcwOIGWnPNtaYliasbqEQB0uZcJ9xZLUKgTQoqmFHZJqPanp7SnQ/Iqm6cyJKZVIk3CUrD7qBqEqAUIyoZZOQizJYkfM+L0xe5cE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967807; c=relaxed/simple;
	bh=nNKlhslL58Mk3Km4cfnD+sRsBwRSueImuegT0waTnoA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gU3Sr1ezRssVzZjJldGTB/DB4iBcD07x+QK9Jz6AJj6gYLpskSj1plX7zVW1XSYMmtyL3OhHe1FSEDvgcptN7CFluZIKus8RI6EtHF507ZkPvLVex2+OUEts12NK+Pg0Jtopf/qNR0ORylWD1YdSaVaP3XwE3QaLe2UxAw8Pe80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxb_A0AyRpJWgnAA--.20270S3;
	Mon, 24 Nov 2025 15:03:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxfcEqAyRpKnc9AQ--.46352S3;
	Mon, 24 Nov 2025 15:03:15 +0800 (CST)
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
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5d80c452-bbc3-539a-fb8d-14dbe353f8cb@loongson.cn>
Date: Mon, 24 Nov 2025 15:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcEqAyRpKnc9AQ--.46352S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1ktFyUur48KF4DCF17Arc_yoW5uF4UpF
	ykCFnYva1xGw1xA39Ivr1DCrn8tr4kW3WIqa42ka4rAF4qvr1DJr4v934q9Fy0gwn29a10
	qF93GFsIkFn7t3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU83UUUUUUUU==



On 2025/11/24 下午2:33, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Nov 24, 2025 at 11:54 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Function vcpu_is_preempted() is used to check whether vCPU is preempted
>> or not. Here add implementation with vcpu_is_preempted() when option
>> CONFIG_PARAVIRT is enabled.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/qspinlock.h |  5 +++++
>>   arch/loongarch/kernel/paravirt.c       | 16 ++++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>> index e76d3aa1e1eb..9a5b7ba1f4cb 100644
>> --- a/arch/loongarch/include/asm/qspinlock.h
>> +++ b/arch/loongarch/include/asm/qspinlock.h
>> @@ -34,6 +34,11 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>          return true;
>>   }
>>
>> +#ifdef CONFIG_SMP
>> +#define vcpu_is_preempted      vcpu_is_preempted
>> +bool vcpu_is_preempted(int cpu);
> In V1 there is a build error because you reference mp_ops, so in V2
> you needn't put it in CONFIG_SMP.
The compile failure problem is that vcpu_is_preempted() is redefined in 
both arch/loongarch/kernel/paravirt.c and include/linux/sched.h

The problem is that <asm/spinlock.h> is not included by sched.h, if 
CONFIG_SMP is disabled. Here is part of file include/linux/spinlock.h
#ifdef CONFIG_SMP
# include <asm/spinlock.h>
#else
# include <linux/spinlock_up.h>
#endif

> On the other hand, even if you really build a UP guest kernel, when
> multiple guests run together, you probably need vcpu_is_preemtped.
It is not relative with multiple VMs. When vcpu_is_preempted() is 
called, it is to detect whether dest CPU is preempted or not, the cpu 
from smp_processor_id() should not be preempted. So in generic 
vcpu_is_preempted() works on multiple vCPUs.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>> +#endif
>> +
>>   #endif /* CONFIG_PARAVIRT */
>>
>>   #include <asm-generic/qspinlock.h>
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index b1b51f920b23..d4163679adc4 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -246,6 +246,7 @@ static void pv_disable_steal_time(void)
>>   }
>>
>>   #ifdef CONFIG_SMP
>> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>>   static int pv_time_cpu_online(unsigned int cpu)
>>   {
>>          unsigned long flags;
>> @@ -267,6 +268,18 @@ static int pv_time_cpu_down_prepare(unsigned int cpu)
>>
>>          return 0;
>>   }
>> +
>> +bool notrace vcpu_is_preempted(int cpu)
>> +{
>> +       struct kvm_steal_time *src;
>> +
>> +       if (!static_branch_unlikely(&virt_preempt_key))
>> +               return false;
>> +
>> +       src = &per_cpu(steal_time, cpu);
>> +       return !!(src->preempted & KVM_VCPU_PREEMPTED);
>> +}
>> +EXPORT_SYMBOL(vcpu_is_preempted);
>>   #endif
>>
>>   static void pv_cpu_reboot(void *unused)
>> @@ -308,6 +321,9 @@ int __init pv_time_init(void)
>>                  pr_err("Failed to install cpu hotplug callbacks\n");
>>                  return r;
>>          }
>> +
>> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT))
>> +               static_branch_enable(&virt_preempt_key);
>>   #endif
>>
>>          static_call_update(pv_steal_clock, paravt_steal_clock);
>> --
>> 2.39.3
>>

