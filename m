Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1813A88A
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376714; cv=none; b=YtuzZwCRppjrDfO41wWkRRHfBrkjxjmoLGJecUzPwGKYtVnjKGoF44WhqVfND8P64DFvz+T8flfRnWy6esblfVzkEGDCG7HhT+04CaKxZ0GzuubA8dnizOgQKPmk9Ncn6l6tGzgvvcf2gUxAA5gY0ZDkmPWfNpB1wEiqbLfFgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376714; c=relaxed/simple;
	bh=urO9PF41hgll0dRPTGLkmriEDOf5ydq979P37U8+EZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1j3Z3NeLuzWS7INieVKnl1Ijq2nN4KJYXGo0ZkgBW0hc8HJpbaKdc4rQeahWvCjC0/d7XIZhtLGfSLYUDbSxCPJritCQP/ajwnj0IZKeXGwv7+uHObarCdQZ0FEmR+ristmZHsDvPOMSG8pIBhI/f7GtgzZxFEnItM/rr80KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HLIkptkk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HLIkptkk"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so5821123e87.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719376711; x=1719981511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqcce+viBw5891cRDW3KYK3GO/t8otW+H0eaejzqnZ8=;
        b=HLIkptkk2Js141cksuA4gxxG6qpM8i8a9ScolEos9DIAgc38wWbUPmbUN9U7w1Vi2J
         xzZQS5AqEcBReXrlvoYtqfSc0D0CRyPxUm7g8lGxCuBhZUt337RsLX9yIM+mkmjOeyLJ
         fu9/pDTxzLGGApzTR95gZNVb1WwOqNPGwnD/oyDtTxKp6W57FbaDSFXNwbSIJexPO6kw
         ShlAZaBjMGLNeQIKQSxEzCV57y/KKctEiKFci+QZqyn7dcfpD42LCtjZGbn+L9ve83Y1
         2bhTa6BTb+4BhPO8yHwKj7nHqQtb4cGqg+vC+8SuBzK3RkuiQZ7wVn9vm1WWrO4x9Wcj
         yBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719376711; x=1719981511;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqcce+viBw5891cRDW3KYK3GO/t8otW+H0eaejzqnZ8=;
        b=oupmOsBs01J8XG9T7yeHr+MC3ryoUzzSOh21/LzMnbe6Jh/44dF6pfmCYFDnQNFNWq
         qLUe8so6UT1xP9wLL8drIzNW2yI9OOILFSYvyWqnWLcQCnsRuNtcFX0NNPkqPb/2tmeX
         90BlJ+k0n6lpb3rXSKi+6X6eQMAXH/jBJ7gtVTUoWCnPHKkOgQXrSjbyTvZtBTPigCoe
         oXE0YODiVq6IarcgqADrAlVHkluQRKLJWv8FmU4a46cLvF0kzBa+ZD+ub6JaFkggoAST
         HSXUGPwGQQ82jYv2BzIiLlGQb3FXNUzgjQob/g3n3FzX0Q5Cj4Qw3UbpXT2CBmRqJRkg
         ILTw==
X-Forwarded-Encrypted: i=1; AJvYcCV8S174akGmBoQI5zIyB1hq6BqDjrgEP+arz20SyXlOWfV2ij33CQU10Lr3DVBUgbOEpvYQqQh5BbF9OpNGnocufDMwevK0/6O3wicVVUI=
X-Gm-Message-State: AOJu0YytVk95AltBnREyklJN6JJBXfWB7mSt9Pgm6eKVdfrTMoD9gPNO
	jsBdQh7CPscqj/4HxTSIlNDHsR86b+AwMDt2L19QvNGzWz4ehgIOOPMhGAay2hY=
X-Google-Smtp-Source: AGHT+IFmIWttdaTJRAvIH8UrjPds8xvnf85HM29QagGQ7d1YSELkyFRIvS+iI6cQUa86E2mDA3DxXw==
X-Received: by 2002:a05:6512:3da3:b0:52c:e728:cca1 with SMTP id 2adb3069b0e04-52ce728cd5bmr6009512e87.39.1719376710614;
        Tue, 25 Jun 2024 21:38:30 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8285f5csm9826695e9.25.2024.06.25.21.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 21:38:30 -0700 (PDT)
Message-ID: <0844686c-0108-4267-87e0-a79531dbeaf3@suse.com>
Date: Wed, 26 Jun 2024 07:38:28 +0300
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

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
