Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5715ECD4
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322937; cv=none; b=o3dmkBJeQQALuJuQ1FUpjjE+YlM7ojziaS/KsPO6XvXrn9o+yU54/ya9HwFD6yQHSCZh1aSYvZwU4yPN9qMqrQF2qpvYGdqAcH091XGYu+XZLUtZxJ+ON21qKGK+uCtpvIpzJ3g9UybPilVWPrGmhg9F7g2j6r/c0AcY6r8wAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322937; c=relaxed/simple;
	bh=kCWUIGs9OZe3ZSPUsdL0AZKlZk6a6lOvSF+HkD/n7YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyVieqZFzj9kyb/FemPTw6dyPDnSSitcPcBu0rEpHXTMhfU1O1Gn/iwTaLLhBKydE/HBczxIs4xqJwlku/OUXgH1MmUeKiyBjPkK9yjo03G3GoiyCGomN+bVI6xS7WucEs0sDhX/n+OSW10yVF1hD5en1NvDkO482VdJkZGVkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePanDZeV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ePanDZeV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so3481880f8f.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719322933; x=1719927733; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrBw1ViXI8PKGjD0P3Qbt3rk/F/dAyXw362A2nW4GkE=;
        b=ePanDZeVA3vrhz8U8FacBCE1jsgWadItRdONJaIBzrua2nbyIb0l0aIuoQ4qwiKHTh
         h3pTg74BLjj7b1HN/Wl7BClbyIgiF6YRdDwFrHNhTzBnYJ+xamDftttykRPkmW6oYdly
         IzPyTXbzLPmQMFNQ82UAJuR5x4tRzvPitQBNaNU2J1m+3z29axUEiELfHAf+dxMwTUxT
         5FCUhgj+oG177YRjRCSPlpsQGKOseQqe6Z8OJHvbfyrJOpk/TniwDESItPL/rrIlMysj
         99XIVncHu4djqQoE7ZdH9QVEpVJQZCKP2YDabPQbWgkLf+/pV4INFtaKJ1hgNPw7tc2J
         yr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322933; x=1719927733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrBw1ViXI8PKGjD0P3Qbt3rk/F/dAyXw362A2nW4GkE=;
        b=PLynNVHkJZtbaGBwSxdzdCsBVqPauSi6u+mpl98HRc1XFm2Ds0YsxYUbbhBujl9ohl
         gFhqMPFV8bes4ATfz7nl60rVRXG2pirlbPNmSKr6Y4f3DJfLXq+kB1b2OCZOuhgQPKod
         3SNS/e0CuUrruLdfStNtKAnK8gZgOskhwHYbE6kY9CUwx32nUsWNwVs1fwlM1nZbz9tm
         NxRCczDjRw0hlNtvbDXryETS6+ZFdDE9ZnDxVYBNFo9xe3z++FxKj2oO9DnuGaxg5cda
         wlSERfrA86oWjsFd8QZfT4NZuZGIVmUGhPlbNX/5DchsThJXsmn2dzdHCZetOdamOfBX
         ROYA==
X-Forwarded-Encrypted: i=1; AJvYcCXjSMjvySi9Z3+nGIudKkjfZMLKhzz1ZYF3nTphjyXNpt4kxBns0L0aitgFteRfYTjS1lQQm4+RHIN8HyrL5+N4cYIgel6OxsIIRFnlIy0=
X-Gm-Message-State: AOJu0Yxb5t+7NDmnGv6sHbKnmTIeQtXnjub0zLmKrMqxMTxpuctqDKGY
	wq/A9raQAi15aonArMLFFbvJBgE0BttnHeirs+c7efaV+5dQ3lb+VC6ThYA4VnA=
X-Google-Smtp-Source: AGHT+IGfxVH8cZhLOCvXgvPNcvNOE8ex439nMaaAuCPU2WaO9XCX6Uc4t/p/Ojo8lUWJHTo7ui6OzA==
X-Received: by 2002:adf:f6d0:0:b0:35f:231e:ef87 with SMTP id ffacd0b85a97d-366e7a3634fmr6303452f8f.29.1719322933410;
        Tue, 25 Jun 2024 06:42:13 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada0f8csm12930687f8f.115.2024.06.25.06.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:42:12 -0700 (PDT)
Message-ID: <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
Date: Tue, 25 Jun 2024 16:42:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240625125403.187110-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.06.24 г. 15:54 ч., Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> Performance drop is reported when running encode/decode workload and
> BenchSEE cache sub-workload.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Set the default value of virt_spin_lock_key to false. If booting in a VM,
> enable this key. Later during the VM initialization, if other
> high-efficient spinlock is preferred(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled accordingly. The relation is described as
> below:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2._v3:
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

Actually now shouldn't the CONFIG_PARAVIRT_SPINLOCKS check be retained? 
Otherwise we'll have the virtspinlock enabled even if we are a guest but 
CONFIG_PARAVIRT_SPINLOCKS is disabled, no ?

> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		static_branch_disable(&virt_spin_lock_key);
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		static_branch_enable(&virt_spin_lock_key);
>   }
>   
>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
