Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613BA271A9A;
	Wed, 19 Nov 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520779; cv=none; b=EKhXBWbcpNj/m1gOgJEcz71ESYGRj/0h+CGnpJ4DoUoglx+YMVRD+/CbbV6vaeCLkBVKJ0dAOqluJhx7Cm5kz4gp9v1CV4l0TBS9+f6lh7LcRtEz/RKuRdjGslbO/OhmGwEUn9sTlZJKv80S76Or+2dQvlqR0vQIHYtPpQnWuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520779; c=relaxed/simple;
	bh=y+iy2O3EUqfnIbkyx9YWbWqqPfKqmp1ItwRgoXX3Jqk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R+tbTXRVqKxoOXgjmYH8C318kV9k6LGKd3z+zzMns6/C8eD9cJ3VQ/wEc0+FI+OenaV8jK1lLmZruq+eRYeGtvmA0U0h2KSM9Z7MCJHkzbTvKdZ5pJtB0ozX7Gr0vwuHkz7Oo1I4P8c90NsxvHHZ0MD7IavT163RD0cXpAxYGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axz9MCMR1pZVIlAA--.9780S3;
	Wed, 19 Nov 2025 10:52:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxvsH_MB1phgI4AQ--.45268S3;
	Wed, 19 Nov 2025 10:52:49 +0800 (CST)
Subject: Re: [PATCH 2/3] LoongArch: Add paravirt support with
 vcpu_is_preempted()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
References: <20251118080656.2012805-1-maobibo@loongson.cn>
 <20251118080656.2012805-3-maobibo@loongson.cn>
 <CAAhV-H4hoS0Wo3TS+FdikXMkb7qjWNFSPDoajQr0bzdeROJwGw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <77814b6c-7a51-e130-5006-d27a172e69aa@loongson.cn>
Date: Wed, 19 Nov 2025 10:50:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4hoS0Wo3TS+FdikXMkb7qjWNFSPDoajQr0bzdeROJwGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxvsH_MB1phgI4AQ--.45268S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1DXry7Gw1fAFyUAF1xXrc_yoWrAF48pF
	yDAF1kWa1rWrn7Z39IqF98urn8Jrs5W3WIva47KFyrAFnrWryDJr1v93s09Fy0qa1qga4I
	vF93WFsY9F15tacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU43xhDUUUU



On 2025/11/18 下午8:48, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Nov 18, 2025 at 4:07 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Function vcpu_is_preempted() is used to check whether vCPU is preempted
>> or not. Here add implementation with vcpu_is_preempted() when option
>> CONFIG_PARAVIRT is enabled.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/smp.h      |  1 +
>>   arch/loongarch/include/asm/spinlock.h |  5 +++++
>>   arch/loongarch/kernel/paravirt.c      | 16 ++++++++++++++++
>>   arch/loongarch/kernel/smp.c           |  6 ++++++
>>   4 files changed, 28 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
>> index 3a47f52959a8..5b37f7bf2060 100644
>> --- a/arch/loongarch/include/asm/smp.h
>> +++ b/arch/loongarch/include/asm/smp.h
>> @@ -18,6 +18,7 @@ struct smp_ops {
>>          void (*init_ipi)(void);
>>          void (*send_ipi_single)(int cpu, unsigned int action);
>>          void (*send_ipi_mask)(const struct cpumask *mask, unsigned int action);
>> +       bool (*vcpu_is_preempted)(int cpu);
>>   };
>>   extern struct smp_ops mp_ops;
>>
>> diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
>> index 7cb3476999be..c001cef893aa 100644
>> --- a/arch/loongarch/include/asm/spinlock.h
>> +++ b/arch/loongarch/include/asm/spinlock.h
>> @@ -5,6 +5,11 @@
>>   #ifndef _ASM_SPINLOCK_H
>>   #define _ASM_SPINLOCK_H
>>
>> +#ifdef CONFIG_PARAVIRT
>> +#define vcpu_is_preempted      vcpu_is_preempted
>> +bool vcpu_is_preempted(int cpu);
>> +#endif
> Maybe paravirt.h is a better place?
how about put it in asm/qspinlock.h since it is included by header file 
asm/spinlock.h already?

> 
>> +
>>   #include <asm/processor.h>
>>   #include <asm/qspinlock.h>
>>   #include <asm/qrwlock.h>
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index b1b51f920b23..b99404b6b13f 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -52,6 +52,13 @@ static u64 paravt_steal_clock(int cpu)
>>   #ifdef CONFIG_SMP
>>   static struct smp_ops native_ops;
>>
>> +static bool pv_vcpu_is_preempted(int cpu)
>> +{
>> +       struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
>> +
>> +       return !!(src->preempted & KVM_VCPU_PREEMPTED);
>> +}
>> +
>>   static void pv_send_ipi_single(int cpu, unsigned int action)
>>   {
>>          int min, old;
>> @@ -308,6 +315,9 @@ int __init pv_time_init(void)
>>                  pr_err("Failed to install cpu hotplug callbacks\n");
>>                  return r;
>>          }
>> +
>> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
>> +               mp_ops.vcpu_is_preempted = pv_vcpu_is_preempted;
>>   #endif
>>
>>          static_call_update(pv_steal_clock, paravt_steal_clock);
>> @@ -332,3 +342,9 @@ int __init pv_spinlock_init(void)
>>
>>          return 0;
>>   }
>> +
>> +bool notrace vcpu_is_preempted(int cpu)
>> +{
>> +       return mp_ops.vcpu_is_preempted(cpu);
>> +}
> 
> We can simplify the whole patch like this, then we don't need to touch
> smp.c, and we can merge Patch-2/3.
> 
> +bool notrace vcpu_is_preempted(int cpu)
> +{
> +  if (!kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
> +     return false;
> + else {
> +     struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
> +     return !!(src->preempted & KVM_VCPU_PREEMPTED);
> + }
> +}
> Huacai
> 
>> +EXPORT_SYMBOL(vcpu_is_preempted);
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 46036d98da75..f04192fedf8d 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -307,10 +307,16 @@ static void loongson_init_ipi(void)
>>                  panic("IPI IRQ request failed\n");
>>   }
>>
>> +static bool loongson_vcpu_is_preempted(int cpu)
>> +{
>> +       return false;
>> +}
>> +
>>   struct smp_ops mp_ops = {
>>          .init_ipi               = loongson_init_ipi,
>>          .send_ipi_single        = loongson_send_ipi_single,
>>          .send_ipi_mask          = loongson_send_ipi_mask,
>> +       .vcpu_is_preempted      = loongson_vcpu_is_preempted,
>>   };
>>
>>   static void __init fdt_smp_setup(void)
>> --
>> 2.39.3
>>
>>

