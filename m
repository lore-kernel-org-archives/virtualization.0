Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE51174EE1
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328098; cv=none; b=WLjgYXii4wefxDztS2gmjyK/+H4fa2iyeJ7UWwyIauGVfiyXIas4BLweNB/gpXSRcL5zMRETgrnngghrV7t0D9rio4y3nnTJWYMTXab6bIQDsZD1CAVZ1nToDup+UygCUDQd6y8XNbfRUBG490WOBHz7q/FrhYFtm/h0pWhl+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328098; c=relaxed/simple;
	bh=4enIMpHi1Xn6f+fHM0aE45Dle25fTkEI4Cx2AfW8Vm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEAnp9mCE0V+NpCjSowTWnAr3lsjDTboyBt0VKhWBa7j3aQG+B5Fbrr28pUaB9Hz/495FMW716i0lzS1mna4eRk7NYQZup0ln7oKSyItBbUK87S8pOPvuVgQx5WZZGm0p3xGPzMoTcaK8rYUwtF1bV7D0nL/AfLjtzMuM3ChyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Enh14Aer; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Enh14Aer"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso47099235e9.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719328094; x=1719932894; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxvSRp3VocyM/CgCZaoDNuJQwjocVwA+KlmzpeRd3EI=;
        b=Enh14Aer3AhcMNnwgYP6HlWXaUYyfv8jfLFlYWnWKEhEH0koCchNWgpYD/XxRzRNbx
         4oPmH3egnLIF+qJrlOzCX7kIgTVG8jH3+6tRMOUYnqS8TPLJKH7/M9TaLHqbzPRyLVkB
         ysnwJx9gaCmswYuHDc4CeJY8gEKavEcZNzW0xeRT1fxIOslia2u1TRaWUhNkd1b2xZV+
         p3wj++ZdPmxGdZ9jod5T+V2wB6sPDaR86ciNJrtm2DcKin4FfN0dBttNH5JXwiPdw9zX
         jQ2QQ5XC760FwpE5KuN0VUr3oNPS3i4vPhh47MlniYyv/LY8TBWDqrYV41BBFB0Em38V
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328094; x=1719932894;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxvSRp3VocyM/CgCZaoDNuJQwjocVwA+KlmzpeRd3EI=;
        b=rno5bGVz4r7PXO3yjsUPpw2R5zFpKw9AHlkG7H6iXZ/uAlUoFyEEQg/eVpTVQsaPLv
         QGFT52miq+1CBYyMv7YprMwlUajcK/moXvQ8xoJfkCAk3WfySd6/InQ0LVP4RBgof5TC
         viF4oxuXHPE/rCiuMH3jwCJuoiwMOYVFoTlF02t0VYqKMALONsIiG3kBh5zCmu9kvCjX
         JpPrrNsaweUzSN3ec6PwPxaaZJ7Y0+xOxF3EPXZkQ/ir72QJA807q2wJ6CEZOZuhFrje
         k8leCVKrrC2RNfT5FUFd5ukIdYBmzjpqzWkYIf1OeR92nn18idxeL+frLdH8tJq4820G
         rfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmXwH6KSzvGLTf04XVxqtxSIkrAbJFEhggpeg8Bk5BCqXF/sic6oKPVfEDUf30cilw/3knhJ9pLuQ70ka6pqlo8dGm6mCQDvEgsa8l3qg=
X-Gm-Message-State: AOJu0YzNCSODs6hGNnnKL65lhxuDxUevUSELI8brUxrvnvxayYsMv0k2
	lY2vS/AVsC5GNPlqjtNc/fk6JaDrpBWiwtZQcHRwYreVA8y8jGifHVhVszqUI5U=
X-Google-Smtp-Source: AGHT+IGGfRNexKwBB81d4AEx65P80T9nljtjnpuSNr0Ap2H4/0adoDw/q8XBnZdMEc09j/I5ZMeh2w==
X-Received: by 2002:a05:600c:16ca:b0:424:745d:f27f with SMTP id 5b1f17b1804b1-4248cc66af8mr51028405e9.37.1719328094096;
        Tue, 25 Jun 2024 08:08:14 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b6bsm219936355e9.32.2024.06.25.08.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:08:13 -0700 (PDT)
Message-ID: <11774366-4264-4e7a-bb7a-ee3d39c60522@suse.com>
Date: Tue, 25 Jun 2024 18:08:12 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Chen Yu <yu.chen.surf@gmail.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
 <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
 <ZnrZI9MtP8PqZzl/@chenyu5-mobl2>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <ZnrZI9MtP8PqZzl/@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.06.24 г. 17:50 ч., Chen Yu wrote:
> On 2024-06-25 at 16:42:11 +0300, Nikolay Borisov wrote:
>>
>>
>> On 25.06.24 г. 15:54 ч., Chen Yu wrote:
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
>>> Set the default value of virt_spin_lock_key to false. If booting in a VM,
>>> enable this key. Later during the VM initialization, if other
>>> high-efficient spinlock is preferred(paravirt-spinlock eg), the
>>> virt_spin_lock_key is disabled accordingly. The relation is described as
>>> below:
>>>
>>> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
>>> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
>>> PV spinlock                    Y    N    N     Y/N
>>>
>>> virt_spin_lock_key             N    N    Y     N
>>>
>>> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>    void __init native_pv_lock_init(void)
>>>    {
>>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>>
>> Actually now shouldn't the CONFIG_PARAVIRT_SPINLOCKS check be retained?
>> Otherwise we'll have the virtspinlock enabled even if we are a guest but
>> CONFIG_PARAVIRT_SPINLOCKS is disabled, no ?
>>
> 
> It seems to be the expected behavior? If CONFIG_PARAVIRT_SPINLOCKS is disabled,
> should the virt_spin_lock_key be enabled in the guest?

No, but if it's disabled and we are under a hypervisor shouldn't the 
virt spinlock be kept disabled? As it stands now everytime we are under 
a hypervisor the virt spinlock is enabled irrespective of the 
PARAVIRT_SPINLOCK config state.

> The previous behavior before commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"): kvm_spinlock_init() is NULL if
> CONFIG_PARAVIRT_SPINLOCKS is disabled, and static_branch_disable(&virt_spin_lock_key)
> can not be invoked, so the virt_spin_lock_key keeps enabled.
> 
> thanks,
> Chenyu
> 
