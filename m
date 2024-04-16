Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162F82860
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256406; cv=none; b=hKMAlDCUz/bu90nVr6Lj11TtNNhXwY6OuRwWfjyUnRzdqp36AelSR1tXNLClbhwphComsnUMR6V5Ilx7iwPlZ5HwTqjayeFw6Bjh3oQaSLmHWWayU4QRBUxcQCqkWv+uSKDK7v6A7JYyOz9ge+i8yKEO7yfkV7WNvzbu6ntgF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256406; c=relaxed/simple;
	bh=1r2dYmGOG85xb9RvVvwdeFQUgSPsmVG5HQTBso1uuLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq2uR+uK4PBpX4vWyzLyj+ZjHMvGYE7Ry1qBFPHupDHVwPYmRQYk+WTJRY9mRkhmPGXGp+9Ap+ztUSWVWKDhHmO6ts5FXpsZxN+0Fs+pWhikx+OvTITod33TK23v7FR3z4F6A44ALksByr4eY8s7+yq6ahAhUuc/UVHr1DI6HTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DGrewAaG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DGrewAaG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so3267170b3a.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713256405; x=1713861205; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TvjvzDX9+vy4W2zxmJXwerRo6Lh0Y1bVDzHJUICCWo=;
        b=DGrewAaGYlpYjtvevfGu+SLrvNxk73/+u+GpmJtASNjYaKhh8YeeGJ0lQrKWpPycTw
         GeYRAHpT7NWlGL1Q1NRj5NsQBX4DBEGkH+z0L48FOs7KmKPxl78qhLK2A70OuDT0LhJx
         76B6FsMrAZISQt4/lgvM+EuZWcWqjuhuZUJLCY/y3eALiiPdaUymXpXTw4Go3Y/nr5dW
         co/8PJFdL0Mc0+7bL6BHDLG2eARtq/OiXRv6NzYIHfPyOXT7kA8Pou3zC5kQAdnP++nT
         ufWSukaJXjMfC8fVdcFwz2zhIkJqDxds20m5WDOw1GugquGy8tJoiAv5gKVjna/pCQED
         FnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256405; x=1713861205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TvjvzDX9+vy4W2zxmJXwerRo6Lh0Y1bVDzHJUICCWo=;
        b=gW5h54LCrwbQ+vGXg0hlnGu0ZDErkbnmHdB8JzSu16BTv7oENQ81DMkaxz2YETOP5Z
         Am5lUPotvcdvq/0fX/8aowRW76ubzDfBnjGvmXrF+o2qsZLtxa1PdSP0ARlRjWRCOTXg
         TRHUIHrnvthYJ4k+hFb3vGablnaqjN+Nu7LtVk07E+09JwAhmpdTt/5ihIjsMHic7+4l
         u0mvkJtZ6vNp5jvWosD2HD1HCM8lT3xC1W1Am/29V6o9G/CPwNzClspJsV3CQh2qIz42
         uyrhIwoTo5U0foh328Z5gv9HV4E5Pw8RnB/qXhSKx4gU19j5LwKC+oX3I3OTGFuR0xw0
         C8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUj8Gq2EMccH/bGjLzUvS5OsitAwUIWztlMMLST/dXFiGK1HYewDPfD7HBp/Wtb4muzf/mQXLosJCTUN/lVFWknz26oNQzl2DTvwcuiEfg=
X-Gm-Message-State: AOJu0Yy4rI5PHzAZ/9RgOLc0AwT9F5yril5hOtyF5rMpP1wWIMKdb6Dn
	WXbkpGqYIy3+4jX/H7l/VU1/IwSP1TDf09VHpH2QcIuNKFwM5gNYbyo9A7TTjH8=
X-Google-Smtp-Source: AGHT+IHrkeBmdYGDSxY9lkjSHA0b7Iv/w+m0cDIN2acr0IYgXgd79F0r3F5ys4RmCJ4iNsyU6E2Lrg==
X-Received: by 2002:a05:6a20:d49b:b0:1a9:c6fd:d2b9 with SMTP id im27-20020a056a20d49b00b001a9c6fdd2b9mr8196272pzb.8.1713256404819;
        Tue, 16 Apr 2024 01:33:24 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78559000000b006e6c0f8ce1bsm8490363pfn.47.2024.04.16.01.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:33:24 -0700 (PDT)
