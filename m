Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB0A48
	for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573429; cv=none; b=B4KcBLLJsA7UtbnhNZ9/U2B0EuJ7yLFMIwIxra6eSl1kY6v1FqHp5KgvpNPoSsThfW5gdIT6zYosh0guyFoaD1JC/y+FoFwAVBvqdDYS/q0O0u4eCJloFH4efglVD+AvWaGy/MFAPM7nkNmJVgUhijLhXK+Ik9vAr/dPn3p6vDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573429; c=relaxed/simple;
	bh=JY998qjQNWwNGLXf2WAsCwsRZCjmE+YbFTuIjSuy7XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4CB5F2UlxKlBK/WEuKW3djPr96I81fOcuCF4ZjOJLi8AmgUnjNndBjH8NO46boVWHo4uRIzGh8JspGJCvITSd9v2N/ars1DI/qYq2KVRql0sVVyEo4Zh3GH8eBw+nepR/nsyeMwkQIQeJSVIcRU91Hi5ESOAIXtooQ8dDisLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PciF5FtQ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PciF5FtQ"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d5e19d18fbso94286539f.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713573427; x=1714178227; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhcLlrujCFL5jsjyr5K82BE+eIjl1NtlFO4BV5YJoss=;
        b=PciF5FtQnqcUTlY7ERtuqSp3KRzlp5fOVVuX4um3DTPWh3eOcTqxBbNdmUtHSVuyAu
         fj/0Dw2s3T+Xslch5wwBZB4f2V/1bZv6uT8fDl95iAyb3SZH5BrhOcXmlbcXfq0WKhvl
         oDwhhH7pC4MdmUCOTXMTKgUHDcW4M+qJ6+8P1iHx+jOBrYVDeoPvpt6oHaDlJ2er3get
         gZ2MILax5Yh7cDZP4dVC3tdacAFyWThTosBU6g0YGcXuCMvjahAUml10AuzZcPZfgYao
         IK3G4E6afmaJKt5NAlH1YxtYSQmVMJAkS1Zbf8UYzpA0/KbdaNOHXCOiTLzoAALTDVpm
         4B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713573427; x=1714178227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhcLlrujCFL5jsjyr5K82BE+eIjl1NtlFO4BV5YJoss=;
        b=W0FMI4l1cZ4WHa5GF1wOAZ4GDDssENM5Wb0RNz77nq6bRYeI3sePc8tGmMmLbvL+IC
         /ebTmz0lVwHH0u8/xdeFy5uczQpc278xOx8BNNJ/sX/Q0k0Xbqbb8UyT0qKwlbJ9YXNd
         BBI5E7ljQ9tbHGU6N9gAJ8+9wggV0iK35l0yUaE40REivQcimLbmvVo0Ug1eZ+EzeJkd
         fs92L7Zib4yzNCzDkpLMCqhjM9rM+I00sMhn6W1sKPUrpXYKlIyMIoAy9nbyzsxmGuFy
         itluMjO71tdjAEnmIy8uene1zb3RKkLIv1A1KPKXsPReRc0MSb7EsBkjrWmfP/k2/WTC
         Ct5w==
X-Forwarded-Encrypted: i=1; AJvYcCVzhx1BFmSW/Jp4q8xyNHfYpGsceBNujIvPMF1QgBcHY3cgAXxPJFbEbRH8dgH6I02kaXkznNJ31+4mhS7GSU3T3BSUpg70kwvRWYMtYeA=
X-Gm-Message-State: AOJu0YwadR4pp3YtFXiKIbjViDtkYXF8SxsEKvc5OcEIFD8tefouD00C
	5hZbse2LHpemp7W8TXIrR3aFBaMnz/vcjKpZswDkMc66QNDSbfMlT29BfpAonQ0=
X-Google-Smtp-Source: AGHT+IHtrgB69K59tQny2VA0fIN2p3RzbXA0ZFndyB8V2oCD/yBJA3LSTlidjs+c33/HgDrnv1SH7A==
X-Received: by 2002:a05:6e02:1588:b0:36b:12f5:14dc with SMTP id m8-20020a056e02158800b0036b12f514dcmr4475746ilu.32.1713573426742;
        Fri, 19 Apr 2024 17:37:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id u4-20020a056638134400b00484c44cf9cbsm953419jad.168.2024.04.19.17.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 17:37:06 -0700 (PDT)
Message-ID: <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
Date: Fri, 19 Apr 2024 19:37:03 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration
 for RV32
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-9-atishp@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240420151741.962500-9-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-04-20 10:17 AM, Atish Patra wrote:
> For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
> to interleave firmware/hardware counters indicies. Even though it's a
> unlikely scenario, handle that case by iterating over all the words
> instead of just using the first word.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index f23501898657..4eacd89141a9 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	int i;
>  
> -	/* No need to check the error here as we can't do anything about the error */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> -		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> +		/* No need to check the error here as we can't do anything about the error */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> +			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
>  }
>  
>  /*
> @@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  					       unsigned long ctr_ovf_mask)
>  {
> -	int idx = 0;
> +	int idx = 0, i;
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
> @@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	struct hw_perf_event *hwc;
>  	u64 init_val = 0;
>  
> -	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> -
> -	/* Start all the counters that did not overflow in a single shot */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
> -		  0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;

This is applying the mask for the first 32 logical counters to the both sets of
32 logical counters. ctr_ovf_mask needs to be 64 bits wide here, so each loop
iteration can apply the correct half of the mask.

Regards,
Samuel

> +		/* Start all the counters that did not overflow in a single shot */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
> +			0, 0, 0, 0);
> +	}
>  
>  	/* Reinitialize and start all the counter that overflowed */
>  	while (ctr_ovf_mask) {

