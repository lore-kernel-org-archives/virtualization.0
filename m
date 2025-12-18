Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805532E13B;
	Thu, 18 Dec 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059975; cv=none; b=ktGy0b7ymd9jqIPkT40tmm3m10DIDm8h4ElhTQ9RVdbyUa9+fMksbek/nM+ghXyuXPUW8szSPb69FnwiFMrq+oflqrDKgVIk+mCMeaxSAt7OhiCphpmOAQ6BvE6lNrJJgOvEbmXl4APEORFH+B9GGhFldtjUhIMZ08J0ayIR3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059975; c=relaxed/simple;
	bh=/Lag984MhuskRtOVAooSzdmrvbrlYsL+tVPR06diles=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N7D3Yk+wTT9ejimtLSgouvgtMr3yBWhGWPhHjdz44xTo3ZUObBaxrz0rgI2ouHeag+utDJ4xGfQw1jcF39/4oSjop369M0Yp85m363qZNhjIl7GD/u1DwY6oOW/yrngh3P4rt89e5a+CkLdTIbvFhAjbrRDv/oG2JwJN+chxgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxecK670Np3HUAAA--.1449S3;
	Thu, 18 Dec 2025 20:12:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxLMK370NpSFIBAA--.2641S3;
	Thu, 18 Dec 2025 20:12:41 +0800 (CST)
Subject: Re: [PATCH v3 2/2] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
References: <20251202024833.1714363-1-maobibo@loongson.cn>
 <20251202024833.1714363-3-maobibo@loongson.cn>
 <CAAhV-H6D_XxGTgWjzO26JtBcNeaouqrzH1wTaCn7xK3HGtZ55w@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c9e3cd01-0c88-adc2-fdd1-ed85414c7550@loongson.cn>
Date: Thu, 18 Dec 2025 20:10:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6D_XxGTgWjzO26JtBcNeaouqrzH1wTaCn7xK3HGtZ55w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMK370NpSFIBAA--.2641S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4xGryfCFy5ury7Ar1kWFX_yoW5tF1fpa
	4DAFs5Ka1xG34xC39xtr4Durn8tryvg3WIva47ua45A34DZwnrJr10gryY9FykXwn7WF4I
	qFn3WFsI9F42yagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==



On 2025/12/6 下午9:04, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Dec 2, 2025 at 10:48 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Function vcpu_is_preempted() is used to check whether vCPU is preempted
>> or not. Here add implementation with vcpu_is_preempted() when option
>> CONFIG_PARAVIRT is enabled.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/qspinlock.h |  3 +++
>>   arch/loongarch/kernel/paravirt.c       | 23 ++++++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>> index e76d3aa1e1eb..fa3eaf7e48f2 100644
>> --- a/arch/loongarch/include/asm/qspinlock.h
>> +++ b/arch/loongarch/include/asm/qspinlock.h
>> @@ -34,6 +34,9 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>          return true;
>>   }
>>
>> +#define vcpu_is_preempted      vcpu_is_preempted
>> +bool vcpu_is_preempted(int cpu);
>> +
>>   #endif /* CONFIG_PARAVIRT */
>>
>>   #include <asm-generic/qspinlock.h>
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index b1b51f920b23..b61a93c6aec8 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -246,6 +246,7 @@ static void pv_disable_steal_time(void)
>>   }
>>
>>   #ifdef CONFIG_SMP
>> +static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
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
>> @@ -318,7 +334,12 @@ int __init pv_time_init(void)
>>                  static_key_slow_inc(&paravirt_steal_rq_enabled);
>>   #endif
>>
>> -       pr_info("Using paravirt steal-time\n");
>> +#ifdef CONFIG_SMP
> 
> Linux kernel is removing non-SMP step by step [1].
> https://kernelnewbies.org/Linux_6.17#Unconditionally_compile_task_scheduler_with_SMP_support
> 
> Though we cannot remove all "#ifdef CONFIG_SMP" at present, we can at
> least stop adding more.
> 
> So I prefer to make this whole patch out of CONFIG_SMP. But if you
> don't like this, you can at least move the virt_preempt_key
> declaration out of "#ifdef CONFIG_SMP", then the #ifdefs here can be
> removed.
Sorry, I just notice this mail.
Will move virt_preempt_key out of CONFIG_SMP in next version.

Regards
Bibo Mao
> 
> Huacai
> 
>> +       if (static_key_enabled(&virt_preempt_key))
>> +               pr_info("Using paravirt steal-time with preempt enabled\n");
>> +       else
>> +#endif
>> +               pr_info("Using paravirt steal-time with preempt disabled\n");
>>
>>          return 0;
>>   }
>> --
>> 2.39.3
>>
>>

