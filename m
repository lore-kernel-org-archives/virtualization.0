Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6D219FC
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586439; cv=none; b=iabYJXBW2J0e11M5JLAXGc0i8dHawg+un7JPSR+22OC74/3SvUxKks7ojbeSReZ4VaKHPUX+KQpr2+4RJNZyu1ED0OwmTwff+Vg2EBcTRyEQgH/r9VW8WotdqvfR4vIicB63IckmYcUXGw5Nas1E3ktcUAJppssEBdOBdCSAH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586439; c=relaxed/simple;
	bh=S3QFd9Kl1nKch5VJRX3/dqGnujPwpLW4bRmtw0FjPGw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VudLHXEcTKzrN6Qc6VP8bBYZq0yMdHCBpb1bKvp7c+c3seyknqoxgqK14yrka3w4rN+5zaXMczNaI6QnPIPMnjVrBtjCM7Fuy8wAT5vfRXr3kA2mGEtbZuSEcXUB5c+fIoB9LUnPybwpBon3QDsl+F/Vz2Zp2HqI3xEZzM+j9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxW+pBlaxmVF8GAA--.22440S3;
	Fri, 02 Aug 2024 16:13:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxRuQ9laxmfmsLAA--.55973S3;
	Fri, 02 Aug 2024 16:13:51 +0800 (CST)
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
 <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
 <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
 <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c543a2e1-a4ea-5f81-cc3f-6bd0185c7461@loongson.cn>
Date: Fri, 2 Aug 2024 16:13:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxRuQ9laxmfmsLAA--.55973S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFWfZw15GFyrXrWxtw47trc_yoW7ArW5pr
	W7J3Z3KF1kXr4FvwnFvr4vvryjy39Fkw1DXr15W34rJa90vrnIqF4kt3yY9a12qrn7ta97
	tF4UXrZxZa4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU


Hi Chenyu,
On 2024/8/2 下午3:56, Chen Yu wrote:
> On 2024-08-02 at 09:27:32 +0800, maobibo wrote:
>> Hi Chenyu,
>>
>> On 2024/8/1 下午10:40, Chen Yu wrote:
>>> Hi Bibo,
>>>
>>> On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
>>>> Chenyu,
>>>>
>>>> I do not know much about x86, just give some comments(probably incorrected)
>>>> from the code.
>>>>
>>>> On 2024/7/29 下午2:52, Chen Yu wrote:
>>>>> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
>>>>> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
>>>>> PV spinlock                    Y    N    N     Y/N
>>>>>
>>>>> virt_spin_lock_key             N    N    Y     N
>>>>>
>>>>> -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>>>> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>>
>>>> @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>>>    {
>>>>           int val;
>>>>
>>>> -       if (!static_branch_likely(&virt_spin_lock_key))
>>>> +       if (!static_branch_unlikely(&virt_spin_lock_key))
>>>>                   return false;
>>>>
>>>> Do we need change it with static_branch_unlikely() if value of key is false
>>>> by fault?
>>>
>>> My understanding is that, firstly, whether it is likely() or unlikely()
>>> depends on the 'expected' value of the key, rather than its default
>>> initialized value. The compiler can arrange the if 'jump' condition to
>>> avoid the overhead of branch jump(to keep the instruction pipeline)
>>> as much as possible. Secondly, before this patch, the 'expected' value
>>> of virt_spin_lock_key is 'true', so I'm not sure if we should change
>>> its behavior. Although it seems that in most VM guest, with para-virt
>>> spinlock enabled, this key should be false at most time, but just in
>>> case of any regression...
>> yes, it does not inflect the result, it is a trivial thing and depends on
>> personal like or dislike.
>>
>>>
>>>>>     /*
>>>>>      * Shortcut for the queued_spin_lock_slowpath() function that allows
>>>>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>>>>> index 5358d43886ad..fec381533555 100644
>>>>> --- a/arch/x86/kernel/paravirt.c
>>>>> +++ b/arch/x86/kernel/paravirt.c
>>>>> @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>>>>>     DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>>>>>     #endif
>>>>> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>>>> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>>>     void __init native_pv_lock_init(void)
>>>>>     {
>>>>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>>>>> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> -		static_branch_disable(&virt_spin_lock_key);
>>>>> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> +		static_branch_enable(&virt_spin_lock_key);
>>>>>     }
>>>>
>>>>   From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
>>>> be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
>>>> function native_smp_prepare_boot_cpu() is already called by
>>>> xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
>>>>
>>>
>>> The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
>>> the initial value(default to true). And later either arch/x86/xen/spinlock.c
>>> or arch/x86/kernel/kvm.c disable this key in a on-demand manner.
>> I understand that you only care about host machine and do not want to change
>> behavior of VM. Only that from the view of VM, there are two conditions such
>> as:
>>
>> 1. If option CONFIG_PARAVIRT_SPINLOCKS is disabled, virt_spin_lock_key is
>> disabled with your patch. VM will use test-set spinlock rather than
>> qspinlock to avoid the over-preemption of native qspinlock, just the same
>> with commit 2aa79af64263. And it is the same for all the hypervisor types.
>>
>> 2. If option CONFIG_PARAVIRT_SPINLOCKS is enable, pv spinlock cannot be used
>> because some reasons, such as host hypervisor has no KVM_FEATURE_PV_UNHALT
>> feature or nopvspin kernel parameter is added. The behavior to use test-set
>> spinlock or native qspinlock is different on different hypervisor types.
>>
>> Even on KVM hypervisor, if KVM_FEATURE_PV_UNHALT is not supported, test-set
>> spinlock will be used on VM; For nopvspin kernel parameter, native spinlock
>> is used on VM. What is the rule for this? :)
>>
> 
> If CONFIG_PARAVIRT_SPINLOCKS is enabled, the test-set spinlock has nothing to do
> with the lock path, because if pv_enabled() is true, it will skip the
IIRC, if CONFIG_PARAVIRT_SPINLOCKS is enabled, there is two qspinlock 
path: native_queued_spin_lock_slowpath() and 
__pv_queued_spin_lock_slowpath(). pv_enabled is false for native 
qspinlock path native_queued_spin_lock_slowpath(), test-set spinlock can 
be used in function native_queued_spin_lock_slowpath(). pv_enabled() is 
true only for function __pv_queued_spin_lock_slowpath().

> test-set spinlock and go to pv_queue section. If for some reason the pv spinlock
> can not be used because KVM_FEATURE_PV_UNHALT is not supported, it will fall into
> the default qpinlock without pv-qspinlock(no pv_wait hook because it is NULL).
yes, if pv spinlock cannot be used, native_queued_spin_lock_slowpath() 
will be called for spin_lock_slowpath, then there will be native 
qspinlock and test-test spinlock.

Regards
Bibo Mao
> 
> thanks,
> Chenyu
> 

