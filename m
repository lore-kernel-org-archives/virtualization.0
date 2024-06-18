Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94E14D717
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699089; cv=none; b=sZn/r04NsENqueo5AP7LxMMAKyuc1yIFB7yjmZY3kXQKMlmhYNke3Q6zddpbWv3mpP3g9okpFmn5ZfksY9EppuWA6XYm291FwqbJ/eXBv2WHZxeVBhPjZC8vU85ylRpWhuV4TlbgI6+yy1c+XHQjzLh/bl+lMB/+BlU+r+9l1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699089; c=relaxed/simple;
	bh=pbDziqPI/WoS/orp534a2HtadGyFK22CpztY1tUbZh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISAWnaxzqRwRZ0W+m6plCc77DPUj06FTcGDuHcoouEd9Q9vF18rJRcY4BZOhPFoy4JVoIsU+MmrRsEIT043lv/6vOHOiaIElUm1H60AEWFu0nSXTZCMhw1xE0tuNAcP0jKJWQGDdAz3w07hKql60tlDOL4tLFTw7hl8a0ZwGNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WgH2s/dj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WgH2s/dj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so32020435e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718699085; x=1719303885; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdSZOLQOwQN4pDV3GxSPxLcKEx0R6yJdz5wU8m1ZtRM=;
        b=WgH2s/djKC1/37gQDZDgfIvzX18qHptgyC5M29pO+IpraMd4W8QQ8IYqiZqyUJGA5D
         b+7dDFm3KEoLnBm01DzfI1rMyZmO++Bb4tU1UWdvBo5Q9GRgUf3yEDCExSlbtNsZdRHD
         tiGUdlxZo6KKEH34P4gCeR6s7dW7Dl5OPgUQUdHcF9Rv0ErxLcBxa+cPbkrYI+FUKCSi
         qnicpf4Re7857Z5Mg1E09Azv3I4qWgoFmrNjeIOZMge/lHGzvnw4kGJ4BJ3vVXpLdCBj
         4LnLF+Y3RKviPm1w2HqfBORl3JWLOwoMdHybUgSAlMsX7vyByLqYPYsc34GbDSoDFhf4
         KYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699085; x=1719303885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdSZOLQOwQN4pDV3GxSPxLcKEx0R6yJdz5wU8m1ZtRM=;
        b=OdC3mjmsUwWxRkAg4Sehd19hqCmmbFEWnCj/EhBVV03dPl9ZK/W5w06kt+qKbMcsGb
         zapKqOv2cQSC93xp0VjJXhvUDznu7yz1gnOyTrn87pE26H6QO9VZnFr7FZ0qWIhqcBGC
         0y0RavBQyiak+hZOvjprpqVrK1c/w1IsXL9e71UFgjSoppv2J95jnjicSCcH/Qtxgz0x
         nUaz86L3z+rP4INNo0PpxMloW9MHUeMgtGvNAaKIzPya2FtCIYVdvxZEQLhAwgAUtsCd
         ljrH789T0nMNov+bEIaifO9iT+hzAm9fZmEHG+QdSrck7ORTLfgcnPuETCVFBKDRtOVn
         jmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuV9VsO2fu4QOldTp3/erG6KdOTK2kiZ+UcRwUgkcyUxCeiBb9/eepuxErB6ob08Jzbu4oYXPArvgjgN1yVYP9jvUAPoOn0yOaaY/hSMs=
X-Gm-Message-State: AOJu0YzOK8y1CzZTjybMFgWXUHBQttRVLvKMM4o9rTr7KI+/ang0lFwi
	ZgDS85TE84SdkgFLuHrChKcyPZehxrv1FQh43f5AEX0tSIX6mvkrtSLzR6KWTtw=
X-Google-Smtp-Source: AGHT+IEMTh472tGg2TlG1vDvd0yUcn+uDzW2Pp6bl99LkVV30JyfLW2jhEBMA9p2+F9DdNBT2sENKQ==
X-Received: by 2002:a05:600c:4506:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-4246f56d2b6mr15871505e9.1.1718699085348;
        Tue, 18 Jun 2024 01:24:45 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c7e5sm13717250f8f.30.2024.06.18.01.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 01:24:45 -0700 (PDT)
Message-ID: <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
Date: Tue, 18 Jun 2024 11:24:42 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240526015847.14142-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.05.24 г. 4:58 ч., Chen Yu wrote:
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
> Fix this by disabling virt_spin_lock_key if it is on bare metal,
> regardless of CONFIG_PARAVIRT_SPINLOCKS.
> 

nit:

This bug wouldn't have happened if the key was defined FALSE by default 
and only enabled in the appropriate case. I think it makes more sense to 
invert the logic and have the key FALSE by default and only enable it 
iff the kernel is running under a hypervisor... At worst only the 
virtualization case would suffer if the lock is falsely not enabled.