Message-ID: <dd14fc53-deda-4086-aac0-2dde7f065bb0@rivosinc.com>
Date: Tue, 16 Apr 2024 01:33:22 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/24] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Atish Patra <atishp@atishpatra.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-9-atishp@rivosinc.com>
 <20240415-1654deb9446d6c0ebb858b30@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240415-1654deb9446d6c0ebb858b30@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 06:15, Andrew Jones wrote:
> On Wed, Apr 10, 2024 at 05:07:36PM -0700, Atish Patra wrote:
>> SBI v2.0 SBI introduced PMU snapshot feature which adds the following
>> features.
>>
>> 1. Read counter values directly from the shared memory instead of
>> csr read.
>> 2. Start multiple counters with initial values with one SBI call.
>>
>> These functionalities optimizes the number of traps to the higher
>> privilege mode. If the kernel is in VS mode while the hypervisor
>> deploy trap & emulate method, this would minimize all the hpmcounter
>> CSR read traps. If the kernel is running in S-mode, the benefits
>> reduced to CSR latency vs DRAM/cache latency as there is no trap
>> involved while accessing the hpmcounter CSRs.
>>
>> In both modes, it does saves the number of ecalls while starting
>> multiple counter together with an initial values. This is a likely
>> scenario if multiple counters overflow at the same time.
>>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu.c       |   1 +
>>   drivers/perf/riscv_pmu_sbi.c   | 224 +++++++++++++++++++++++++++++++--
>>   include/linux/perf/riscv_pmu.h |   6 +
>>   3 files changed, 219 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>> index b4efdddb2ad9..36d348753d05 100644
>> --- a/drivers/perf/riscv_pmu.c
>> +++ b/drivers/perf/riscv_pmu.c
>> @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>>   		cpuc->n_events = 0;
>>   		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>>   			cpuc->events[i] = NULL;
>> +		cpuc->snapshot_addr = NULL;
>>   	}
>>   	pmu->pmu = (struct pmu) {
>>   		.event_init	= riscv_pmu_event_init,
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index f23501898657..e2881415ca0a 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>   
>>   static bool sbi_v2_available;
>> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>> +#define sbi_pmu_snapshot_available() \
>> +	static_branch_unlikely(&sbi_pmu_snapshot_available)
>>   
>>   static struct attribute *riscv_arch_formats_attr[] = {
>>   	&format_attr_event.attr,
>> @@ -508,14 +511,109 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>>   	return ret;
>>   }
>>   
>> +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>> +
>> +		if (!cpu_hw_evt->snapshot_addr)
>> +			continue;
>> +
>> +		free_page((unsigned long)cpu_hw_evt->snapshot_addr);
>> +		cpu_hw_evt->snapshot_addr = NULL;
>> +		cpu_hw_evt->snapshot_addr_phys = 0;
>> +	}
>> +}
>> +
>> +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
>> +{
>> +	int cpu;
>> +	struct page *snapshot_page;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>> +
>> +		if (cpu_hw_evt->snapshot_addr)
>> +			continue;
>> +
>> +		snapshot_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
>> +		if (!snapshot_page) {
>> +			pmu_sbi_snapshot_free(pmu);
>> +			return -ENOMEM;
>> +		}
>> +		cpu_hw_evt->snapshot_addr = page_to_virt(snapshot_page);
>> +		cpu_hw_evt->snapshot_addr_phys = page_to_phys(snapshot_page);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pmu_sbi_snapshot_disable(void)
>> +{
>> +	struct sbiret ret;
>> +
>> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
>> +			-1, 0, 0, 0, 0);
> 
> The SBI_SHMEM_DISABLE patch got moved in front of this patch, but looks
> like it was forgotten to apply it.
> 

Oops. My bad. Fixed it.

> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

