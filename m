Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F73848D
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562066; cv=none; b=qeJp70Qun2s6aqh//QUzXhB/9KAscSiUkIjV3yXHq0I122QrB7VVWOkEzcMRxvqntQdS7MNYePZRM4aH3gw444jRf+G2dcbTSOpE9JK3W0kMmLmITWYuPStN570nyNOdE7i6SR+MlC4cqgNFPAblfgye4QFzrpkYmsEt3ldfn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562066; c=relaxed/simple;
	bh=Bo7CyCSCfTo4lFIIiFGKSmBdMQs6UBJCBOSER2j2Pxo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F0toD2CzgDhijZNyK2S+VaiLjVUbkTuttmJefvq1hNbgD1/NPPqUUHxpnE13hgdE1i0+IcqmlhfQA8BdEMjeLN++qAukFxAvyjDCsXL5/udi6taOI1I8wqJVVR7ZBmvAMtudk1WEGtYkzsXloE8P96VrbIHs6+PToPashK8v8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxi+oGNqxm7TQGAA--.22034S3;
	Fri, 02 Aug 2024 09:27:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxysUFNqxmGwMLAA--.53376S3;
	Fri, 02 Aug 2024 09:27:33 +0800 (CST)
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
From: maobibo <maobibo@loongson.cn>
Message-ID: <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
Date: Fri, 2 Aug 2024 09:27:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxysUFNqxmGwMLAA--.53376S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF48uFWDKFWrXF4DXr15ZFc_yoWrWrWrpr
	W7JFnYqF1kXF4FvwsIvw4vqr4jy39Fkw1DXrn8Grn5Xan8ZrnIqr48tws093W2qr1Iy34r
	tF45XrZxZayUZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

Hi Chenyu,

On 2024/8/1 下午10:40, Chen Yu wrote:
> Hi Bibo,
> 
> On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
>> Chenyu,
>>
>> I do not know much about x86, just give some comments(probably incorrected)
>> from the code.
>>
>> On 2024/7/29 下午2:52, Chen Yu wrote:
>>> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
>>> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
>>> PV spinlock                    Y    N    N     Y/N
>>>
>>> virt_spin_lock_key             N    N    Y     N
>>>
>>> -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>
>> @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>   {
>>          int val;
>>
>> -       if (!static_branch_likely(&virt_spin_lock_key))
>> +       if (!static_branch_unlikely(&virt_spin_lock_key))
>>                  return false;
>>
>> Do we need change it with static_branch_unlikely() if value of key is false
>> by fault?
> 
> My understanding is that, firstly, whether it is likely() or unlikely()
> depends on the 'expected' value of the key, rather than its default
> initialized value. The compiler can arrange the if 'jump' condition to
> avoid the overhead of branch jump(to keep the instruction pipeline)
> as much as possible. Secondly, before this patch, the 'expected' value
> of virt_spin_lock_key is 'true', so I'm not sure if we should change
> its behavior. Although it seems that in most VM guest, with para-virt
> spinlock enabled, this key should be false at most time, but just in
> case of any regression...
yes, it does not inflect the result, it is a trivial thing and depends 
on personal like or dislike.

> 
>>>    /*
>>>     * Shortcut for the queued_spin_lock_slowpath() function that allows
>>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>>> index 5358d43886ad..fec381533555 100644
>>> --- a/arch/x86/kernel/paravirt.c
>>> +++ b/arch/x86/kernel/paravirt.c
>>> @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>>>    DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>>>    #endif
>>> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>    void __init native_pv_lock_init(void)
>>>    {
>>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>>> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>> -		static_branch_disable(&virt_spin_lock_key);
>>> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>> +		static_branch_enable(&virt_spin_lock_key);
>>>    }
>>
>>  From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
>> be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
>> function native_smp_prepare_boot_cpu() is already called by
>> xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
>>
> 
> The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
> the initial value(default to true). And later either arch/x86/xen/spinlock.c
> or arch/x86/kernel/kvm.c disable this key in a on-demand manner.
I understand that you only care about host machine and do not want to 
change behavior of VM. Only that from the view of VM, there are two 
conditions such as:

1. If option CONFIG_PARAVIRT_SPINLOCKS is disabled, virt_spin_lock_key 
is disabled with your patch. VM will use test-set spinlock rather than 
qspinlock to avoid the over-preemption of native qspinlock, just the 
same with commit 2aa79af64263. And it is the same for all the hypervisor 
types.

2. If option CONFIG_PARAVIRT_SPINLOCKS is enable, pv spinlock cannot be 
used because some reasons, such as host hypervisor has no 
KVM_FEATURE_PV_UNHALT feature or nopvspin kernel parameter is added. The 
behavior to use test-set spinlock or native qspinlock is different on 
different hypervisor types.

Even on KVM hypervisor, if KVM_FEATURE_PV_UNHALT is not supported, 
test-set spinlock will be used on VM; For nopvspin kernel parameter, 
native spinlock is used on VM. What is the rule for this? :)

Regards
Bibo Mao
> 
> thanks,
> Chenyu
> 

