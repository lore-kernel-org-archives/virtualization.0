Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6387D417
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489605; cv=none; b=o30ofCXtwQJh/8Fm9GgBTBxjMV6Yo6Nnqpmsk3nGmAI8WjdlFzx/AEyzMEgo8mdwikNIet+08BFlq4kr6zlmKxTwgzdm8w0ggTRu0axGcikWop4nscfYRX1nDQcDc8v5TgHOcep7NEP5YxoVz7djCXCjTSYg+rSidt8luVFh4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489605; c=relaxed/simple;
	bh=yRsCEoicgaKzohe9lKyCvRJ8ywpHXjW4YO2bnP2lO30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crhon+mq5COFpNDwVIxp9VBZe1+hAoPyn/o8EPxoWSVyFMskePxLsGuW+nKlWf87szLHm3rCOejg8BV/Ib5NJqYZmcgujgGLl5j70iTUeRYYmULEI4GKPou65gMZ7HJZBfx8iiKVeVcGYO+J8BTgvaDAXSY0XqVmB7/JEudb0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QPIiFTuY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QPIiFTuY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57851af0239so47461a12.2
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716489600; x=1717094400; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPNsSdDaQu0NIT3u7mvtcXRasJFxRX07JUknJPwEvjQ=;
        b=QPIiFTuYG5feJ0KhYXdpSew6z2tCcFr1JeXk71yotom4LtSwmV9VY37Pt5iQUPVH4k
         hzbTqx6A3xMBc3QBsWr41apyHohBEkumtZFoKPyZ8RJ6ecHTd4CJA+Z7+uwBTrjMYgLy
         6v5pdDS30KWJpL1Tg/pRCcVLoLPLA9AKx+Ju8pq5UyfCkKXKp2Xz0haeFSlktljWswIM
         CKvxLouMFk1YBe0uxcwww7JuootN/Rn5c2TlURMxavdYvprAbkTfJ3aETc8E3Z6z7FoT
         nyC6D/jZuDllWx1cWc8AuJ8XMGh+RLi6DrJodyrHbdnkFwuJj4NDrUAPpqttfX7pnwTx
         XJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489600; x=1717094400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPNsSdDaQu0NIT3u7mvtcXRasJFxRX07JUknJPwEvjQ=;
        b=d2uoKLZmdf6D4FwNIAGhAKNyUvC1oTUi6OfuOWt+Cpb548E4zSKt4fda7k3fmlvnKx
         QcxNKfVZ5EaIlTTHB++rlKcwbKn+kQWUJR55WDxnVFKcxSb1b0JeQhXVQinuEnvbZglm
         a4iR0MUQ5/QIOTh6uc1ToDR/UzkQTD4U9tT9/DzPsz7wS0zXoFLgtgoSR66PJXnkh9mg
         Ijx2piYqrdoiQYTXzSIYAkA8tU/xClpYVlr7DiB/9Z+S3xz5lGkRcpsCADeyI5ENU/df
         ZJoS4uXOeHj4QB6IK1PYL0pqns9ubpL1kQ3jITWGcBy5pqmmnXVKljo7CNgff8HhFMw1
         kNSg==
X-Forwarded-Encrypted: i=1; AJvYcCUobYTAnvoBsTe6YqpQ2TG6564yZYioQ78DoJeblNIFUdcfivE1YcMGG1MssfKp9jRmTvhjJK7+aAC9MTmjK6DAp1MQuewx5/KU24DG+mE=
X-Gm-Message-State: AOJu0YzchxI/gBrRMQ4QKW4I32VwC6uNHnp7BCpRDdC+QkGsY+qR1Whw
	Uia0glw7m7iem1fFnVvCi6XzNV7oTY8CKB80cHVRPU1v4Pd2uuaThUgQpxT3kmE=
X-Google-Smtp-Source: AGHT+IFM7nm2N0VSaiUAIdHdhDX4MAHlidFK15butLgqOhVX08TvLNZIrl9+UlWMHnQ9lqjE99W5qw==
X-Received: by 2002:a17:906:e52:b0:a59:cb29:3fb8 with SMTP id a640c23a62f3a-a62641a392fmr12916666b.1.1716489600370;
        Thu, 23 May 2024 11:40:00 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d9dsm1973152566b.132.2024.05.23.11.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:40:00 -0700 (PDT)
Message-ID: <ec8b5d13-3034-4255-ace3-cf1564646da9@suse.com>
Date: Thu, 23 May 2024 20:39:59 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
To: Dave Hansen <dave.hansen@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240516130244.893573-1-yu.c.chen@intel.com>
 <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 18:30, Dave Hansen wrote:
> On 5/16/24 06:02, Chen Yu wrote:
>> Performance drop is reported when running encode/decode workload and
>> BenchSEE cache sub-workload.
>> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
>> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
>> is disabled the virt_spin_lock_key is set to true on bare-metal.
>> The qspinlock degenerates to test-and-set spinlock, which decrease the
>> performance on bare-metal.
>>
>> Fix this by disabling virt_spin_lock_key if CONFIG_PARAVIRT_SPINLOCKS
>> is not set, or it is on bare-metal.
> 
> This is missing some background:
> 
> The kernel can change spinlock behavior when running as a guest.  But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> ... then describe the regression and the fix
> 
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index 5358d43886ad..ee51c0949ed8 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>   
>>   void __init native_pv_lock_init(void)
>>   {
>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>> +	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) ||
>>   	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>   		static_branch_disable(&virt_spin_lock_key);
>>   }
> This gets used at a single site:
> 
>          if (pv_enabled())
>                  goto pv_queue;
> 
>          if (virt_spin_lock(lock))
>                  return;
> 
> which is logically:
> 
> 	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS))
> 		goto ...; // don't look at virt_spin_lock_key
> 
> 	if (virt_spin_lock_key)
> 		return; // On virt, but non-paravirt.  Did Test-and-Set
> 			// spinlock.
> 
> So I _think_ Arnd was trying to optimize native_pv_lock_init() away when
> it's going to get skipped over anyway by the 'goto'.
> 
> But this took me at least 30 minutes of scratching my head and trying to
> untangle the whole thing.  It's all far too subtle for my taste, and all
> of that to save a few bytes of init text in a configuration that's
> probably not even used very often (PARAVIRT=y, but PARAVIRT_SPINLOCKS=n).
> 
> Let's just keep it simple.  How about the attached patch?

Simple indeed. The attachment is empty. :-p


Juergen
