Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3A8BE0
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499230; cv=none; b=VgwjrrXcgxj7n75zxIzwuGSeNRcYPzl7+8x74RwgNgXtAhHUc00O3rGfcZ9aoIADIE9pjqA8QW8T0lNTtf9Et5X25U4Pyc87hQnwVsbeHMdyK1zN/2noc43Kb/al2dy84c3FZq/0JNP72ZkhH0HsOlfpg0HEnck8oTe4OCisNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499230; c=relaxed/simple;
	bh=IRx6ViHd+hgFWkDpF0kdvEKAfipqLXwSTj1Re4NASyk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rduSLnaf/BjSV26vIEBEScvXrW3q1g0rNqxu9MJvpNgB/BOvGtXqtrDgcTusO926zdXGmUPyyWsVlgZgbjyKFrLdAeqyg/dYcXEOMFXk8k3cchtjhjRJm+QZSGlZhP+qIXNQJAQA6cshgtNcdnIYUN4cENC6ww9LOla4WMAkC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cx+emXQKtmCa8FAA--.19793S3;
	Thu, 01 Aug 2024 16:00:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxRuSUQKtma8EJAA--.48582S3;
	Thu, 01 Aug 2024 16:00:20 +0800 (CST)
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
Date: Thu, 1 Aug 2024 16:00:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240729065236.407758-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxRuSUQKtma8EJAA--.48582S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWUGFWfKF4kXr18XF4xAFc_yoW7Ww1xpF
	W7J3sYqFs5WFy0vrWDuw4Dur17Aws2kw13Wr4UWryDXan8Wr9Igr48tw4Y93WIgan2va4r
	tF10qr9ruw1DZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUU
	UU=

Chenyu,

I do not know much about x86, just give some comments(probably 
incorrected) from the code.

On 2024/7/29 下午2:52, Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> In current code, the static key is always enabled by default when
> running in guest mode. The key is disabled for bare metal (and in
> some guests that want native behavior).
> 
> Large performance regression is reported when running encode/decode
> workload and BenchSEE cache sub-workload on the bare metal.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled, the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Set the default value of virt_spin_lock_key to false. If booting in
> a VM, enable this key. Later during the VM initialization, if other
> high-efficient spinlock is detected(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled. According to the description above,
> the final effect will be as followed:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> To summarize, the virt_spin_lock_key is disabled on the bare metal
> no matter what other condidtion is. And the virt_spin_lock_key is
> also disabled when other spinlock mechanism is detected in the VM
> guest.
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3->v4:
>    Refine the commit log.
>    Added Reviewed-by tag from Nikolay.
> v2->v3:
>    Change the default value of virt_spin_lock_key from true to false.
>    Enable this key when it is in the VM, and disable it when needed.
>    This makes the code more readable. (Nikolay Borisov)
>    Dropped Reviewed-by because the code has been changed.
> v1->v2:
>    Refine the commit log per Dave's suggestion.
>    Simplify the fix by directly disabling the virt_spin_lock_key on bare metal.
>    Collect Reviewed-by from Juergen.
> ---
>   arch/x86/include/asm/qspinlock.h | 4 ++--
>   arch/x86/kernel/paravirt.c       | 7 +++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index a053c1293975..a32bd2aabdf9 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
>   
>   #ifdef CONFIG_PARAVIRT
>   /*
> - * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
> + * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
>    *
>    * Native (and PV wanting native due to vCPU pinning) should disable this key.
>    * It is done in this backwards fashion to only have a single direction change,
>    * which removes ordering between native_pv_spin_init() and HV setup.
>    */
> -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);

@@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
  {
         int val;

-       if (!static_branch_likely(&virt_spin_lock_key))
+       if (!static_branch_unlikely(&virt_spin_lock_key))
                 return false;

Do we need change it with static_branch_unlikely() if value of key is 
false by fault?
>   
>   /*
>    * Shortcut for the queued_spin_lock_slowpath() function that allows
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 5358d43886ad..fec381533555 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>   DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>   #endif
>   
> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>   
>   void __init native_pv_lock_init(void)
>   {
> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		static_branch_disable(&virt_spin_lock_key);
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		static_branch_enable(&virt_spin_lock_key);
>   }

 From my point, the sentence static_branch_disable(&virt_spin_lock_key) 
can be removed in file arch/x86/xen/spinlock.c and 
arch/x86/kernel/kvm.c, since function native_smp_prepare_boot_cpu() is 
already called by xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().

Regards
Bibo Mao

>   
>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
> 

