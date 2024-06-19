Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18100612EB
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811280; cv=none; b=cHAI4X0+lqspoE5gtRuKCqRwuWpSVHokVQs+tlOHzhJNeEobywM8BC6HsfFdFG2qOIc1JbKtv7V8RKZp3SpSfVmxatrP0KVzZ/mzPT8T5KpbTsCFHhQGJgBZRBeqpuVezSRo/uoUBnHPV6+vdap8/aU/qdl7aJXhuDSH5tdjXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811280; c=relaxed/simple;
	bh=jqDmA1xhPa9cAQ3PsVJWQiiy/6PYLvShFiqYjdPKClI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5kivdKQ439UonQmkVdkFLJ7GDC3cz3Z/lNhluBRR28Kgj6BVaCTuTLuCd0CI1MIPORjSzhrbVYX4TyoSeM7nelZuOi5qdYXxKH+UB5UjyLaoKPmXYpvhDm26MU3IB8PleZOH3zusjI9g2FLeYPYA/S83itzBriPakwIktl6sFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SapxHLBw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SapxHLBw"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so5870910a12.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718811276; x=1719416076; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HA4mrpqQ8jwu0Mn4Tmivkqi1tASG/N4sN6iJD41Gbw=;
        b=SapxHLBwwysnUYfReq32RL78Lf8IeUj5yBL447ty7z6VRXKLEt029nLNb8X96+1f7N
         B741MV+KT2boecEgomkC0ob9Xvmj0JINBKTsyIsr/8ZB9VIJRUlC/zfjjUK9miv2MpBi
         FL6ZmDiKuyQk0/lI+CrL5z0HncWAjfd9NGG/UbNTUhapyLhs/aZz10ah+lyYjI/qy7Ef
         lkp8MYEWmDp3YcSTTzN+HMbZtGrSxJUkqMxvzW7rNBlVlzottLHMkA64/fCJi8pKN+WW
         7jRUjSN9Ca+sG+nJEKAJlVUB5OXUpqLGQjmXaPYam4+HlWiYzgzcCFvpwoGfRFQ7tII3
         FWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811276; x=1719416076;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HA4mrpqQ8jwu0Mn4Tmivkqi1tASG/N4sN6iJD41Gbw=;
        b=DK6zYaFQhSf2oIxQu/4YyOcldYKrFQqiBqb2e8ST7B0Tg/GVRPVcJPZAkvasLl5cFO
         c5Kun1Xdzvmw2gKjFQokqlRVskFGqMK17aOBqHB+mFGHzwabAlReOwmVwGwgCMZumaiz
         u9nR0fnrTyx7uivKZnqWqocGTwPNcvomihy/T1AmapCqGs1hpaM56vJ1qnX38C5fT6N3
         H9/OOyp5t9BIZyHgYVrV2iinTH8l8TNRMwDaZgjXwDUkeVxybMoynaye5to9eXb1A4Me
         4EA9Xq3I2NY+VpYgOrm7I57iSYIdHSCpkeY1pzYA7vrYARPdUvW4ThVQMclTiupVVd4L
         E0jw==
X-Forwarded-Encrypted: i=1; AJvYcCWHbBAVnjjFW2gXK9Lrol+A2vRIeN3Sb7SMiOmFVY3tR/GBX6U59MabTZPJS9f+6eEgPLLrbi12jzYilfxtBetqgcCUSjxv5UrRDx30fvA=
X-Gm-Message-State: AOJu0YwF5n16DUbGOzhkHGYqbNup47nb6KBmHuNWlzFxqZTl8VDA6uLm
	8uypMVB31MzV8JgXe5QYECIpVkKnverldr/ZsIG7lOz/+ePM3LZw4IGgoVltDSc=
X-Google-Smtp-Source: AGHT+IEYNLU1IDBDZuTl+IneSIpWywqCtiEIWECHwJmcjYUfaqhrlELWq3PBJzVtyCbp2vQX4ktLKw==
X-Received: by 2002:a50:9516:0:b0:57d:692:92d9 with SMTP id 4fb4d7f45d1cf-57d07e0d5d4mr1528839a12.4.1718811276328;
        Wed, 19 Jun 2024 08:34:36 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7438815sm8615126a12.80.2024.06.19.08.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:34:36 -0700 (PDT)
Message-ID: <5eeeb8ae-db72-4468-bff1-2de402ea113f@suse.com>
Date: Wed, 19 Jun 2024 18:34:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Juergen Gross
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
 <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
 <ZnL4VRwPNd58Ccl+@chenyu5-mobl2>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <ZnL4VRwPNd58Ccl+@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.06.24 г. 18:25 ч., Chen Yu wrote:
> Hi Nikolay,
> 
> On 2024-06-18 at 11:24:42 +0300, Nikolay Borisov wrote:
>>
>>
>> On 26.05.24 г. 4:58 ч., Chen Yu wrote:
>>> The kernel can change spinlock behavior when running as a guest. But
>>> this guest-friendly behavior causes performance problems on bare metal.
>>> So there's a 'virt_spin_lock_key' static key to switch between the two
>>> modes.
>>>
>>> The static key is always enabled by default (run in guest mode) and
>>> should be disabled for bare metal (and in some guests that want native
>>> behavior).
>>>
>>> Performance drop is reported when running encode/decode workload and
>>> BenchSEE cache sub-workload.
>>> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
>>> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
>>> is disabled the virt_spin_lock_key is incorrectly set to true on bare
>>> metal. The qspinlock degenerates to test-and-set spinlock, which
>>> decrease the performance on bare metal.
>>>
>>> Fix this by disabling virt_spin_lock_key if it is on bare metal,
>>> regardless of CONFIG_PARAVIRT_SPINLOCKS.
>>>
>>
>> nit:
>>
>> This bug wouldn't have happened if the key was defined FALSE by default and
>> only enabled in the appropriate case. I think it makes more sense to invert
>> the logic and have the key FALSE by default and only enable it iff the
>> kernel is running under a hypervisor... At worst only the virtualization
>> case would suffer if the lock is falsely not enabled.
> 
> Thank you for your review. I agree, initializing the key to FALSE by default seems
> to be more readable. Could this change be the subsequent adjustment based
> on current fix, which could be more bisectible?

Why can't this change be squashed in the current proposed patch?

> 
> 
> Set the default key to false. If booting in a VM, enable this key. Later during
> the VM initialization, if other high-efficient spinlock is preferred, like
> paravirt-spinlock, the virt_spin_lock_key will be disabled accordingly.

Yep, or simply during the initialization stage the correct flavor will 
be chosen, no need to do the on-off dance. But that's a topic for a 
different discussion.

> 
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index cde8357bb226..a7d3ba00e70e 100644
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
>   
>   /*
>    * Shortcut for the queued_spin_lock_slowpath() function that allows
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index c193c9e60a1b..fec381533555 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -51,12 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>   DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>   #endif
>   
> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>   
>   void __init native_pv_lock_init(void)
>   {
> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		static_branch_disable(&virt_spin_lock_key);
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		static_branch_enable(&virt_spin_lock_key);
>   }
>   
>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
